(
~pattern.stop;
~pattern = Pbind(
    \instrument, \accords,
    \dur, 8.4,
    \spos, 0,
    \rel, 10,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)

(
~pattern2.stop;
~pattern2 = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.3, 0.5, 0.7].stutter(32), inf)
    + 0.1
    + Pseq([Pseries(0, 0.001, 32)], inf)
    + Pwhite(-0.001, 0.001, inf),
    \rel, 1.5,
    \amp, 2,
    \rate, [0.75, 1, 1.5],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)

(
~pattern2.stop;
~pattern2 = Pbind(
    \instrument, \accords,
    \dur, 1/4,
    \spos, Pseq([0.1, 0.3, 0.5, 0.7].stutter(64), inf)
    + 0.1
    + Pseq([Pseries(0, 0.002, 64)], inf)
    + Pwhite(-0.001, 0.001, inf),
    \rel, 1.5,
    \amp, 2,
    \rate, [0.75, 1, 1.5],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)


(
~pattern2.stop;
~pattern2 = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.15].stutter(64), inf)
    + 0.6
    + Pseq(Pseries(0, 0.002, 64).asStream.nextN(64).mirror2, inf)
    + Pwhite(-0.001, 0.001, inf),
    \rel, 1.5,
    \amp, 2,
    \rate, [0.75, 1, 1.5],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)