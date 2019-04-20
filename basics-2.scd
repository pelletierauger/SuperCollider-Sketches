(
SynthDef.new(\sineTest, {
	arg noiseHz = 8;
	var freq, amp, sig1, sig2;
	freq = LFNoise0.kr(noiseHz).exprange(200, 1000);
	amp = LFNoise1.kr(12).exprange(0.02, 1);
	sig1 = SinOsc.ar(freq) * amp;
	sig2 = SinOsc.ar(freq) * amp;
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)


d = Synth.new(\sineTest);

d.set(\noiseHz, 1000);

d.free;