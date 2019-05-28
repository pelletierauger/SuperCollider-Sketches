(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/2,
    \spos, Pseq([0.1, 0.3].stutter(32), inf)
    + Pseq([Pseries(0, 0.001, 32)], inf),
    \rel, 1.5,
    \amp, [1, 1, 0.75],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)

(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/2,
    \spos, Pseq([0.1, 0.3].stutter(32) + 0.2, inf)
    + Pseq([Pseries(0, 0.001, 32)], inf),
    \rel, 1.5,
    \amp, [1, 1, 0.75],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)