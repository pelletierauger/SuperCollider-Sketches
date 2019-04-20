s.boot;

(
SynthDef.new(\pulseTest, {
	arg frequency = 220;
	var sig1, sig2, lfo, lfo2, env;
	env = XLine.kr(0.35, 0.001, 3, 1, 0, 2);
	lfo = SinOsc.kr(3);
	lfo2 = SinOsc.kr(ExpRand(20,800), mul: 0.75, add:1);
	env = env * lfo;
	sig1 = LFTri.ar((frequency + 1) * lfo2) * env;
	sig2 = LFTri.ar(frequency * lfo2) * env;
	sig1 = FreeVerb.ar(sig1, mix: 0.3, room: 0.95, damp: 0.15, mul: 1, add: 0);
	sig2 = FreeVerb.ar(sig2, mix: 0.3, room: 0.95, damp: 0.15, mul: 1, add: 0);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)


(
OSCdef.new(
	\fromnode,
	{
		arg msg, time, addr, port;
		// [msg, time, addr, port].postln;
		msg[1].postln;
		//d = Synth.new(\pulseTest, [\frequency, msg[1]]);
	},
	'/hello/from/oscjs'
);
)