(
// G, B, D, F#
// G, A, E, F#
~shimmerE.stop;
~shimmerE = Pbind(
    \instrument, Pseq([\sampler], inf),
    \dur, 1,
    \spos, Pseq([0.6, 0.62].stutter(1), inf) + Pwhite(0.001, 0.0001, inf),
    \rel, 1.5,
    \atk, 0.05,
    \rate, [0].midiratio,
    \amp, 4,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t1, quant: [1]);
)

(
// G, B, D, F#
// G, A, E, F#
~shimmerD.stop;
~shimmerD = Pbind(
    \instrument, Pseq([\sampler], inf),
    \dur, 1 / 16 * 1,
    \spos, Pseq([0.55, 0.549].stutter(1), inf) + Pwhite(0.000125, 0.001, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq([-12, 0].midiratio, inf),
    \amp, 2,
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t2);
)