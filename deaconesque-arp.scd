(
var key = 62 + 24;
var notes = key + [0, 3, 7, 10, 12, 14, 15, 19].mirror2;
~pianoRiff2c.stop;
~pianoRiff2c = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.0625], inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 0, 0, 1], inf),
    \amp, Pseq([0.5, 2, 2, 0.5] * 0.5, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 1
).play(quant: [2]);
)


(
var key = 62 + 0;
var notes = key + [0, 3, 7, 10, 12, 14, 15, 19].mirror2;
~pianoRiff2.stop;
~pianoRiff2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.125], inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 0, 0, 1], inf),
    \amp, Pseq([0.5, 2, 2, 0.5] * 1, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 1
).play(quant: [2]);
)



(
var key = 62 + 12;
var notes = key + [0, 3, 7, 10, 12, 14, 15, 19].mirror2.stutter(2);
~pianoRiff2d.stop;
~pianoRiff2d = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.0625, 0.0625], inf),
    \num, Pseq(notes, inf) + Pseq(
        [-12, 0].wrapExtend(64) ++
        [-7, 0].wrapExtend(64) ++
        [-5, 0].wrapExtend(64), inf),
    \dyn, Pseq([1, 0, 0, 1], inf),
    \amp, Pseq([0.5, 2, 2, 0.5] * 0.5, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 3
).play(quant: [2]);
)

[0, 3, 7, 10, 12, 14, 15, 19].mirror2.stutter(2).size