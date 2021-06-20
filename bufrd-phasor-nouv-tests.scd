
~buf = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/piano-loop-2-quiet-2-48kh.aiff")
~buf.play;
s.sendMsg(\b_allocRead, 11, "/Users/guillaumepelletier/Desktop/La beauté de 2021/0006 4-Audio-court.wav");



1:48:185
108.185 * 44100
108.204 * 44100

2,35,826
155.826 * 44100
.... 2,35,845
(
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    arg buf = 11, rate = 1;
    var in, imp, dem, rs, bf, sig, st, end, trig;
    imp = Impulse.ar(100 * -7.midiratio);
    trig = Impulse.ar(1);
    dem = Demand.ar(trig, 0, Dseq(2 * [0, 5, 7].midiratio, inf));
    rate = rate * BufRateScale.ir(buf) * dem;
    bf = BufFrames.ir(buf);
    // rate.poll;
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.1 + SinOsc.ar(0.05 * [1, 1]).range(0.0, 0.000) * bf;
    // st =
    st = 155.826 - 30 * 44100;
    end = 155.845 - 30 * 44100;
    sig = BufRd.ar(2, buf, Phasor.ar(0, rate, st, end, st), interpolation: 1);
    // sig = BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, st), interpolation: 4);
    // sig = sig + BufRd.ar(2, buf, Phasor.ar(imp, rate, st, bf, 0.22 * bf));
    sig = LPF.ar(sig * 1, 800);
    sig * 1;
}.play;
)


(
x.free;
x = {
    arg buf = 11, rate = 1;
    var in, imp, dem, rs, bf, sig, st, env, note;
    note = 220 * (-0 - 0).midiratio;
    imp = Impulse.ar(note);
    env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 4], [-8, -8]), doneAction: 2).lag(0.2);
    env = env * PinkNoise.ar(1!2).range(0.1, 1).lag(0.01);
    rate = rate * BufRateScale.ir(buf);
    bf = BufFrames.ir(buf);
    // dem = Demand.ar(imp, 0, Dwhite(0, bf));
    st = 0.4 + SinOsc.ar(0.05 * [1, 1.1]).range(0.0, 0.0001) * bf;
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