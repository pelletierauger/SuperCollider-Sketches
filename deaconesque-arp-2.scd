(
var key = 62 + 12;
var notes = key + [0, 3, 7, 10, 12, 14, 15, 19].mirror2.stutter(4);
~pianoRiff2d.stop;
~pianoRiff2d = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.0625, 0.0625] * 0.5, inf),
    \num, Pseq(notes, inf) + Pseq(
        [-12, 0, 12, 0].wrapExtend(64 * 2) ++
        [-7, 0, 5, 0].wrapExtend(64 * 2) ++
        [-5, 0, 7, 0].wrapExtend(64 * 2), inf),
    \dyn, Pseq([1, 0, 0, 1], inf),
    \amp, Pseq([0.5, 2, 2, 0.5] * 0.5, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 3
).play();
)

(
var key = 62 + 12;
var notes = key + [0, 4, 7, 10, 11, 14, 16, 19].mirror2.stutter(4);
~pianoRiff2d.stop;
~pianoRiff2d = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.0625, 0.0625] * 1, inf),
    \num, Pseq(notes, inf) + Pseq(
        [0, 4, 7, 11].wrapExtend(64 * 2), inf),
    \dyn, Pseq([1, 0, 0, 1], inf),
    \amp, Pseq([0.5, 2, 2, 0.5] * 0.5, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 3
).play(quant: [0.5]);
)
