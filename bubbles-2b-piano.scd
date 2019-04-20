~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Max/Piano/Samples/21055__samulis__vsco-2-ce-keys-upright-piano/374289__samulis__upright-piano-c-5-player-dyn1-rr1-026.wav");
~b0 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Max/Piano/Samples/21055__samulis__vsco-2-ce-keys-upright-piano/374286__samulis__upright-piano-c-4-player-dyn1-rr1-020.wav");


~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Max/Piano/Samples/21055__samulis__vsco-2-ce-keys-upright-piano/374289__samulis__upright-piano-c-5-player-dyn1-rr1-026.wav");
~b0 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Max/Piano/Samples/21055__samulis__vsco-2-ce-keys-upright-piano/374286__samulis__upright-piano-c-4-player-dyn1-rr1-020.wav");

// Nouveaux dossiers
~b0 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Simple-Organism/SuperCollider/374286__samulis__upright-piano-c-4-player-dyn1-rr1-020.wav");
~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Simple-Organism/SuperCollider/374289__samulis__upright-piano-c-5-player-dyn1-rr1-026.wav");


(
SynthDef(\bpfbuff, {
	arg out = 0, buf = ~b1,
	rate = 1, spos = 0,
	pan = 1, amp = 1, lon = 0.75,
	atk = 0.01;
	var sig, env, lfo;
	var a = rate < 0.5;
	buf = Select.kr(rate < 0.5, [~b1, ~b0]);
	amp = Select.kr(rate < 0.5, [amp, amp * 2]);
	rate = Select.kr(rate < 0.5, [rate, rate * 2]);
	env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [atk, 0.15, lon]), doneAction: 2);
	sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos);
	sig = sig * env * amp;
	sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)

n = 5;
m = n > 3;

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
	lfo = SinOsc.kr([12, 12.1]);
	sig = sig * lfo * 1;
	// sig = FreeVerb.ar(sig, 0.5, 0.8, 0.001);
	Out.ar(out, sig);
}).add;
)

w.free;
w = Synth.new(\wahwah, [\in, ~wahwahBus, \out, ~reverbBus], ~fxGroup);


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
	\dur, Pseq([4, 4, 4, 0.5, 0.5, Prand([0.5, 0.4, 0.3, 0.2], 3)], inf),
	// \amp, Prand([1, 0.9, 0.8, 0.7], inf),
	\amp, Prand([1.5, 1.6, 1.4, 1.3], inf),
	\out, ~reverbBus,
	\lon, Pseq([7], inf),
	\atk, Pseq([0.01], inf),
	// \spos, Pwhite(0, 592896, inf).round,
	\rate, Pseq([1 * 1.midiratio, 1 * 5.midiratio, 1 * -4.midiratio], inf) * Prand([0.125, 0.25, 0.5, 1], inf),
	\pan, Pwhite(-0.5, 0.5, inf)
).play;
)


(
v.stop;
v = Pbind(
	\instrument, \bpfbuff,
	\dur, Pseq([6], inf),
	\amp, Pseq([4], inf),
	\out, ~reverbBus,
	\atk, Pseq([0.5], inf),
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