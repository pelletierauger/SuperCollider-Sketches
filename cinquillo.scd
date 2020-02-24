(
var key = 62;
var notes = key + ([0, 3, 7, 10] ++ [-5, 2, 3, 9]);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([1, 0.5, 1, 0.5, 1] ++ [Rest(), 1, 1, 0.5, 0.5] * 0.5, inf),
    \dur, Pseq([1, 0.5, 1, 0.5, 1] * 0.5, inf),
    // \dur, Pseq([1, Rest(0.5), 1, Rest(0.5), 1] * 0.5, inf),
    // \dur, Pseq([1, 0.5, 1, 0.5, 1, Rest(1), 1, 2] * 0.5, inf),
    \num, Pseq(72 + 12 + [19, 0, 12, 0, 12], inf) + Pseq([0].stutter(2), inf),
    \num, 72 + Pseq([19, 12, 12, 12, 12], inf) + Pseq([0, 0].stutter(5), inf),
    // \num, Pseq(72 + 12 + [12, 0, 12, 0, 12, 12, 12, 0, 12, 0], inf),
    \dyn, Pseq([1, 0, 1, 0, 1], inf),
    \amp, Pseq([0.5, 1, 0.5, 1, 0.5], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 1
).play(quant: [1]);
~pianoRiff2.stop;
~pianoRiff2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.0625, 1 - 0.0625, 0.0625, 1 - 0.0625 - 0], inf),
    \num, Pseq(72 - 0 + [-8, -1, -5, -8, -8, -1, -5, -8].stutter(1), inf) + Pseq([0, -5].stutter(4), inf),
    \dyn, Pseq([1, 0, 0, 0, 0], inf),
    \amp, Pseq([0.5, 2, 2, 2, 2], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 3
).play(quant: [1, -0.0625 + 0]);
)

([1, 0.5, 1, 0.5, 1] * 0.5).sum

(
~pianoRiff.stop;
~pianoRiff2.stop;
)