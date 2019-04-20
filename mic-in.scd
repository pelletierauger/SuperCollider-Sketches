s.boot;


s.meter;
(
x = {
	arg fr = 120;
	//fr = 120;
	var sig, lfo, rmod;
	lfo = SinOsc.kr(5, mul: 0.5, add: 1);
	rmod = SinOsc.kr(fr);
	sig = In.ar(2!2);
	sig = FreeVerb.ar(sig, mix: 0.33, room: 0.9, damp: 0.15);
	sig = sig * lfo;
	sig = sig * rmod;
	Out.ar(0, sig);
}.play;
)

(
var hasard;
hasard = Rand(10,600);
x.set(\fr, rrand(10,600);
)

Rand.new(10,20);

1.0.rand
rrand(10,20);

x.set(\fr, rrand(10,600));