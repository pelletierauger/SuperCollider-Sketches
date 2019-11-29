(
~piz0.stop;
~piz0 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([0.5] * 1, inf),
    \amp, Pseq([1, 0.5], inf) * 32,
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(1), inf)
).play(t, quant: [1]);
)

t.tempo_(150/60);

(
~piz.stop;
~piz = Pbind(
    \instrument, \pizzi,
    // \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    // \dur, Pseq([3, 3, 2] ++ [Rest(2), 3, 3] * 0.5, inf),
    \dur, Pseq([2, 3, 3] * 0.5, inf),
    \dur, Pseq([3, 3, 2] ++ [Rest(2), 3, 3] * 0.5, inf),
    \amp, Pseq([1], inf) * 12,
    \buf, Pseq([~pizziSamples[11]].stutter(2), inf)
).play(t, quant: [4]);
)

(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([2], inf),
    \amp, Pseq([1, 1], inf) * 2,
    \rate, 1,
    \buf, Pseq([~pizziSamples[0]].stutter(1), inf)
).play(t, quant: [4]);
)


[0.25, 0.5, 0.5, 0.75].sum
(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([1, 0.5, 0.5], inf),
    \amp, Pseq([1, 1], inf) * 3,
    \rate, 1,
    \buf, Pseq([~pizziSamples[0], ~pizziSamples[11], ~pizziSamples[11]].stutter(1), inf)
).play(t, quant: [1]);
)
