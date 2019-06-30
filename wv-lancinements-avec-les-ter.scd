(
~muds2.stop;
~muds2 = Pbind(
    \instrument, \muddy,
    \dur, Pseq([0.125] * 4, inf),
    \freq, ~toFreq.("A3") * Pseq([7, 5].stutter(1).midiratio, inf) * [1],
    \atk, 0.00125,
    \atk, 0.25,
    // \atk, Pseq([0.00125, 0.0125, 0.125, 0.25], inf),
    \rel, 4,
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 1, inf),
    \startF, Pseq(Pgeom(0.1, 1.1, 48).asStream.nextN(48).mirror, inf),
    // \startF, Pseq([Plazy(~sinTime)], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(quant: 1);
)

(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \muddy,
    \dur, Pseq([0.125] * 8, inf),
    \freq, ~toFreq.("A4") * Pseq([12, 9, 14, 9, 16, 9].stutter(1).midiratio, inf) * [1],
    \atk, 0.00125,
    \atk, 0.25,
    // \atk, Pseq([0.00125, 0.0125, 0.125, 0.25], inf),
    \rel, 8,
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 1, inf),
    \startF, Pseq(Pgeom(0.1, 1.1, 48).asStream.nextN(48).mirror, inf),
    // \startF, Pseq([Plazy(~sinTime)], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(quant: 1);
)