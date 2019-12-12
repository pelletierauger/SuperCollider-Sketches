(
~phaserCluster = {
    var sp = rrand(200000, 800000);
    var note = [-5, 0, 7].choose.midiratio;
    var rateShift = [0.5, 1, 1, 2].choose;
    {
        var freqImp = 24 * note * [1, 1, 1.001, 1.001];
        var envDur = (1 / freqImp) / 2;
        var t = Impulse.ar(freqImp, [0, 0.5, 0, 0.5]);
        var globEnv = EnvGen.ar(Env.new([0, 0.5, 1, 0.5, 0], [5, 5, 5, 15], [2, -2, 2, -2]), doneAction: 2);
        var env = EnvGen.ar(Env.new([0, 1, 0], envDur, [-1, 1]), t);
        var spos = sp;
        var rate = SinOsc.ar(2 * [1, 1.01]).range(1, 1.025) * rateShift;
        var sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
        sig = sig * env * globEnv;
        sig = sig[0] + sig[1];
        Pan2.ar(sig[0], -1, 0.125);
    }.play;
    {
        var freqImp = 24 * note * [1, 1, 1.001, 1.001] * 0.999;
        var envDur = (1 / freqImp) / 2;
        var t = Impulse.ar(freqImp, [0, 0.5, 0, 0.5]);
        var globEnv = EnvGen.ar(Env.new([0, 0.5, 1, 0.5, 0], [5, 5, 5, 15], [2, -2, 2, -2]), doneAction: 2);
        var env = EnvGen.ar(Env.new([0, 1, 0], envDur, [-1, 1]), t);
        var spos = sp;
        var rate = SinOsc.ar(2 * [1, 1.01]).range(1, 1.025) * rateShift;
        var sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t, startPos: spos, doneAction: 2);
        sig = sig * env * globEnv;
        sig = sig[0] + sig[1];
        Pan2.ar(sig[0], 1, 0.125);
    }.play;
};
)