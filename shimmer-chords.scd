(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, 1 / 16 * 1,
    \spos, Pseq([0.35], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq(
        [-5, 0, 2, 4].wrapExtend(128) ++
        [-4, -1, 2, 5].wrapExtend(64) ++
        [-4, -1, 3, 5].wrapExtend(64) ++
        [-5, -3, 0, 4].wrapExtend(64)
        , inf).midiratio * 0.midiratio * [1, 2] * 2,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)



(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \bouette,
    \dur, Pseq([2, 1, 1], inf),
    \freq, ~toFreq.("D#3") * Pseq([3, 2, 5, 7].midiratio, inf),
    \amp, 0.125
).play(quant: [1, 0.5]);
)

