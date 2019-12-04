(
~piz.stop;
~piz = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([1] * 4, inf),
    \amp, Pseq([1], inf) * 32,
    \buf, Pseq([~pizziSamples[6]].stutter(2), inf)
).play(t, quant: [1]);
)

(
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.125, 8)], inf),
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
).play(t, quant: [1]);
)


(
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.75, 0.25], inf),
    \amp, Pseq([1, 0.75, 0.75, 0.5], inf) * 3,
    \rate, 0.5,
    \num, Pseq([11, 11, 0, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)


(
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.75, 0.25] ++ [0.5, 0.5, 0.25, 0.5, 0.25], inf),
    \amp, Pseq([1, 0.75, 0.85, 0.5] ++ [1, 0.75, 0.85, 0.35, 0.5], inf) * 3,
    \rate, 1,
    \num, Pseq([11, 11, 0, 11] ++ [11, 11, 0, 2, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)


(
~piz3.stop;
~piz3 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([2], inf),
    \amp, Pseq([1], inf) * 3,
    \rate, 0.5,
    \num, Pseq([1], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)