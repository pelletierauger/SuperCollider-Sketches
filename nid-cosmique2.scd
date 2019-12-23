(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, 1 / 16 * 1,
    \spos, Pseq([0.35], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq(
        [-12, 0, 4, 9, 11].wrapExtend(64) ++
        [-10, 2, 7, 9, 11].wrapExtend(64) ++
        [-3, 0, 4, 9, 11].wrapExtend(64) ++
        [-6, 2, 6, 9, 11].wrapExtend(64)
        , inf).midiratio * 0.midiratio * [2] * -8.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t2);
)


(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, 1 / 16 * 1,
    \spos, Pseq([0.35], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq(
        [-3, 0, 4, 9, 11].wrapExtend(64) ++
        [-6, 2, 6, 9, 11].wrapExtend(64) ++
        [-5, 0, 4, 9, 11].wrapExtend(64) ++
        [-6, 2, 6, 9, 11].wrapExtend(64)
        , inf).midiratio * 0.midiratio * [2] * -8.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t2);
)