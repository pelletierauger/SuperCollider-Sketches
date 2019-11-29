
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/accords.wav");


(
SynthDef(\sampler, {
    arg buf = ~accords, rate = 1, spos = 0, pan = 0, amp = 1, out = ~limitBus;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([1, 0], [8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * amp * 6 * env;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


~accordsfinaux = Synth.new(\sampler, [\out, 0, \amp, 2]);