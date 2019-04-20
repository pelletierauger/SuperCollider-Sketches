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


// paix posée
(
SynthDef(\fm, {
	arg freq = 440, pan = 0, out = 0, amp = 1, sus = 2, freqMod = 3;
	var sig, osc, sig2, sig3, sig4, env;
	sig = SinOsc.ar([freq, freq + 1]) * 0.1;
    osc = SinOsc.ar(freqMod, 1.5, 0.25, 1);
    sig2 = SinOsc.ar([freq, freq + 1] * 1) * 1 * 1.005;
    sig3 = LFTri.ar([freq, freq + 1] * 2.01 * 0.5);
    sig4 = LFSaw.ar([freq, freq + 1] * 1.005 * 1);
    sig = (sig * 0.5) + (sig * sig2) + (sig * sig3 * osc) * (sig * sig4 * 0.5 * osc);
    env = EnvGen.kr(Env.new([0, 1, 0], [1, sus]), doneAction: 2);
    sig = sig * env * amp;
    // sig = HPF.ar(in: sig, freq: 2200, mul: 1, add: 0);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)


// Pause magique
(
SynthDef(\fm, {
	arg freq = 440, pan = 0, out = 0, amp = 1, sus = 2, freqMod = 3;
	var sig, osc, sig2, sig3, sig4, env;
	sig = SinOsc.ar([freq, freq + 1]) * 0.1;
    osc = SinOsc.ar(freqMod, 1.5, 0.25, 1);
    sig2 = SinOsc.ar([freq, freq + 1] * 2.01) * 1 * 1.005;
    sig3 = LFTri.ar([freq, freq + 1] * 1.01 * 1);
    sig4 = LFSaw.ar([freq, freq + 1] * 1.005 * 0.5);
    sig = (sig * 0.5) + (sig * sig2) + (sig * sig3 * osc) * (sig * sig4 * 0.5 * osc);
    env = EnvGen.kr(Env.new([0, 1, 0], [1, sus]), doneAction: 2);
    sig = sig * env * amp;
    // sig = HPF.ar(in: sig, freq: 2200, mul: 1, add: 0);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)


(
SynthDef(\fm, {
	arg freq = 440, pan = 0, out = 0, amp = 1, sus = 2, freqMod = 3;
	var sig, osc, sig2, sig3, sig4, env;
	sig = SinOsc.ar([freq, freq + 1]) * 0.1;
    osc = SinOsc.ar(freqMod, 1.5, 0.25, 1);
    sig2 = SinOsc.ar([freq, freq + 1] * 1.01 * 0.5) * 1 * 1.005;
    sig3 = LFTri.ar([freq, freq + 1] * 1.01 * 1);
    sig4 = LFSaw.ar([freq, freq + 1] * 1.005 * 2);
    sig = (sig * 0.5) + (sig * sig2) + (sig * sig3 * osc) * (sig * sig4 * 0.5 * osc);
    env = EnvGen.kr(Env.new([0, 1, 0], [1, sus]), doneAction: 2);
    sig = sig * env * amp;
    // sig = HPF.ar(in: sig, freq: 2200, mul: 1, add: 0);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)
