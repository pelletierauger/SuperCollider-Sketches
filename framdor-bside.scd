(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/1,
    \spos, Pseq([0.1, 0.12, 0.3, 0.5].stutter(8), inf)
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 1.5,
    \amp, 2,
    \rate, [1],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)

(
~guitare2.stop;
~guitare2 = Pbind(
    \instrument, \accords,
    \dur, 1/1 * 2,
    \spos, Pseq([0.2], inf)
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 1.5,
    \amp, 2,
    \rate, [0.5],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)

1/1;


(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/4,
    \spos, Pseq([0.1, 0.3, 0.5].stutter(64), inf)
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 0.25,
    \amp, 2,
    \rate, [0.75, 1, 1.5],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)
