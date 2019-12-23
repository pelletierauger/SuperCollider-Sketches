(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.01, 0.5, 0.5], inf),
    \freq, 880 * -2.midiratio *
    Pseq([7, 11, 14], inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(8).stutter(3) * 0.75, inf) * 0.75 *
    Pseq([1, 1, 0.5], inf)
).play();
)