
~buf = Buffer.read(s, "/Users/guillaumepelletier/Music/SuperCollider Recordings/SC_210111_180017.aiff")
"/Users/guillaumepelletier/Music/SuperCollider Recordings/SC_210111_180017.aiff"
~buf.play;
~buf.bufnum
(
~one.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.25 + (t.beatDur * 0), {
~one = {
    arg rate = 1;
    var in, imp, dem, rs, bf, sig, sig2, st, buf, end, env, trig;
    trig = Impulse.ar(1 / (~nT.beatDur * 5));
    env = EnvGen.ar(Env.new([0.001, 1, 0.001], [0.005, 9], \exp!2), trig);
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
    sig * 2 * env;
}.play(fadeTime: 0);
});
)

(
~two.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.25 + (~nT.beatDur * 0), {
~two = {
    arg rate = 1;
    var in, imp, dem, dem2, dem3, rs, bf, sig, sig2, st, buf, end, env, trig;
    trig = Impulse.ar(1 / (~nT.beatDur * 5));
    dem = Demand.ar(trig, 0, Dseq((1..8) * 5, inf));
    dem2 = Demand.ar(trig, 0, Dseq([120], inf));
        // dem3 = Demand.ar(trig, 0, Dseq([1, 0, 1, 0, 0], inf));
        // trig = trig * dem3;

    env = EnvGen.ar(Env.new([0.001, 1, 0.001], [0.005, 9.5], \exp!2), trig);
    buf = ~buf;
    imp = Impulse.ar(31);
    rate = rate * BufRateScale.ir(buf);
    bf = BufFrames.ir(buf);
    // bf.poll;
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
    st = 15000 + dem;
    end = st + dem2;
    sig = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end, st), interpolation: 0);
    sig2 = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end - 1, st), interpolation: 0);
    // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));

    // sig * 10;
    sig = sig + sig2;
    sig = LPF.ar(sig * 0.5, 2000 + (1000 * env));
    sig * 2 * env;
}.play(fadeTime: 0);
    });
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