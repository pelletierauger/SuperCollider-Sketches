s.boot;

t = TempoClock.new;
t.tempo_(24/60);
// t.tempo_(98/60);
// t.tempo * 60;

(
SynthDef(\pulse, {
    arg freq = 440, pan = 0, out = 0, amp = 1, sus = 0.125, atk = 0.001, freqRin = 1, dtun = 1;
    var sig, sig2, sig3, env;
    // sus = sus * (220 / freq);
    sig = SinOsc.ar([freq, freq + 1]) * 0.9;
    sig2 = LFSaw.ar([freq, freq + 1] * 1.01125) * 0.9;
    sig3 = LFSaw.ar([freq, freq + 1] * 2 * dtun) * 0.9;
    // env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [atk, sus * 1, 2]), doneAction: 2);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, sus * 1.1]), doneAction: 2);
    sig = sig * sig2 * sig3;
    // sig = sig * 2.0 + Ringz.ar(sig, [freq * freqRin, freq * freqRin + 2], sus * 0.9, 1);
    sig = sig * amp * env;
    // sig = (sig * 0.02625) + HPF.ar(sig, FSinOsc.kr(XLine.kr(0.7, 300, 20), 0, 300, 600), 0.75);
    // sig = LPF.ar(sig, 2100);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(~passesBus, sig);
}).add;
)

Synth.new(\pulse, [\freq, 220, \sus, 0.4, \amp, 0.5]);


(
~key1 = ~toFreq.("C5");
~main.stop;
~pha = 0.05;
~main = Pbind(
    \instrument, \pulse,
    \dur, Pseq([~pha, ~pha, 1 - (~pha * 2)], inf),
    \freq, ~key1 * Pseq([-5, 0, 4].midiratio, inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \amp, Pseq([Pgeom(0.1, 0.65, 4)], inf),
    \sus, 0.45,
    \out, 0
).play(quant: 1);
)
~key1.cpsmidi;

(
~key2 = ~toFreq.("Eb4");
~key3 = ~toFreq.("F4");
// ~sec.stop;
~pha = 0.045;
~sec = Pbind(
    \instrument, \pulse,
    \dur, Pseq([~pha, ~pha, (1 * 1/3 * 2) - (~pha * 2)], inf),
    \freq, Pseq([
        Pseq(~key2 * [0, 4, 7].midiratio, 3),
        Pseq(~key3 * [-7, 0, 3].midiratio, 3)
    ], inf) * [0.5],
    \pan, Pwhite(-0.75, 0.75, inf),
    \amp, Pseq([Pgeom(0.15, 0.75, 9)], inf),
    \sus, 0.75,
    \freqRin, 2,
    \out, 0
).play(t, quant: 1);
)

~key1;
~toFreq.("Bb3");
~key4;
~toFreq.("C4");
(
~key1 = ~toFreq.("Bb3");
~key4 = ~toFreq.("C4");
~bass.stop;
// ~pha = 0.015;
~bass = Pbind(
    \instrument, \pulse,
    \dur, Pseq([1 * 0.25], inf),
    \freq, Pseq([
        ~key1 * Pseq([4, -7].stutter(8).midiratio, 2),
        ~key4 * Pseq([3, -7].stutter(8).midiratio, 2)
    ], inf) * [0.5, 1],
    \pan, Pwhite(-0.5, 0.5, inf),
    \amp, Pseq([Pgeom(0.115, 0.65, 8)], inf),
    \sus, 0.5,
    \out, 0
).play(t, quant: [1, 0.5]);
)

Synth.new(\fm, [\freq, ~key1 * 0.midiratio, \sus, 8, \amp, 10]);

(
~wash.stop;
~wash = Pbind(
    \instrument, \fm,
    \dur, Pseq([2], inf),
    \freq, Prand([~key1], inf) * Prand([-7, 0, 4].midiratio, inf) * [1, 2],
    \pan, Pwhite(-0.5, 0.5, inf),
    \amp, 10,
    \sus, 8,
    \out, 0
).play(quant: 1);
)

(
~wash2.stop;
~wash2 = Pbind(
    \instrument, \fm,
    \dur, Pseq([0.25], inf),
    \freq, Prand([~key1], inf) * Pseq([-12, -7, 0, 4, -7].midiratio, inf) * [0.5, 1, 2],
    \pan, Pwhite(-0.75, 0.75, inf),
    \amp, 10,
    \sus, 0.5,
    \out, 0
).play(t,quant: 1);
)

(
~wash3.stop;
~wash3 = Pbind(
    \instrument, \fm2,
    \dur, Pseq([0.25], inf),
    \freq, Pseq([~key3, ~key4].stutter(16), inf) * Pseq([-12, -7, 0, -7].midiratio, inf) * [0.5, 1, 2],
    \pan, Pwhite(-0.75, 0.75, inf),
    \amp, 10,
    \sus, 0.5,
    \out, ~reverbBus
).play(t,quant: 1);
)


(
~key1 = ~toFreq.("C4");
~key4 = ~toFreq.("D4");
~high.stop;
~high = Pbind(
    \instrument, \pulse,
    \dur, Pseq([1 * 0.25], inf),
    \freq, Pseq([~key1 * [7, 11, 0].midiratio] * 2, inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \amp, Pseq([Pgeom(0.005, 0.65, 4)], inf),
    \sus, 0.5,
    \out, 0
).play(t, quant: 1);
)

(
SynthDef(\fm, {
	arg freq = 440, pan = 0, out = 0, amp = 1, sus = 2, freqMod = 3;
	var sig, osc, sig2, sig3, sig4, env;
	sig = SinOsc.ar([freq, freq + 1]) * 0.1;
    osc = SinOsc.ar(freqMod, 1.5, 0.25, 1);
    sig2 = SinOsc.ar([freq, freq + 1] * 2.01) * 1 * 1.005;
    sig3 = LFTri.ar([freq, freq + 1] * 1.01 * 2);
    sig4 = LFSaw.ar([freq, freq + 1] * 1.005 * 2);
    sig = (sig * 0.5) + (sig * sig2) + (sig * sig3 * osc) * (sig * sig4 * 0.5 * osc);
    env = EnvGen.kr(Env.new([0, 1, 0], [1, sus]), doneAction: 2);
    sig = sig * env * amp;
    // sig = HPF.ar(in: sig, freq: 2200, mul: 1, add: 0);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)

(
SynthDef(\fm2, {
	arg freq = 440, pan = 0, out = 0, amp = 1, sus = 2, freqMod = 3;
	var sig, osc, sig2, sig3, sig4, env;
	sig = SinOsc.ar([freq, freq + 1]) * 0.1;
    osc = SinOsc.ar(freqMod, 1.5, 0.25, 1);
    sig2 = SinOsc.ar([freq, freq + 1] * 4.01) * 1 * 1.005;
    sig3 = LFTri.ar([freq, freq + 1] * 1.01 * 2);
    sig4 = LFSaw.ar([freq, freq + 1] * 1.005 * 1);
    sig = (sig * 0.5) + (sig * sig2) + (sig * sig3 * osc) * (sig * sig4 * 0.5 * osc);
    env = EnvGen.kr(Env.new([0, 1, 0], [1, sus]), doneAction: 2);
    sig = sig * env * amp;
    // sig = HPF.ar(in: sig, freq: 2200, mul: 1, add: 0);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)


(
~glock.stop;
~glock = Pbind(
	\instrument, \bell,
	\fs, Pseq([~key1 * [12, 4].midiratio] * -7.midiratio, inf),
	\t60, 5,
	\pitchy, 2,
	\dur, 0.5 * 2,
    \amp, 0.125 * 0.125
).play(t, quant: 1);
)

(
~glock2.stop;
~glock2 = Pbind(
	\instrument, \bell,
	\fs, Pseq([~key1 * [12, 7].midiratio] * 0.midiratio, inf),
	\t60, 5,
	\pitchy, 2,
	\dur, 0.25,
    \amp, 0.125 * 0.125
).play(t, quant: 1);
)


(
SynthDef(\bell, {
	|fs=1, t60=1, pitchy=1, amp=0.25, gate=1|
	var sig, exciter;
	//exciter = Impulse.ar(0);
	exciter = WhiteNoise.ar() * EnvGen.ar(Env.perc(0.001, 0.05), gate) * 0.25;
	sig = Klank.ar(
		`[
			[1, 2, 2.803, 3.871, 5.074, 7.81, 10.948, 14.421],   // freqs
			[1, 0.044, 0.891, 0.0891, 0.794, 0.1, 0.281, 0.079], // amplitudes
			[1, 0.205, 1, 0.196, 0.339, 0.047, 0.058, 0.047]*t60     // ring times
		],
		exciter,
		freqscale:fs*pitchy);
	sig = FreeVerb.ar(sig) * amp;
	DetectSilence.ar(sig, 0.001, 0.5, doneAction:2);
	Out.ar(0, sig!2);
}).add
)