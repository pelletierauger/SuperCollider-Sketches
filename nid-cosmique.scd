(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, 1 / 16 * 1,
    \spos, Pseq([0.35], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq(
        [0, 4, 9, 11].wrapExtend(64) ++
        [2, 7, 9, 11].wrapExtend(64) ++
        [0, 4, 9, 11].wrapExtend(64) ++
        [2, 6, 9, 11].wrapExtend(64)
        , inf).midiratio * 0.midiratio * [2] * -8.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t2);
)


(
~pizzz.stop;
~pizzz = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.2], inf),
    \freq, 880 * -6.midiratio *
    Pseq([6 + 12].stutter(30)).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 0.5
).play();
)