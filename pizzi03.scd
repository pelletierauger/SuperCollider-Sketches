(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([Rest(0.25), 1.5, 0.25] ++ [Rest(0.5), 1.25, 0.25], inf),
    \amp, Pseq([1, 0.5], inf) * 3,
    \rate, -1.midiratio,
    \buf, Pseq([~pizziSamples[2], ~pizziSamples[2]].stutter(1), inf)
).play(t, quant: [1]);
)


(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([0.25], inf),
    \amp, Pseq([1, 0.25], inf) * 3,
    \rate, Pseq([1, -5.midiratio], inf),
    \buf, Pseq([~pizziSamples[11], ~pizziSamples[11]].stutter(1), inf)
).play(t, quant: [1]);
)

(
~piz4.stop;
~piz4 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([2], inf),
    \amp, Pseq([1, 1], inf) * 1.5,
    \rate, 1,
    \buf, Pseq([~pizziSamples[0]].stutter(1), inf)
).play(t, quant: [1]);
)
