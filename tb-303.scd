(
~vr = Array.fill(128, 63);
SynthDef(\tb303, {
	arg outBus = 0, gate = 1, pitch = 50, amp = 0.1, totVol,
	fltCtf, fltDec, fltDst, fltPitchMod, fltAmt, fltRz, fltRza,
	volAtk, volDec, volSus, volRel, volAmt;
	var env1, env2, out, tenv;
	env1 = EnvGen.ar(
		Env.adsr(
			attackTime: volAtk,
			decayTime: volDec,
			sustainLevel: gate * volSus,
			releaseTime: volRel,
	), gate, 1, doneAction: 2);
	env2 = EnvGen.ar(Env.perc(0.01, fltDec, fltAmt, -4));
	out = LFPulse.ar(pitch.midicps * [1, 1.001], 0.0, 0.51, 2, -1);
	//out = BLowPass4.ar(out, ((pitch + env2).clip2(124)).midicps, fltRz,0.1);
	//out = RLPFD.ar(out, ((fltAtk + pitch + env2).midicps) * ((1 + tanh(fltRza))/2), fltRz, fltRz);
	out = RLPFD.ar(out, (fltCtf  + pitch.linlin(0, 127, 0, fltPitchMod) + env2).midicps, fltRz, fltRza);
	out = out * env1 *((totVol + amp - 15).dbamp);
	Out.ar(0, out * 4);
}).add;
~defme = { arg a1,b1,c1; var a =
	[
		\fltCtf,  ~vr[0].linlin(0, 127, -63, 64), //cutoff freq
		\fltDec,  ~vr[1].linlin(0, 127, 0, 5),
		\fltDst,  ~vr[2].linlin(0, 127, 0, 1),
		\fltPitchMod,  ~vr[3].linlin(0, 127, 0, 127), //filter pitch mod
		\fltAmt,   ~vr[4],
		\fltRz,    ~vr[5].linlin(0, 127, 0, 1),
		\fltRza,   ~vr[5].linlin(0, 127, -pi, pi),
		//
		\volAtk,  ~vr[6].linexp(0, 127, 0.01, 10),
		\volDec,  ~vr[8].linlin(0, 127, 0,5),
		\volSus,  ~vr[9].linexp(0, 127, 0.01, 1),
		\volRel,  ~vr[10].linexp(0, 127, 0.01, 10),
		\totVol, ~vr[7].linlin(0, 127, -24, 24)];
	if(a1 == 1, { [\pitch, b1, \amp, c1.linlin(0, 127, -12, 12)] ++ a}, {a});
};
)

Pièce en G majeur...
on commence sur le demi-ton 0 de la gamme de E mineur (relative à G Majeur), donc...
Au début, on pourrait se croire en E Mineur
[-0, -2, -5, ..., -4, -2, -5...]
[-7, -4, -5]
(
x.setn(\gate, 0);
x = Synth.new(\tb303, ~defme.value(1, 52 - 24, 108));
)

~toMidi.("G2");
52 - [9, 7, 5, 4, 2, 0, -2, -3]
~toMidi.("A2") + [0, 2, 3, 5, 7];
~vr[3] = 30
~vr[0] = 85
~vr[4] = 35 + 20
~vr[1] = 60
~vr[8] = 30
~vr[5] = 95
~vr.size

~vr[6] = 10
2 + 0.linlin(0, 1, 0, 2)
([0, 12]!4).flat
Pseries(0, 6, 8).asStream.nextN(8).reverse
(
~ba.stop;
~ba = Pbind(
    \instrument, \tb303,
    \dur, Pseq([0.5], inf),
    \pitch, 35 + Pseq([0, 2, 5, 9].stutter(2).reverse, inf)
    + Pseq(([0, 12]!16).flat ++ ([0, 7]!16).flat, inf),
    \amp, 1,
	\fltCtf, 85.linlin(0, 127, -63, 64),
    \fltCtf, Pseq([Pseries(0, 1, 8)], inf),
    \fltDec, 120.linlin(0, 127, 0, 5),
    // \fltDec, Pseq(Pseries(0.5, 0.5, 8).asStream.nextN(8).reverse, inf),
    \fltDst, 90.linlin(0, 127, 0, 1),
    \fltPitchMod, 30.linlin(0, 127, 0, 127),
    \fltAmt, 55 + -5,
    \fltRz, 95.linlin(0, 127, 0, 1),
    \fltRza, 95.linlin(0, 127, -pi, pi),
	\volAtk, 30.linexp(0, 127, 0.01, 10),
    \volDec, 40.linlin(0, 127, 0,5),
    \volSus, 63.linexp(0, 127, 0.01, 1),
    \volRel, 63.linexp(0, 127, 0.01, 10),
    \totVol, 63.linlin(0, 127, -24, 24)
).play(t, quant: 1);
)

t.tempo_(130/60);
(
~crossStick.stop;
~crossStick = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([3, 3, 2] * 1, inf),
    // \dur, Pseq([2, 3, 3] ++ [3, 3, 2] * 0.5, inf),
    \dur, Pseq([2, 3, 3] * 0.5, inf),
    // \dur, Pseq([3, 3, 2] ++ [Rest(2), 3, 3] * 0.5, inf),
    \dur, Pseq([Rest(0.5), 1, 0.5, 1.5, 0.5] * 1, inf),
    \num, Pseq([4], inf),
    \amp, Pseq([4, 2, 1, 4, 2], inf)
).play(t, quant: [1, -1/32]);
~kick.stop;
~kick = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([2] * 1, inf),
    \num, Pseq([13], inf),
    \amp, Pseq([1.5], inf) * 4
).play(t, quant: [1, -1/32]);
)
