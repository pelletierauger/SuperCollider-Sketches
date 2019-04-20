s.boot;

~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec Caroline Project/Samples/Recorded/0002 7-Audio.aif");

(
SynthDef(\bpfbuff, {
	arg buf = ~b1, rate = 1, spos = 0, pan = 1, amp = 1;
	var sig, env, lfo;
	env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.1, 0.15, 0.75]), doneAction: 2);
	sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos);
	sig = sig * env;
	// lfo = SinOsc.kr(0.5, mul: 0.5, add: 1);
	// sig = BPF.ar(sig, lfo * 1220);
	sig = Balance2.ar(sig[0], sig[1], pan, 1);
	// BPF
	Out.ar(0, sig);
}).add;
)


(
a = (0.5.rand * 1047552).round;
b = Synth.new(\bpfbuff, [\spos, a]);
)

(
p.stop;
a = 400000;
// a = 0;

a = -9000;
p = Pbind(
	\instrument, \bpfbuff,
	\dur, Pseq([0.005, 0.005, 0.005], inf),
	\spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	// \pan, -1,
	// \rate, 0.75
	\rate, Pseq([1 * 0.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	\pan, Pwhite(-1, 1, inf)
).play;
)
-2.midiratio;

(
SynthDef.new(\triangle, {
	arg frequency = 220;
	var sig1, sig2, lfo, lfo2, env;
	env = XLine.kr(0.5, 0.001, 7, 1, 0, 2);
	lfo = SinOsc.kr(3);
	lfo2 = SinOsc.kr(ExpRand(20,800), mul: 0.75, add:1);
	env = env * lfo;
	sig1 = LFTri.ar((frequency + 1)) * env;
	sig2 = LFTri.ar(frequency) * env;
	sig1 = FreeVerb.ar(sig1, mix: 0.3, room: 0.95, damp: 0.15, mul: 1, add: 0);
	sig2 = FreeVerb.ar(sig2, mix: 0.3, room: 0.95, damp: 0.15, mul: 1, add: 0);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)
(
d.stop;
d = Pbind(
	\instrument, \triangle,
	\dur, Pseq([1, 0.03, 0.15, 0.15, 1], inf),
	\frequency, Pseq([330 * -1.midiratio, 247 * 1, 370 * 1, 165 * 3], inf)
).play;
)

1 *

0.midiratio;

~b1.duration;

~b1.duration * 44100;
s.samplingRate;44100;
~b1.play;
~b1.free;

a = Pwhite(0, 1047552, inf).round;

rrand(1, 5, 2, 23);
Pwhite(0, 1);
(Rand(0, 1));

(0.5.rand * 1047552).round;