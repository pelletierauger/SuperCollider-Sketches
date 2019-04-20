x = {SinOsc.ar(700, mul: 0.125)}.play;

x.free;

(
z = {
	arg freq=440, amp=1;
	var sig;
	sig = SinOsc.ar(freq) * amp;
}.play;
)

z.set(\freq, 330);

z.set(\amp, 0.5);

z.set(\freq, 220);

(
y = {
	arg noiseHz = 8;
	var freq, sig;
	freq = LFNoise0.kr(noiseHz).exprange(110,220);
	sig = SinOsc.ar(freq, mul: 0.1);
}.play;
)

y.set(\noiseHz, 2);

y.free;


