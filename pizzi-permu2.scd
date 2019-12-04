Muguet qui avance bellement
(
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.5, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.125, 8)], inf),
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.75/2] ++ ([Rest(0.75/2), 0.75/2]!2 ++ (Rest(0.75/2)!3)).flat, inf),
    \amp, Pseq([1, 0.75], inf) * 3,
    \rate, 1,
    \num, Pseq([11, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)

(
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.1, 8)], inf),
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.25, Rest(0.25)], inf),
    \amp, Pseq([1, 0.75, 0.75, 0.5], inf) * 2  * Pseq([Pseries(1, -0.0125, 8)], inf),
    \rate, 1,
    \num, Pseq([11, 11, 10, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)


// Trois beats
(
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
    \dur, Pseq([0.5, 0.5, 0.25, Rest(0.25)], inf),
    \amp, Pseq([1, 0.75, 1.25, 0.5], inf) * 2  * Pseq([Pseries(1, -0.0125, 8)], inf),
    \rate, 1,
    \num, Pseq([11, 11, 10, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)


// Quatre beats
(
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
)