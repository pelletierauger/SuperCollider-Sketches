s.boot;

(
SynthDef(\fm, {
	arg freq = 440, pan = 0, out = 0, amp = 1, sus = 2, freqMod = 3;
	var sig, osc, sig2, sig3, sig4, env;
	sig = SinOsc.ar([freq, freq + 1]) * 0.1;
    osc = SinOsc.ar(freqMod, 1.5, 0.25, 1);
    sig2 = SinOsc.ar([freq, freq + 1] * 2) * 1 * 1.005;
    sig3 = LFTri.ar([freq, freq + 1] * 2.01 * 0.5);
    sig4 = LFSaw.ar([freq, freq + 1] * 1.005 * 0.5);
    sig = (sig * 0.5) + (sig * sig2) + (sig * sig3 * osc) * (sig * sig4 * 0.5 * osc);
    env = EnvGen.kr(Env.new([0, 1, 0], [1, sus]), doneAction: 2);
    sig = sig * env * amp;
    // sig = HPF.ar(in: sig, freq: 2200, mul: 1, add: 0);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)

Synth.new(\fm, [\freq, 330 * 0.midiratio, \sus, 8, \amp, 300]);

(
t.stop;
t = Pbind(
	\instrument, \fm,
	\dur, Pseq([1, 1, 6], inf),
    \freq, 329.63 * -14.midiratio * Pseq([11, 7, 4, 11, 7, [0, 4, -12]], inf).midiratio * [0.5, 1, 2, 3],

    // \freq, 329.63 * -14.midiratio * Pseq([11, 7, 4, 9, 5, [-2, 2, -10]], inf).midiratio * [1, 2, 3, 4, 8],
    // \freq, 329.63 * -10.midiratio * Pseq([10, 7, 3, 12, 7, [0, 3, -12]], inf).midiratio * [1, 2, 3],
    \amp, 330 * 0.0625 * 0.5,
    \sus, 8,
    \freqMod, Pwhite(0.9, 1.1, inf),
    \pan, Pwhite(-0.5, 0.5, inf)
).play;
)

[0, 1, 3].midiratio;