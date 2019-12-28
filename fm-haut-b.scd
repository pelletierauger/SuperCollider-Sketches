// F#m-b7
// F#, A, C#, E
(
Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.1], inf),
    \freq, 880 * -2.midiratio *
    Pseq([-1].stutter(60)).midiratio * 4,
    \amp, Pseq(Pgeom(1, 0.95, 60).asStream.nextN(60) * 0.75, inf) * 0.125
).play();
Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.1], inf),
    \freq, 880 * -2.midiratio *
    Pseq([2].stutter(60)).midiratio * 4,
    \amp, Pseq(Pgeom(1, 0.95, 60).asStream.nextN(60) * 0.75, inf) * 0.125
).play();
Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.1], inf),
    \freq, 880 * -2.midiratio *
    Pseq([6].stutter(30)).midiratio * 4,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 0.125
).play();
Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.1], inf),
    \freq, 880 * -2.midiratio *
    Pseq([9].stutter(30)).midiratio * 4,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 0.125 * 0.5
).play();
)


(
var key = ~toFreq.("G9");
var chords = key * [-1, 2, 6, 9].midiratio.reverse;
chords.do(
    {
        |note, i|
        Pbind(
            \instrument, \pizzicato,
            \dur, Pseq((i * 0.04)!1 ++ (0.1!118), inf),
            \rel, 1,
            \freq, note,
            \amp, Pseq(Pgeom(1, 0.92, 60).asStream.nextN(60).reverse.mirror * 0.75, 1) * 0.25
        ).play();
    }
);
)

(
var key = ~toFreq.("D8");
var chords = key * [-5, 0, 4, 11].midiratio;
chords.do(
    {
        |note, i|
        Pbind(
            \instrument, \pizzicato,
            \dur, Pseq((i * 0.04)!1 ++ (0.1!118), inf),
            \rel, 1,
            \freq, note,
            \amp, Pseq(Pgeom(1, 0.92, 60).asStream.nextN(60).reverse.mirror * 0.75, 1) * 0.125
        ).play();
    }
);
)


(
var key = ~toFreq.("E7");
var chords = key * [0, 3, 7, 10].midiratio;
chords.do(
    {
        |note, i|
        Pbind(
            \instrument, \pizzicato,
            \dur, Pseq((i * 0.04)!1 ++ (0.1!118), inf),
            \rel, 1,
            \freq, note,
            \amp, Pseq(Pgeom(1, 0.92, 60).asStream.nextN(60).reverse.mirror * 0.75, 1) * 0.25
        ).play();
    }
);
)