~bayou = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création\ musicale/Samples/Synth\ bayou\ 001tuned.aif");


(
SynthDef(\bayou, {
    arg buf = ~bayou, rate = 1, spos = 0, pan = 1, amp = 1, sus = 0.75;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.1, 0.15, sus]), doneAction: 2);
    sig = PlayBuf.ar(2, ~bayou, rate * BufRateScale.ir(buf) / 329.63, startPos: 0);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(0, sig);
}).add;
)

(
                    Synth.new(\bayou, [
                        \rate: (a[0] + 40).midicps * 24.midiratio,
                        \sus: ~sus, \pan: -1.1.rand2]);
)