s.boot;

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