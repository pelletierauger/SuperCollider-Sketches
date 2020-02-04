(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzi,
    // \dur, Pwhite(0.001, 0.5, 40),
    \dur, Pseq([0.25], inf),
    \amp, Pseq(Pseries(0, 0.05, 20).asStream.nextN(20).mirror, inf) * 1,
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    \rate, Pseq([0, 4, 7, 9, 11].midiratio.stutter(2), inf) * 0.0625 * Pseq([1, 2], inf),
    \buf, Pseq([~pizziSamples[11], ~pizziSamples[11]].stutter(1), inf)
).play(t, quant: [1]);
)


(
~piz.stop;
~piz = Pbind(
    \instrument, \pizzi,
    // \dur, Pwhite(0.001, 0.5, 40),
    \dur, Pseq([0.125], inf),
    \amp, Pseq(Pseries(0, 0.1, 20).asStream.nextN(20).mirror, inf) * 1,
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    \rate, Pseq([0, 2, 9, 14].midiratio.stutter(2).reverse, inf) * 0.25 * Pseq([1, 2], inf)
    * Pwhite(0.99, 1.01, inf),
    \buf, Pseq([~pizziSamples[12]].stutter(1), inf)
).play(t, quant: [1, 0.125]);
)

(
~pizb.stop;
~pizb = Pbind(
    \instrument, \pizzi,
    // \dur, Pwhite(0.001, 0.5, 40),
    \dur, Pseq([0.125], inf),
    \amp, Pseq(Pseries(0, 0.1, 20).asStream.nextN(20).mirror, inf) * 1,
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    \rate, Pseq([0, 2, 9, 14].midiratio.stutter(2).reverse, inf) * 0.5 * Pseq([1, 2], inf)
    * Pwhite(0.99, 1.01, inf),
    \buf, Pseq([~pizziSamples[12]].stutter(1), inf)
).play(t, quant: [1, 0.125]);
)


(
~pizc.stop;
~pizc = Pbind(
    \instrument, \pizzi,
    // \dur, Pwhite(0.001, 0.5, 40),
    \dur, Pseq([0.5], inf),
    \amp, Pseq(Pseries(0, 0.1, 20).asStream.nextN(20).mirror, inf) * 0.0625,
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    \rate, Pseq([0, 2, 9, 14].midiratio.stutter(2).reverse, inf) * 2 * Pseq([1, 4], inf)
    * Pwhite(0.99, 1.01, inf),
    \buf, Pseq([~pizziSamples[4], ~pizziSamples[2], ~pizziSamples[3]].stutter(1), inf)
).play(t, quant: [1, 0.125]);
)
Pwhite