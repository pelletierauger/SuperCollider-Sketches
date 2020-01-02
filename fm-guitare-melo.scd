(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.8], inf),
    \freq, 880 * -2.midiratio *
    Pseq([9, 7, 9, 2].stutter(4), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(8) * 0.75, inf) * 0.5
).play();
)


(
// G, B, D, F#
// G, A, E, F#
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, 1 / 16 * 1,
    \spos, Pseq([0.45], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq(
        [0, 4, 7 - 12, 12].wrapExtend(64) ++
        [0, 2, 9 - 12, 12].wrapExtend(64)
        , inf).midiratio * 0.midiratio * [2] * -8.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t2);
)