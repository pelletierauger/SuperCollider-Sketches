(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 10,
    \spos, 0,
    \rel, 10,
    \amp, 2,
    \rate, [1],
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)

// d'or
(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/4,
    \spos, Pseq([0.1, 0.3].stutter(32), inf)
    + Pseq([Pseries(0, 0.001, 32)], inf),
    \rel, 1,
    \amp, [1, 1, 0.75],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)

(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/1,
    \spos, Pseq([0.1, 0.3].stutter(32) + 0.1, inf)
    + Pseq([Pseries(0, 0.001, 32)], inf),
    \rel, 1,
    \amp, [1, 1, 0.75],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)



(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.15].stutter(64) + 0.3, inf)
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 0.25,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2],
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)
