(
var notes = 62 + [-24, -12, 0, 4, 7, 11, 14, 18, 21];
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.0625 * 0.5], 9),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1], inf),
    \amp, Pseq([1], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 6
).play();
)

(
//                C, G,  D,  A,  E,  B,  F#
var notes = 52 + [0, 7, 14, 21, 28, 35, 42] + (({[0, -12, -24].choose})!7);
// notes = [52, 59, 54, 61, 56, 75, 94];
// notes = [52, 59, 54, 61, 56 + 1, 75, 94 + 1];
// notes = [ 52, 59, 66, 73, 80, 87, 70 ];
// notes = [ 28, 47, 66, 49, 68, 75, 94 ];
// notes = [ 52, 35, 66, 73, 68, 63, 81 ];

// notes = [ 52, 59, 66, 61, 56, 63, 70 + 12 ];
// notes = [ 28, 47, 54, 61, 80, 63, 94 ];
notes = [ 28, 47, 66, 73, 56, 87, 82 ].sort;  // posé, juste
notes = [ 28, 59, 54, 73, 68, 87, 82 ];

// notes = [ 52, 59, 42, 49, 80, 63, 70 ].sort;
// notes = [ 52, 35, 42, 73, 68, 75, 94 ];
// notes = [ 52, 47, 66, 61, 68, 75, 70 ];
notes = [ 28, 59, 54, 61, 56, 87, 94 ];     // magique
// notes = [ 52, 35, 66, 61, 80, 63, 82 ];
// notes = [ 28, 59, 54, 61, 56, 63, 94 ];
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.0625 * 0.5], 7),
    \num, Pseq(notes, inf),
    \dyn, Pseq([0], inf),
    \amp, Pseq([1], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 6
).play();
notes;
)

42 - 36

40 + 48

