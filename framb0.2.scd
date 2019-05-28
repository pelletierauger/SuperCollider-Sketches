(
~pattern.stop;
~pattern = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.3].stutter(32), inf) + 0.1 + Pseq([Pseries(0, 0.002, 32)], inf),
    \rel, 0.1,
    \amp, 2,
    \rate, [0.75, 1, 1.5, 3],
    \pan, Pwhite(-0.75, 0.75, inf)
).play(t);
)


(
~pattern.stop;
~pattern = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.3, 0.5, 0.7].stutter(32), inf) + 0
    + Pseq([Pseries(0, 0.002, 32)], inf),
    \rel, 1.6,
    \amp, 2,
    \rate, [0.75, 1, 1.5],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)


s.record;
s.stopRecording;

(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 4/1,
    \spos, Pseq(([1, 3, 5, 7]/10).stutter(64), inf)
    + 0.1
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 1.5,
    \amp, 2,
    \rate, [0.5, 1, 2],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)



(
~guitare1.stop;
~guitare1 = Pbind(
    \instrument, \accords,
    \dur, 4/1,
    \spos, Pseq(([1, 3, 5, 7]/10).stutter(4), inf)
    + 0.0
    + Pseq([Pseries(0, 0.001, 64)], inf),
    \rel, 1.5,
    \amp, 2,
    \rate, [0.5, 1, 2],
    \pan, Pwhite(-1.0, 1.0, inf)
).play(t);
)



