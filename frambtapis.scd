(
~tapis.stop;
~tapis = Pbind(
    \instrument, \accords2,
    \dur, 1/8,
    \spos, Pseq([0.06], inf)
    + Pseq(Pseries(0, 0.001, 12).asStream.nextN(12).mirror2, inf),
    \rel, 0.75,
    \amp, [1, 1, 0.8],
    \rate, [0.5, 1, 2] * -1.midiratio,
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)
