(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([1, 0.8].stutter(24) * 0.5, inf),
    \freq, 880 * -2.midiratio *
    Pseq([7, 3].stutter(24), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(8) * 0.75, inf) * 0.5
).play(t);
)

t.elapsedBeats


(
t.beats.postln;
t.beats.ceil + 4;
)


(
~eachBeat = {
 ~piz3 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([1, 0.8].stutter(24) * 0.5, 1),
    \freq, 880 * -2.midiratio *
    Pseq([7, 3].stutter(24), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(8) * 0.75, inf) * 0.5
).play(t);
}
)

~eachBeat.()