
~buf = Buffer.read(s, "/Volumes/Volumina/backups/2021-05/SuperCollider Recordings/SC_210111_180017.aiff")
"/Users/guillaumepelletier/Music/SuperCollider Recordings/SC_210111_180017.aiff"
~buf.play;
~buf.bufnum
floor(~nT.beats)
var timeNow = ~nT.beats;
~nT.beatsPerBar
~nT.beats;
~nT.nextBar;
(
~nT.schedAbs(~nT.nextBar + 0.5 - 0.12, {
    ~bass.free;
    ~bass = {
        arg rate = 0.125;
        var in, imp, dem, dem2, rs, bf, sig, sig2, st, buf, end, env, trig;
        trig = Impulse.ar(~nT.tempo * 0.0625);
        env = EnvGen.ar(Env.new([0.0, 1, 0.001], [0.7 * 1, 12 * 2], [2, -8]), trig);
        dem = Demand.ar(trig, 0, Dseq((1..8) * 5, inf));
        dem2 = Demand.ar(trig, 0, Dseq([-2, -5, -3, -7].stutter(1).midiratio, inf));
        // dem2 = Demand.ar(trig, 0, Dseq([-2, -5, -9, -12].stutter(2).midiratio, inf));
        // dem2 = Demand.ar(trig, 0, Dseq([-2, -5, -2, -5, -9, -12].stutter(2).midiratio, inf));
        buf = ~buf;
        imp = Impulse.ar(26);
        rate = rate * dem2.lag(0.5) * BufRateScale.ir(buf);
        bf = BufFrames.ir(buf);
        // bf.poll;
        // dem = Demand.ar(imp, 0, Dwhite(0, bf));
        st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
        st = 15000;
        end = st + 79 + 10;
        sig = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end, st), interpolation: 0);
        sig2 = BufRd.ar(2, buf, Phasor.ar(0, rate, st - 2000, end - 2000 - 0.2, st), interpolation: 0);
        // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));

        // sig * 10;
        sig = sig + sig2 * env;
        // sig = sig * env;
        sig = VadimFilter.ar(sig * 0.5, 2500 * env + 100, 0, 1);
        sig * 1.1 * 3 * 4;
    }.play(fadeTime: 0);
});
)

(
z.free;
z = {
    arg rate = 1;
    var in, imp, dem, dem2, rs, bf, sig, sig2, st, buf, end, env, trig;
    trig = Impulse.ar(0.25);
    env = EnvGen.ar(Env.new([0.001, 1, 0.001], [2, 6.5], \exp!2), trig).lag(1);
    dem = Demand.ar(trig, 0, Dseq((1..8) * 5, inf));
    dem2 = Demand.ar(trig, 0, Dseq([140], inf));
    buf = ~buf;
    imp = Impulse.ar(31);
    rate = rate * -9.midiratio * BufRateScale.ir(buf) + (SinOsc.ar(3).unipolar * 0.02 * (1 - env));
    bf = BufFrames.ir(buf);
    // bf.poll;
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
    st = 15000 + dem;
    end = st + dem2;
    env = (1 - (SinOsc.ar(1).unipolar * 0.1));
    sig = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end + ((0..10)*4 * (1 - env)), st), interpolation: 0);
    // sig2 = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end - 1, st), interpolation: 0);
    // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));

    // sig * 10;
    // sig.size.poll;
    sig = DelayN.ar(sig, 3, ((0..10)/25), 1, 0) * 1;
    sig = Splay.ar(sig.flat, 1 - env);
    // sig = sig.sum;
    // sig = sig + sig2;
    sig = VadimFilter.ar(sig * 0.5, 2000 + (1000 * env) + 3000, 0, 1);
    // sig =
    sig * 4 * 4;
}.play(fadeTime: 0);
)



(
~nT.schedAbs(~nT.nextBar + 0.5, {
    o.free;
    o = {
        arg rate = 1;
        var in, imp, dem, dem2, rs, bf, sig, sig2, st, buf, end, env, trig;
        trig = Impulse.ar(~nT.tempo * 0.125 * 0.25);
        env = EnvGen.ar(Env.new([0.001, 1, 0.001], [2, 6.5], \exp!2), trig).lag(1);
        dem = Demand.ar(trig, 0, Dseq((1..8) * 5, inf));
        dem2 = Demand.ar(trig, 0, Dseq([30], inf));
        buf = ~buf;
        imp = Impulse.ar(31);
        rate = rate * -9.midiratio * BufRateScale.ir(buf) + (SinOsc.ar(3).unipolar * 0.02 * (1 - env));
        bf = BufFrames.ir(buf);
        // bf.poll;
        // dem = Demand.ar(imp, 0, Dwhite(0, bf));
        st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
        st = 15000 + dem;
        end = st + dem2;
        sig = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end + ((0..10)/0.125), st), interpolation: 0);
        // sig2 = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end - 1, st), interpolation: 0);
        // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));

        // sig * 10;
        // sig.size.poll;
        sig = DelayN.ar(sig, 3, ((0..10)/25), 1, 0) * 1;
        sig = Splay.ar(sig.flat, 1 - env);
        // sig = sig.sum;
        // sig = sig + sig2;
        sig = VadimFilter.ar(sig * 0.5, 2000 + (1000 * env) + 3000, 0, 1);
        // sig =
        sig * 4 * 3 * env;
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