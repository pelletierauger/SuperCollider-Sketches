b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/0001 7-Audio.aif");
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/0001 7-Audio-propre.wav");
b = Buffer.read(s, "/Users/guillaumepelletier/Downloads/mercedes sosa - 1971 - homenaje a violeta parra/02 gracias a la vida.wav");
c = Buffer.read(s, "/Users/guillaumepelletier/Downloads/CS 14 - florian voelxen & mladen franko - reflective moods/a1 - reflective moods.wav");



b.numChannels
b.numFrames
7144448
(
{
    var freqImp = 4 * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t1 = Impulse.kr(freqImp, 0);
    var t2 = Impulse.kr(freqImp, 0.5);
    var env1 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t1);
    var env2 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t2);
    var less = Duty.kr(Dseq([4],inf), 0, Dseq([25e4, 45e4], inf));
    var dem = Demand.kr(t1, 0, Dwhite(-200, 200, inf) * 30).floor;
    var spos = 850776 + 79000 + dem;
    var rate = 0.midiratio * SinOsc.kr(0.125).range(1, 1.01);
    var sig1 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t1, startPos: spos);
    var sig2 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t2, startPos: spos);
    // sig = sig[0] + sig[1];
    sig1 = sig1 * env1;
    sig2 = sig2 * env2;
    // sig1 = sig[0] + sig[1];
    // sig;
    sig1 + sig2 * 1;
    // sig1;
    // Pan2.ar(sig[0], 0, 1);
    // sig[0] + sig[1];
}.play;
)


b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/0001 7-Audio.aif");
b.numChannels
b.numFrames
7144448
(
{
    var freqImp = 4 * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t1 = Impulse.kr(freqImp, 0);
    var t2 = Impulse.kr(freqImp, 0.5);
    var env1 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t1);
    var env2 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t2);
    var less = Duty.kr(Dseq([4],inf), 0, Dseq([46e3, 45e4], inf));
    var dem = Demand.kr(t1, 0, Dwhite(-200, 200, inf) * 30).floor;
    var spos = 1150776 - less + dem;
    var rate = 0.midiratio * SinOsc.kr(0.25).range(1, 1.01);
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


(
{
    var freqImp = 4 * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t1 = Impulse.kr(freqImp, 0);
    var t2 = Impulse.kr(freqImp, 0.5);
    var env1 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t1);
    var env2 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t2);
    var less = Duty.kr(Dseq([4],inf), 0, Dseq([134e3, -2e3], inf));
    var dem = Demand.kr(t1, 0, Dwhite(-200, 200, inf) * 10).floor;
    var spos = 1450776 - less + dem;
    var rate = 0.midiratio * SinOsc.kr(0.125).range(1, 1.01);
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



(
{
    var freqImp = 4 * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t1 = Impulse.kr(freqImp, 0);
    var t2 = Impulse.kr(freqImp, 0.5);
    var env1 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t1);
    var env2 = EnvGen.kr(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t2);
    var less = Duty.kr(Dseq([4],inf), 0, Dseq([5e3, 2e3], inf));
    var dem = Demand.kr(t1, 0, Dwhite(-200, 200, inf) * 10).floor;
    var spos = 50776 - less + dem;
    var rate = 0.midiratio * SinOsc.kr(0.125).range(1, 1.01);
    var sig1 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t1, startPos: spos);
    var sig2 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t2, startPos: spos);
    // sig = sig[0] + sig[1];
    sig1 = sig1 * env1;
    sig2 = sig2 * env2;
    // sig1 = sig[0] + sig[1];
    // sig;
    sig1 + sig2 * 2;
    // sig1;
    // Pan2.ar(sig[0], 0, 1);
    // sig[0] + sig[1];
}.play;
)




(
{
    var freqImp = 8 * 0.midiratio * 1;
    var envDur = ((1 / freqImp) / 3)!3;
    var t1 = Impulse.ar(freqImp, 0);
    var t2 = Impulse.ar(freqImp, 0.5);
    var env1 = EnvGen.ar(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t1);
    var env2 = EnvGen.ar(Env.new([0, 1, 1, 0], envDur, [-1, 1, 1]), t2);
    // var less = Duty.kr(Dseq([4],inf), 0, Dseq([-95e3, -2e3], inf));
    // var dem = Demand.kr(t1, 0, Dwhite(-200, 200, inf) * 10).floor;
    var dem = Demand.kr(Impulse.kr(freqImp, 0), 0, Dwhite(-200, 200, inf) * 100).floor;
    var spos = 850776 + dem;
    var rate = 0.midiratio * SinOsc.kr(0.125).range(1, 1.01);
    var sig1 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t1, startPos: spos);
    var sig2 = PlayBuf.ar(2, b, rate * BufRateScale.ir(b), trigger: t2, startPos: spos);
    // sig = sig[0] + sig[1];
    sig1 = sig1 * env1;
    sig2 = sig2 * env2;
    // sig1 = sig[0] + sig[1];
    // sig;
    sig1 + sig2 * 2;
    // sig1;
    // Pan2.ar(sig[0], 0, 1);
    // sig[0] + sig[1];
}.play;
)