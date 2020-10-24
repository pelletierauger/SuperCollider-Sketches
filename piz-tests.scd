b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Samples/guitare_A.aif");

(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0, susTime = 1;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susTime, rel], [-8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, -5.midiratio * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    sig = LPF.ar(sig, 2000);
    sig = PitchShift.ar(sig, 0.2, rate, 0, 0.000);
    Out.ar(out, sig * 4);
}).add;
)

(
~piz.stop;
~piz = Pbind(
	\instrument, \sampler,
	\dur, Pseq([1], inf),
    \atk, 0.001,
    \rel, 3,
    \susTime, 0.1,
    \spos, 0.05,
    \rate, Pseq([0, -5].midiratio.stutter(4), inf),
    // \rate, Pseq([1], inf),
    \buf, b,
    \amp, 1.5
).play;
)
"/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Samples/guitare_A.aif"