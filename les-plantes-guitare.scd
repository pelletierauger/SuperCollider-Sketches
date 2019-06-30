(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords2,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.6].stutter(48) - 0.05, inf)
    + 0.1
    + Pseq(Pseries(0, 0.001, 24).asStream.nextN(24).mirror2, inf),
    \rel, 2.75,
    \amp, [1, 1, 0.8] * 8,
    \rate, [0.5, 1, 2] * -3.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)


// inspirante gigue vers l'avant
(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/1,
    \spos, Pseq([0.1, 0.2, 0.4].stutter(16) + 0.1, inf)
    + 0.2
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 2.5,
    \amp, 8,
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-0.5, 0.5, inf)
).play();
)

(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 2/1,
    \spos, Pseq([0.1, 0.2, 0.4].stutter(16) + 0.1, inf)
    + 0.2
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 2.5,
    \amp, 8,
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-0.5, 0.5, inf)
).play();
)