(
// ~piz.stop;(
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.1, 8)], inf) * 0.5,
    \num, Pseq([6, 7, 7, 6].stutter(1), inf),
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.5, 0.5], inf),
    \amp, Pseq([1, 0.75, 1.25, 0.5], inf) * 2  * Pseq([Pseries(1, -0.0125, 8)], inf),
    \rate, 1,
    \num, Pseq([11, 11, 10, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
~ba.stop;
~ba = Pbind(
    \instrument, Pseq([\tb303, \tb303Flip].stutter(2), inf),
    \dur, Pseq([1, Rest(1.5), 1.0, 0.5] * 1, inf),
    \pitch, 35 + 9 + Pseq(([0, 0, -2, 7]!2).flat ++ (([0, 0, -2, 7]!2).flat - 9), inf),
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
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.1, 8)], inf),
    \num, Pseq([6, 7, 7, 6].stutter(1), inf),
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.25, Rest(0.25)], inf),
    \amp, Pseq([1, 0.75, 2, 0.5], inf) * 2  * Pseq([Pseries(1, -0.0125, 8)], inf),
    \rate, 1,
    \num, Pseq([11, 11, 10, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
~ba.stop;
~ba = Pbind(
    \instrument, Pseq([\tb303, \tb303Flip].stutter(2), inf),
    \dur, Pseq([1.5], inf),
    \pitch, 35 + Pseq([0, 5, 9].stutter(2).reverse, inf)
    + Pseq(([0, 12]!6).flat ++ ([0, 7]!6).flat, inf),
    \amp, 1,
	\fltCtf, 85.linlin(0, 127, -63, 64),
    \fltCtf, Pseq([Pseries(0, 2, 6)], inf),
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