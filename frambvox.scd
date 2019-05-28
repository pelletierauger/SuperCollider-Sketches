(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 4/1,
    \spos, Pseq(([1]/10).stutter(64 * 2), inf)
    + 0.3
    + Pseq(Pseries(0, 0.001, 64).asStream.nextN(64).stutter(2), inf),
    \rel, 1.25,
    \amp, 2,
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)


(
~vox1.stop;
~vox1 = Pbind(
    \instrument, \vox,
    \dur, 4/1,
    \spos, Pseq(([1]/10).stutter(64 * 2), inf)
    + 0.1
    + Pseq(Pseries(0, 0.001, 64).asStream.nextN(64).stutter(2), inf),
    \rel, 0.25,
    \amp, 4,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)

(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 4/1,
    \spos, Pseq(([1, 4]/10), inf)
    + 0.42
    + Pseq(Pseries(0, 0.001, 64).asStream.nextN(64).stutter(2), inf),
    \rel, 1.25,
    \amp, 2,
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)

(
~vox1.stop;
~vox1 = Pbind(
    \instrument, \vox,
    \dur, 1/1,
    \spos, Pseq(([1]/10).stutter(64 * 2), inf)
    + 0.2
    + Pseq(Pseries(0, 0.001, 64).asStream.nextN(64).stutter(2), inf),
    \rel, 0.5,
    \amp, 4,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)



// --------


(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 4/1,
    \spos, Pseq(([1, 4]/10), inf)
    + 0.42
    + Pseq(Pseries(0, 0.001, 64).asStream.nextN(64).stutter(2), inf),
    \rel, 1.25,
    \amp, 2,
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)

(
~vox1.stop;
~vox1 = Pbind(
    \instrument, \vox,
    \dur, 1/1,
    \spos, Pseq(([1]/10).stutter(64 * 2), inf)
    + 0.2
    + Pseq(Pseries(0, 0.001, 64).asStream.nextN(64).stutter(2), inf),
    \rel, 0.5,
    \amp, 4,
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)
