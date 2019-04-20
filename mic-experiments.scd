s.boot;
s.quit;

ServerOptions.outDevices;

ServerOptions.inDevices;

(
x = {
	var sig, lfo;
	lfo = SinOsc.ar(15, mul: 0.5, add: 1);
	sig = In.ar(2!2);
	sig = sig * 25;
	sig = FreeVerb.ar(sig, mix: 0.33, room: 0.9, damp: 0.15);
	sig = sig * lfo;
	Out.ar(0, sig);
}.play;
)

x.free;
s.freeAll;