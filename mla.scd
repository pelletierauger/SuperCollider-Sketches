(
{
    var freqImp = 4 * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t1 = Impulse.kr(freqImp, 0);
    var t2 = Impulse.kr(freqImp, 0.5);
    var env1 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t1);
    var env2 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t2);
    var less = Duty.kr(Dseq([4],inf), 0, Dseq([455e3, 45e4], inf));
    var dem = Demand.kr(t1, 0, Dwhite(-200, 200, inf) * 30).floor;
    var spos = 5150776 - less + dem;
    var rate = 0.midiratio * SinOsc.kr(0.25).range(1, 1.01);
    var sig1 = PlayBuf.ar(2, c, rate * BufRateScale.ir(c), trigger: t1, startPos: spos);
    var sig2 = PlayBuf.ar(2, c, rate * BufRateScale.ir(c), trigger: t2, startPos: spos);
    // sig = sig[0] + sig[1];
    sig1 = sig1 * env1;
    sig2 = sig2 * env2;
    // sig1 = sig[0] + sig[1];
    // sig;
    sig1 + sig2 * 0.25;
    // sig1;
    // Pan2.ar(sig[0], 0, 1);
    // sig[0] + sig[1];
}.play;
)
c.numFrames


(
{
    var freqImp = 4 * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t1 = Impulse.kr(freqImp, 0);
    var t2 = Impulse.kr(freqImp, 0.5);
    var env1 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t1);
    var env2 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t2);
    var less = Duty.kr(Dseq([4],inf), 0, Dseq([455e3, 45e4], inf));
    var dem = Demand.kr(t1, 0, Dwhite(-200, 200, inf) * 30).floor;
    var spos = 7150776 - less + dem;
    var rate = 0.midiratio * SinOsc.kr(0.25).range(1, 1.01);
    var sig1 = PlayBuf.ar(2, c, rate * BufRateScale.ir(c), trigger: t1, startPos: spos);
    var sig2 = PlayBuf.ar(2, c, rate * BufRateScale.ir(c), trigger: t2, startPos: spos);
    // sig = sig[0] + sig[1];
    sig1 = sig1 * env1;
    sig2 = sig2 * env2;
    // sig1 = sig[0] + sig[1];
    // sig;
    sig1 + sig2 * 0.25;
    // sig1;
    // Pan2.ar(sig[0], 0, 1);
    // sig[0] + sig[1];
}.play;
)