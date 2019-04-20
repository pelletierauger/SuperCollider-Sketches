~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec Caroline Project/Samples/Recorded/0002 7-Audio.aif");

(
SynthDef(\bpfbuff, {
	arg buf = ~b1, rate = 1, spos = 0, pan = 1;
	var sig, env, lfo;
	env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.1, 0.15, 0.25]), doneAction: 2);
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
p = Pbind(
	\instrument, \bpfbuff,
	\dur, Pseq([0.005, 0.005, 0.005], inf),
	\spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	// \pan, -1,
	// \rate, 0.75
	\rate, Pseq([1 * -0.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	\pan, Pwhite(-1, 1, inf)
).play;
)

(
q.stop;
// s = 400000;
s = 0;
q = Pbind(
	\instrument, \bpfbuff,
	\dur, Pseq([0.1005, 0.005, 0.005], inf),
	\spos, Pwhite(1047552 - 880000 + s, 1047552 - 840000 + s, inf).round,
	\pan, -1,
	// \rate, 0.75
	\rate, Pseq([1 * 0.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf)
	// \pan, Pwhite(-1, 1, inf)
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