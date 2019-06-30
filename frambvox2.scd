(
~vox2.stop;
~vox2 = Pbind(
    \instrument, \vox,
    \dur, Pseq(1!8 ++ 8 * 0.25, inf),
    \spos, Pseq(([1.5]/10).stutter(64 * 2), inf)
    + Pseq(Pseries(0, 0.001, 64).asStream.nextN(64).stutter(2), inf),
    \rel, 0.25,
    \amp, 8,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)

1!4 ++ 4 * 0.5;

(
~vox2.stop;
~vox2 = Pbind(
    \instrument, \vox,
    \dur, Pseq(1!8 ++ 8 * 0.125, inf),
    \spos, Pseq(([6.5]/10).stutter(64 * 2), inf)
    + Pseq(Pseries(0, 0.01, 8).asStream.nextN(8).stutter(2), inf),
    \rel, 0.5,
    \amp, 8,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)

// lent début à la ma doudou
(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords2,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.6].stutter(48) - 0.05, inf)
    + 0.0
    + Pseq(Pseries(0, 0.001, 24).asStream.nextN(24).mirror2, inf),
    \rel, 0.75,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)


(
~vox2.stop;
~vox2 = Pbind(
    \instrument, \vox,
    \dur, Pseq(1!8 ++ 8 * 0.125, inf),
    \spos, Pseq(([4]/10), inf)
    + Pseq(Pseries(0, 0.001, 8).asStream.nextN(8).stutter(2), inf),
    \rel, 0.125,
    \amp, 8,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)