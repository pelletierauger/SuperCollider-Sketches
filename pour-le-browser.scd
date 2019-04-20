~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec Caroline Project/Samples/Recorded/0002 7-Audio.aif");

(
SynthDef(\bpfbuff, {
	arg buf = ~b1, rate = 1, spos = 0, pan = 1, amp = 1;
	var sig, env, lfo;
	env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.1, 0.15, 0.75]), doneAction: 2);
	sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos);
	sig = sig * env;
	sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(0, sig);
}).add;
)

(
p.stop;
a = 400000;
p = Pbind(
	\instrument, \bpfbuff,
	\dur, Pseq([0.005, 0.005, 0.005], inf),
	\spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	\rate, Pseq([1 * -2.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	\pan, Pwhite(-1, 1, inf)
).play;
)

(
SynthDef.new(\pinkTest, {
	arg frequency = 220;
	var sig1, sig2, lfo, lfo2, env;
	env = XLine.kr(0.15, 0.001, 3, 1, 0, 2);
	lfo = SinOsc.kr(3);
	lfo2 = SinOsc.kr(ExpRand(20,800), mul: 0.75, add:1);
	env = env * lfo;
	sig1 = PinkNoise.ar(mul: 0.2);
	sig2 = PinkNoise.ar(mul: 0.2);
	sig1 = Ringz.ar(sig1, frequency, 15, 0.2) * env;
	sig2 = Ringz.ar(sig2, frequency + 1, 15, 0.2) * env;
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)

p.stop;
(
q.stop;
q = Pbind(
	\instrument, \pinkTest,
	\dur, Pseq([0.6 * 2, 0.3, 0.3, 0.9], inf),
	\frequency, Pseq([330, 247, 370], inf)
).play;
)

(
~pink2.stop;
~pink2 = Pbind(
	\instrument, \pinkTest,
	\dur, Pseq([0.6 * 2, 0.9, 0.6, 0.9], inf),
	\frequency, Pseq([330 * 2, 247 * 0.5, 330 * 3], inf)
).play;
)
p.stop;

(
d.stop;
d = Pbind(
	\instrument, \pulseTest,
	\dur, Pseq([1, 0.3, 0.15, 0.15, 1], inf),
	\frequency, Pseq([330, 247 * 1, 370 * 1, 165 * 3], inf)
).play;
)

(
e.stop;
e = Pbind(
	\instrument, \pulseTest,
	\dur, Pseq([0.25, 1, 0.3, 0.9 + 0.3], inf),
	\frequency, Pseq([330, 247 * 0.5, 370 * 0.5, 247], inf)
).play;
)

(
SynthDef.new(\pulseTest, {
	arg frequency = 220;
	var sig1, sig2, lfo, lfo2, env;
	env = XLine.kr(0.5, 0.001, 3, 1, 0, 2);
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

s.freeAll;