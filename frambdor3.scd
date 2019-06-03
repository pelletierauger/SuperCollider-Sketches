(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/2,
    \spos, Pseq([0.1, 0.15].stutter(64) + 0.1, inf)
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 1.25,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)

(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.15].stutter(64) + 0.2, inf)
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 0.25,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)

(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.7].stutter(64) - 0.075, inf)
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 1.25,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)


(
~guitare1b.stop;
~guitare1b = Pbind(
    \instrument, \accords2,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.7].stutter(64) - 0.075, inf)
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 1.25,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)





(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords2,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.95, 0.97].stutter(4) - 0.075, inf)
    + Pseq([Pseries(0, 0.001, 32)], inf),
    \rel, 0.35,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2, 4] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)

(
~dron1.stop;
~dron1 = Pbind(
    \instrument, \accords2,
    \dur, 1/8,
    \spos, Pseq([0.1].stutter(4) - 0.075, inf)
    + Pseq([Pseries(0, 0.001 * 0.25, 4)], inf),
    \rel, 0.45,
    \amp, [1, 1, 1, 1] * 4,
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)

(
~dron2.stop;
~dron2 = Pbind(
    \instrument, \accords,
    \dur, 1/2,
    \spos, Pseq([0.95].stutter(4), inf)
    + Pseq([Pseries(0, 0.001, 32)], inf),
    \rel, 1.45,
    \amp, [1, 1, 1, 1] * 4,
    \rate, [1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)


(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords2,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.6, 0.94].stutter(48) - 0.05, inf)
    + Pseq(Pseries(0, 0.001, 24).asStream.nextN(24).mirror2, inf),
    \rel, 0.75,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)