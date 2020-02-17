(
var key = ~toMidi.("A3");
var notes = key + ([-5, 3, 7, 10] ++ ([0, 3, 9, 10].reverse + 24) ++ ([0, 2, 7, 9] ++ ([0, 3, 9, 10].reverse + 24) - 2));
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.5!1 ++ (0.25!2) ++ (1 - 0.5) ++ (0.25!4), inf),
    \num, Pseq(notes, inf) + Pseq([0, 0.5, -0.5].stutter(8), inf),
    \dyn, Pseq([0, 0, 0, 1], inf),
    \amp, Pseq([2, 2, 2, 0.5], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(quant: [2]);
)