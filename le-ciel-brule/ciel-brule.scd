
~buf = Buffer.read(s, "/Volumes/Volumina/backups/2021-05/SuperCollider Recordings/SC_210111_180017.aiff");

"/Users/guillaumepelletier/Music/SuperCollider Recordings/SC_210111_180017.aiff"
~buf.play;
~buf.bufnum;

~nT = TempoClock.new(3.5).permanent_(true);

(
y.free;
y = {
    arg rate = 1;
    var in, imp, dem, rs, bf, sig, sig2, st, buf, end, env, trig;
    trig = Impulse.ar(1);
    env = EnvGen.ar(Env.new([0.001, 1, 0.001], [0.005, 2], \exp!2), trig);
    dem = Demand.ar(trig, 0, Dseq((1..8) * 5, inf));
    buf = ~buf;
    imp = Impulse.ar(31);
    rate = rate * BufRateScale.ir(buf);
    bf = BufFrames.ir(buf);
    // bf.poll;
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
    st = 15000 + dem;
    end = st + 79 + 10;
    sig = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end, st), interpolation: 0);
    sig2 = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end - 1, st), interpolation: 0);
    // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));

    // sig * 10;
    sig = sig + sig2;
    sig = LPF.ar(sig * 0.5, 2500);
    sig * 4 * env;
}.play(fadeTime: 0);
)

(
z.free;
z = {
    arg rate = 1;
    var in, imp, dem, dem2, rs, bf, sig, sig2, st, buf, end, env, trig;
    trig = Impulse.ar(1);
    env = EnvGen.ar(Env.new([0.001, 1, 0.75, 0.001], [0.03, 0.1, 3.5], [-8, -8, -8]), trig);
    dem = Demand.ar(trig, 0, Dseq((1..8) * 5, inf));
    dem2 = Demand.ar(trig, 0, Dseq([120], inf));
    buf = ~buf;
    imp = Impulse.ar(31);
    rate = rate * 0.midiratio * BufRateScale.ir(buf);
    bf = BufFrames.ir(buf);
    // bf.poll;
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
    st = 15000;
    end = st + 120;
    sig = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end, st), interpolation: 0);
    sig2 = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end - 1, st), interpolation: 0);
    // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));

    // sig * 10;
    sig = sig + sig2;
    sig = VadimFilter.ar(sig * 0.5, 2000 + (1000 * env), 0, 1);
    sig * 1 * env;
}.play(fadeTime: 0);
)


(
SynthDef(\muds,  {
    arg rate = 1, note = 0, detune = -1, atk = 0.03, dec = 3.5, muu = 1, amp = 1, lpf = 5000, faa = 1;
    var in, imp, dem, dem2, rs, bf, sig, sig2, st, buf, end, env, trig, lfo, dif;
    trig = Impulse.ar(0);
    env = EnvGen.ar(Env.new([0.001, 1, 0.75, 0.001], [atk, 0.1, dec], [-8, -8, -8]), doneAction: 2);
    dem = Demand.ar(trig, 0, Dseq((1..8) * 5, inf));
    dem2 = Demand.ar(trig, 0, Dseq([120], inf));
    buf = ~buf;
    imp = Impulse.ar(31);
    rate = rate * note.midiratio * BufRateScale.ir(buf);
    bf = BufFrames.ir(buf);
    // bf.poll;
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
    st = 15000;
    end = st + (120 * muu);
    dif = 2000;
    sig = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end, st), interpolation: 0);
    sig2 = BufRd.ar(2, buf, Phasor.ar(0, rate, st - dif, end - dif + detune, st), interpolation: 0);
    // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));

    // sig * 10;
    sig = sig + sig2;
    sig = VadimFilter.ar(sig * 0.5, lpf + (1000 * env), 0, 1);
    lfo = SinOsc.kr(~nT.tempo * 0.5 * faa, pi * 1.5).unipolar;
    sig = (sig * 0.5) + (VadimFilter.ar(sig, 400 + (1000 * lfo), 0, 5) * 1);
    // sig * 1 * env;
    Out.ar(0, sig * env * 2 * amp);
}).add;
)


(
~nT.schedAbs(~nT.nextBar - 0.1, {
~muds2.stop;
~muds2 = Pbind(
    \instrument, \muds,
    \dur, Pseq([0.025, 1.5, 1.5, 0.975] * 1, inf),
    \note, Pseq(
        [0, 3, 2, -5] ++ [0, 3, 5, -5]
        // [0, 3, -2, -5] ++ [0, 3, -3, -5]
        , inf),
    \detune, 0.5 * Pseq([4, 4, 4, 1], inf),
    \muu, 1,
    \dec, 3.5,
    \amp, 1,
    \lpf, Pseq([5000, 5000, 5000, 4000], inf),
    \faa, Pseq([1, 1, 1, 2], inf)
    // \detune, Pseq(Pseries(0.4, 1/4, 4).asStream.nextN(4).reverse, inf)
).play(~nT, quant: [4]);
});
)
(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \muds,
    \dur, Pseq([1], inf),
    \note, Pseq([-12], inf),
    \detune, 0.5 * Pseq([8, 4, 4, 4], inf) * Pseq([1, 2].stutter(8), inf),
    \dec, 0.0625,
    \atk, 0.05,
    \muu, 0.25,
    \amp, 3
    // \detune, Pseq(Pseries(0.4, 1/4, 4).asStream.nextN(4).reverse, inf)
).play(~nT, quant: [4, -0.05]);
)








(
x.free;
x = {
    arg buf = ~buf, rate = 1;
    var in, imp, dem, rs, bf, sig, st, env, note;
    note = 220 * (-0 - 0).midiratio;
    imp = Impulse.ar(note);
    env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 4], [-8, -8]), doneAction: 2).lag(0.2);
    env = env * PinkNoise.ar(1!2).range(0.1, 1).lag(0.01);
    rate = rate * BufRateScale.ir(buf);
    bf = BufFrames.ir(buf);
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
    sig = BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, st));
    // sig = sig + (CombL.ar(sig, 0.05, (note * -5.midiratio * [1.001, 1]).reciprocal, 3) * 0.25);
    // sig = sig + (CombL.ar(sig, 0.05, (note * 7.midiratio * [1, 1.001]).reciprocal, 3) * 0.125 * 0.7);
    // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));
    // LPF.ar(sig * env * 10, 2000);
    sig * env * 4;
}.play;
)

(
{
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 2], [-8, -8]), doneAction: 2).lag(0.2);
    env * PinkNoise.ar(1!2).range(0.1, 1).lag(0.01);
}.plot(3);
)




{SinOsc.ar(110!2 * 3.midiratio) * 0.4}.play