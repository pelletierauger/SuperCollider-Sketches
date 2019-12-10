Env.new([0, 0.5, 1, 0.5, 0], [5, 5, 5, 15], [2, -2, 2, -2]).plot;

b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/0002 7-Audio.aif");
(
{
    var freqImp = 55 * 4.midiratio;
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