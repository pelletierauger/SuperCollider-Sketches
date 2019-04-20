~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Max/Piano/Samples/21055__samulis__vsco-2-ce-keys-upright-piano/374289__samulis__upright-piano-c-5-player-dyn1-rr1-026.wav");

(
SynthDef(\bpfbuff, {
	arg out = 0, buf = ~b1, rate = 1, spos = 0, pan = 1, amp = 1, lon = 0.75;
	var sig, env, lfo;
	env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.1, 0.15, lon]), doneAction: 2);
	sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos);
	sig = sig * env * amp;
	sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)

(
SynthDef.new(\wahwah, {
	arg in, out = 0;
	var sig, del, lfo;
	sig = In.ar(in, 2);
/*	del = CombC.ar(in: sig,
		maxdelaytime: 0.5,
		delaytime: [0.5, 0.51],
		decaytime: 20,
		mul: 1, add: 0);
	sig = sig + (del * 0.25);*/
	lfo = SinOsc.kr([0.1, 0.12]);
	sig = sig * lfo * 0.5;
	// sig = FreeVerb.ar(sig, 0.5, 0.8, 0.001);
	Out.ar(out, sig);
}).add;
)

w.free;
w = Synth.new(\wahwah, [\in, ~wahwahBus], ~fxGroup);


(
t.stop;
t = Pbind(
	\instrument, \bpfbuff,
	\dur, Pseq([0.025], inf),
	\amp, Pseq([4], inf),
	\out, ~wahwahBus,
	// \spos, Pwhite(0, 592896, inf).round,
	\rate, Pseq([1 * -11.midiratio, 1 * -4.midiratio, 1 * -16.midiratio], inf),
	\pan, Pwhite(-1, 1, inf)
).play;
)

(
u.stop;
u = Pbind(
	\instrument, \bpfbuff,
	\dur, Pseq([4], inf),
	\amp, Pseq([16], inf),
	\out, ~reverbBus,
	// \spos, Pwhite(0, 592896, inf).round,
	\rate, Pseq([1 * 1.midiratio, 1 * 5.midiratio, 1 * -4.midiratio], inf),
	\pan, Pwhite(-1, 1, inf)
).play;
)


(
v.stop;
v = Pbind(
	\instrument, \bpfbuff,
	\dur, Pseq([4], inf),
	\amp, Pseq([16], inf),
	\out, ~reverbBus,
	// \spos, Pwhite(0, 592896, inf).round,
	// \rate, Pseq([1 * 1.midiratio, 1 * 5.midiratio, 1 * -4.midiratio], inf),
	\dur, Pseq([3, 0.125, 0.0125, 0.0125], inf),
	\rate, Prand([0, 2, 4, 5, 7, 9, 11], inf).midiratio * -4.midiratio * 1 * Prand([1], inf),
	\pan, Pwhite(-1, 1, inf),
	\lon, Pseq([0.0275], inf),
	\spos, Pseq([20000], inf)
).play;
)

~b1;