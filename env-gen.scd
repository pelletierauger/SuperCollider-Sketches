s.plotTree;

(
x = {
	var sig, env;
	env = XLine.kr(0.5, 0.01, 2, doneAction: 2);
	sig = Pulse.ar(ExpRand(30, 500)) * env;
}.play;
)

Env.new([0, 1, 0.2, 0], [0.5, 1, 2]).plot;

(
x = {
	var sig, env;
	env = EnvGen.kr(Env.new([0, 1, 0.2, 0], [0.125, 2, 2]));
	sig = LFTri.ar(220) * 0.25 * env;
}.play;
)

(
SynthDef.new(\withEnv, {
	var sig1, sig2, env, lfo1, lfo2;
	lfo1 = SinOsc.kr(XLine.kr(15, 5, 3), mul: 0.5, add:1);
		lfo2 = SinOsc.kr(XLine.kr(15, 5, 3), phase: pi, mul: 0.5, add:1);
	env = EnvGen.kr(Env.new(
	[0, 1, 0.2, 0],
	[0.5, 2, 4],
		[3, -3, 1]),
	doneAction: 2);
	sig1 = LFTri.ar(221) * 0.25 * env;
	sig1 = sig1 * lfo1;
	sig2 = LFTri.ar(220) * 0.25 * env;
	sig2 = sig2 * lfo2;
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)

x = Synth.new(\withEnv);
Synth.new(\withEnv);

(
Env.new(
	[0, 1, 0.2, 0],
	[0.5, 2, 4],
	[3, -3, 1]).plot;
)

s.meter;


"bonjour".dup(3);