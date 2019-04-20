(
x = {
	var sig, env;
	env = Line.kr(0.05, 0, 10);
	sig = Pulse.ar(110) * env;
}.play;
)

x.free;

(
SynthDef.new(\pulseTest, {
	var sig1, sig2, lfo, lfo2, env;
	env = Line.kr(0.35, 0, 1, 1, 0, 0);
	lfo = SinOsc.kr(3);
	lfo2 = SinOsc.kr(ExpRand(20,800), mul: 0.75, add:1);
	env = env * lfo;
	sig1 = LFTri.ar(221 * lfo2) * env;
	sig2 = LFTri.ar(220 * lfo2) * env;
	sig1 = FreeVerb.ar(sig1, mix: 0.3, room: 0.95, damp: 0.15, mul: 1, add: 0);
	sig2 = FreeVerb.ar(sig2, mix: 0.3, room: 0.95, damp: 0.15, mul: 1, add: 0);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)

d = Synth.new(\pulseTest);
d.free;