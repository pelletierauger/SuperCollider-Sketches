Env.new([0, 0.5, 1, 0.5, 0], [5, 5, 5, 15], [2, -2, 2, -2]).plot;

b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/0001 7-Audio.aif");
b.numChannels
b.numFrames
7144448
(
{
    var freqImp = 4 * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t1 = Impulse.ar(freqImp, 0);
    var t2 = Impulse.ar(freqImp, 0.5);
    var env1 = EnvGen.ar(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t1);
    var env2 = EnvGen.ar(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t2);
    var less = Duty.kr(Dseq([4],inf), 0, Dseq([25e4, 45e4], inf));
    var spos = 850776 - less;
    var rate = 0.midiratio * SinOsc.kr(0.5).range(1, 1.01);
    var sig1 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t1, startPos: spos);
    var sig2 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t2, startPos: spos);
    // sig = sig[0] + sig[1];
    sig1 = sig1 * env1;
    sig2 = sig2 * env2;
    // sig1 = sig[0] + sig[1];
    // sig;
    sig1 + sig2;
    // sig1;
    // Pan2.ar(sig[0], 0, 1);
    // sig[0] + sig[1];
}.play;
)

25e4

(
{
    var freqImp = 4 * 0.midiratio;
    var freqImp2 = freqImp * 1.01;
    var envDur = ((1 / freqImp) / 3)!3;
    var envDur2 = ((1 / freqImp2) / 3)!3;
    var t = Impulse.ar(freqImp, [0, 0.5]);
    var t2 = Impulse.ar(freqImp2, [0, 0.5]);
    var env = EnvGen.ar(Env.new([0, 1, 1, 0], envDur, [-1, 1]), t);
    var env2 = EnvGen.ar(Env.new([0, 1, 1, 0], envDur2, [-1, 1]), t);
    var spos = 620776;
    var rate = -12.midiratio * SinOsc.kr(0.1).range(1, 1.01);
    var sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
    var sig2 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t2, startPos: spos, doneAction: 2);
    sig = sig * env;
    sig2 = sig2 * env2;
    Balance2.ar(sig[0] + sig[1], sig2[0] + sig2[1], 0, 1);
    // sig;
}.play;
)
b.numFrames
1047552/2

1/22

1 / [1, 2, 3]
(
{
    var freqImp = 24 * 7.midiratio * [1, 1, 1.001, 1.001];
    var envDur = (1 / freqImp) / 2;
    var t = Impulse.ar(freqImp, [0, 0.5, 0, 0.5]);
    var env = EnvGen.ar(Env.new([0, 1, 0], envDur, [-1, 1]), t);
    // var sig = SinOsc.ar(440) * 0.1 * env;
    var spos = 440776;
    var rate = SinOsc.ar(2 * [1, 1.01]).range(1, 1.025) * 0.midiratio;
    var sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
    // sig = sig[0] + sig[1];
    // sig = sig * env;
    // var sigA, sigB;
    sig = sig * env;
    // sigA = sig[0] + sig[1];
    // sigB = sig[2] + sig[3];
    // sig = sig * 1 * env;
    // sig[0] + sig[1];
    // sig;
    // sig[2] + sig[3];
    // sig;
    // Balance2.ar(sigA, sigB);
    // sig;
    Balance2.ar(sig[0] + sig[1], sig[2] + sig[3], 0, 1);
    // Out.ar(0, sig);
}.play;
)


[1, 4] * [2, 2, 3, 3]



(
{
    var freqImp = 52 * 0.midiratio;
    var envDur = ((1 / freqImp) / 2)!2;
    var t = Impulse.ar(freqImp, [0, 0.5]);
    var env = EnvGen.ar(Env.new([0, 1, 0], envDur, [-1, 1]), t);
    var sig = SinOsc.ar(440) * 0.1 * env;
    var spos = 560776;
    var rate = 0.midiratio;
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
    // sig = sig[0] + sig[1];
    sig = sig * 1 * env;
    sig[0] + sig[1];
    // sig;
}.play;
)




(
{
    var freqImp = 24 * 0.midiratio * [1, 1, 1.001, 1.001];
    var envDur = (1 / freqImp) / 2;
    var t = Impulse.ar(freqImp, [0, 0.5, 0, 0.5]);
    var env = EnvGen.ar(Env.new([0, 1, 0], envDur, [-1, 1]), t);
    // var sig = SinOsc.ar(440) * 0.1 * env;
    var spos = 600776;
    var rate = SinOsc.ar(2 * [1, 1.01]).range(1, 1.025) * 0.midiratio;
    var sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
    // sig = sig[0] + sig[1];
    // sig = sig * env;
    // var sigA, sigB;
    sig = sig * env;
    // sigA = sig[0] + sig[1];
    // sigB = sig[2] + sig[3];
    // sig = sig * 1 * env;
    // sig[0] + sig[1];
    // sig;
    // sig[2] + sig[3];
    // sig;
    // Balance2.ar(sigA, sigB);
    // sig;
    Balance2.ar(sig[0] + sig[1], sig[2] + sig[3], 0, 1);
    // Out.ar(0, sig);
}.play;
)



(
{
    var freqImp = 24 * -5.midiratio * [1, 1, 1.001, 1.001];
    var envDur = (1 / freqImp) / 2;
    var t = Impulse.ar(freqImp, [0, 0.5, 0, 0.5]);
    var globEnv = EnvGen.ar(Env.new([0, 1, 0], [5, 5]), doneAction: 2);
    var env = EnvGen.ar(Env.new([0, 1, 0], envDur, [-1, 1]), t);
    // var sig = SinOsc.ar(440) * 0.1 * env;
    var spos = 520776;
    var rate = SinOsc.ar(2 * [1, 1.01]).range(1, 1.025) * 0.midiratio;
    var sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
    // sig = sig[0] + sig[1];
    // sig = sig * env;
    // var sigA, sigB;
    sig = sig * env * globEnv;
    // sigA = sig[0] + sig[1];
    // sigB = sig[2] + sig[3];
    // sig = sig * 1 * env;
    // sig[0] + sig[1];
    // sig;
    // sig[2] + sig[3];
    // sig;
    // Balance2.ar(sigA, sigB);
    // sig;
    Balance2.ar(sig[0] + sig[1], sig[2] + sig[3], 0, 1);
    // Out.ar(0, sig);
}.play;
)


rrand(0, 2000)
(
~phaserCluster = {
    var sp = rrand(200000, 800000);
    var note = [-5, 0, 7].choose.midiratio;
    {
        var freqImp = 24 * note * [1, 1, 1.001, 1.001];
        var envDur = (1 / freqImp) / 2;
        var t = Impulse.ar(freqImp, [0, 0.5, 0, 0.5]);
        var globEnv = EnvGen.ar(Env.new([0, 0.5, 1, 0.5, 0], [5, 5, 5, 15], [2, -2, 2, -2]), doneAction: 2);
        var env = EnvGen.ar(Env.new([0, 1, 0], envDur, [-1, 1]), t);
        // var sig = SinOsc.ar(440) * 0.1 * env;
        var spos = sp;
        var rate = SinOsc.ar(2 * [1, 1.01]).range(1, 1.025);
        var sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
        // sig = sig[0] + sig[1];
        // sig = sig * env;
        // var sigA, sigB;
        sig = sig * env * globEnv;
        // sigA = sig[0] + sig[1];
        // sigB = sig[2] + sig[3];
        // sig = sig * 1 * env;
        // sig[0] + sig[1];
        // sig;
        // sig[2] + sig[3];
        // sig;
        // Balance2.ar(sigA, sigB);
        // sig;
        Balance2.ar(sig[0] + sig[1], sig[2] + sig[3], 0, 1);
    }.play;
};
)
~phaserCluster.();
(
~phaserClusters = Task {
{~phaserCluster.(); [2, 4].choose.wait;}.loop;}.start;
)
~phaserClusters.stop;