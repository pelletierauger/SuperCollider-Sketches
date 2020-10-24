
~buf = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/piano-loop-2-quiet-2-48kh.aiff")

(
// y.free;
y = {
    arg buf = ~buf, rate = 1;
    var in, imp, dem, rs, bf, sig, st;
    imp = Impulse.ar(220 * 7.midiratio);
    rate = rate * BufRateScale.ir(buf);
    bf = BufFrames.ir(buf);
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.22 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
    sig = BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, st));
    // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));
    LPF.ar(sig * 0.5, 2000);
    // sig * 10;
}.play;
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