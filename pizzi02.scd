(
~piz.stop;
~piz = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([0.25, 0.25, 0.5, 0.5] * 1, inf),
    \amp, Pseq([1, 0.25], inf) * 32,
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
).play(t, quant: [1]);
)

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([Rest(1.75), 0.25], inf),
    \amp, Pseq([1, 0.5], inf) * 3,
    \rate, -5.midiratio,
    \buf, Pseq([~pizziSamples[0], ~pizziSamples[2]].stutter(1), inf)
).play(t, quant: [1]);
)

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([Rest(0.5), 1.25, 0.25], inf),
    \amp, Pseq([1, 0.5], inf) * 3,
    \rate, -5.midiratio,
    \buf, Pseq([~pizziSamples[2], ~pizziSamples[2]].stutter(1), inf)
).play(t, quant: [1]);
)

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([Rest(0.25), 1.5, 0.25] ++ [Rest(0.5), 1.25, 0.25], inf),
    \amp, Pseq([1, 0.5], inf) * 3,
    \rate, -5.midiratio,
    \buf, Pseq([~pizziSamples[2], ~pizziSamples[2]].stutter(1), inf)
).play(t, quant: [1]);
)