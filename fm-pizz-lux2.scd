(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.1], inf),
    \freq, 220 * -3.midiratio *
    Pseq([19, 12, 14].stutter(30), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 4.5)
).play();
)

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.1], inf),
    \freq, 440 * 4.midiratio *
    Pseq([19, 12, 14].stutter(10), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 1,
    \mult, 1.85 - (Pkey(\amp, inf) * 4.5)
).play();
)
