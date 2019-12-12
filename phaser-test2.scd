b = Buffer.read(s, "/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/374284__samulis__upright-piano-e-3-player-dyn1-rr1-016.wav");

b.numFrames;
(
var freq = 0.midiratio * 0.midiratio;
var freqP = 4;
var loc = 621034 - 2000;
{
    var freqImp = freqP * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t = Impulse.ar(freqImp, [0, 0.5]);
    var env = EnvGen.ar(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t);
    var sig = SinOsc.ar(440) * 0.1 * env;
    var spos = loc;
    var rate = freq * SinOsc.ar(2 * [1, 1.01]).range(1, 1.00125);
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
    // sig = sig[0] + sig[1];
    sig = sig * 10 * env;
    sig = sig[0] + sig[1];
    // sig;
    Pan2.ar(sig[0], 1, 1);
    // sig[0] + sig[1];
}.play;
{
    var freqImp = freqP * 0.midiratio * 1.01;
    var envDur = ((1 / freqImp) / 3)!3;
    var t = Impulse.ar(freqImp, [0, 0.5]);
    var env = EnvGen.ar(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t);
    var sig = SinOsc.ar(440) * 0.1 * env;
    var spos = loc;
    var rate = freq * SinOsc.ar(2 * [1, 1.01]).range(1, 1.00125);
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
    // sig = sig[0] + sig[1];
    sig = sig * 10 * env;
    sig = sig[0] + sig[1];
    // sig;
    Pan2.ar(sig[0], -1, 1);
    // sig[0] + sig[1];
}.play;
)
