(
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.125, 8)], inf),
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.25, 0.25], inf),
    \amp, Pseq([1, 0.75, 0.75, 0.5], inf) * 3,
    \rate, 1,
    \num, Pseq([11, 11, 0, 11], inf),
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
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.125, 8)], inf),
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
).play(t, quant: [2]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.75, 0.25], inf),
    \amp, Pseq([1, 0.75, 0.75, 0.5], inf) * 3,
    \rate, 1,
    \num, Pseq([11, 11, 10, 11], inf),
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
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.125, 8)], inf),
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.75], inf),
    \amp, Pseq([1, 0.75], inf) * 3,
    \rate, 1,
    \num, Pseq([11, 0], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)

0.75/2


Muguet qui avance bellement
(
~piz3.stop;
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
    \dur, Pseq(Rest(0.75/2)!3 ++ [0.75/2] ++ ([Rest(0.75/2), 0.75/2]!2).flat, inf),
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
    \amp, Pseq([0.5, 0.125, 0.75, 0.125], inf) * 32 * Pseq([Pseries(1, -0.125, 8)], inf),
    // \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
    \num, Pseq([7, 7, 6, 6].stutter(1), inf),
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf),
    \out, Pseq([~reverbBus, ~reverbBus2].stutter(8), inf)
    // \out, 0
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq(Rest(0.75/2)!3 ++ [0.75/2] ++ ([Rest(0.75/2), 0.75/2]!2).flat, inf),
    \amp, Pseq([1, 0.75], inf) * 3,
    \rate, 1,
    \num, Pseq([11, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf),
    \out, Pseq([~reverbBus, ~reverbBus2].stutter(8), inf)
    // \out, 0
).play(t, quant: [1]);
)


(
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.125, 8)], inf),
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf),
     \out, Pseq([~reverbBus, ~reverbBus2].stutter(8), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.25, 0.25], inf),
    \amp, Pseq([1, 0.75, 0.75, 0.5], inf) * 3,
    \rate, 1,
    \num, Pseq([11, 11, 0, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf),
     \out, Pseq([~reverbBus, ~reverbBus2].stutter(8), inf)
).play(t, quant: [1]);
)

(
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.125, 8)], inf),
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf),
    \out, Pseq([~reverbBus, ~reverbBus2].stutter(8), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.75, 0.25], inf),
    \amp, Pseq([1, 0.75, 0.75, 0.5], inf) * 3,
    \rate, 1,
    \num, Pseq([11, 11, 0, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf),
    \out, Pseq([~reverbBus, ~reverbBus2].stutter(8), inf)
).play(t, quant: [1]);
)