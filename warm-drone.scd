l = 90;

(
SynthDef.new(\pink, {
	var sig1, sig2;
	sig1 = PinkNoise.ar(mul: 0.2);
	sig2 = PinkNoise.ar(mul: 0.2);
	sig1 = Ringz.ar(sig1, l * 5, 15, 0.2);
	sig2 = Ringz.ar(sig2, l * 5, 15, 0.2);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)

x = Synth.new(\pink);

l = 110;

s.graph;

