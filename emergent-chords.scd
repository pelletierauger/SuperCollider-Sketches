~chords = [\Bbmajor7, \Gminor7, \Ebmajor7, \Cminor7, \Fdom7, \Bb6by9];
~chords = [\Bbmajor7, \Gminor7, \Ebmajor7, \Cminor7, \Fdom7];
~prog = ChordSymbol.noteProgression(~chords);
~pro = ~prog.flatten;
~pro.size


(
var key = 62;
var notes = key + ([0, 3, 7, 10] ++ [-5, 2, 3, 9]);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0, 1, 1, 1], inf),
    \num, Pseq(~pro + 24 + 24, inf) + Pseq([-12, 0, 0, 12], inf)h,
    \dyn, Pseq([0, 0, 0, 1], inf),
    \amp, Pseq([0.5, 2, 2, 0.5], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(quant: [2]);
)