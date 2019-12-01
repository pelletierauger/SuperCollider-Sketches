(
~piz.stop;
~ba.stop;
~ba = Pbind(
    \instrument, Pseq([\tb303, \tb303Flip].stutter(2), inf),
    \dur, Pseq([1, Rest(1), 1, 1], inf),
    \pitch, 35 + Pseq([0, 2, 5, 9].stutter(2).reverse, inf)
    + Pseq(([0, 12]!8).flat ++ ([0, 7]!8).flat, inf),
    \amp, 1,
	\fltCtf, 85.linlin(0, 127, -63, 64),
    \fltCtf, Pseq([Pseries(0, 2, 8)], inf),
    \fltDec, 120.linlin(0, 127, 0, 5),
    // \fltDec, Pseq(Pseries(0.5, 0.5, 8).asStream.nextN(8).reverse, inf),
    \fltDst, 90.linlin(0, 127, 0, 1),
    \fltPitchMod, 30.linlin(0, 127, 0, 127),
    \fltAmt, 55 + Pseq([0, 30], inf),
    \fltRz, 95.linlin(0, 127, 0, 1),
    \fltRza, 95.linlin(0, 127, -pi, pi),
	\volAtk, 30.linexp(0, 127, 0.01, 10),
    \volDec, 40.linlin(0, 127, 0,5),
    \volSus, 63.linexp(0, 127, 0.01, 1),
    \volRel, 63.linexp(0, 127, 0.01, 10),
    \totVol, 63.linlin(0, 127, -24, 24)
).play(t, quant: 1);
)

(
~ba.stop;
~pizHat.stop;
~piz2.stop;
)