~makeScale.([-2, 5]);  // Phrygian,
(
var key = ~toMidi.("D#4");
var repeats = 2; // repeats must be a positive integer.
var transpositions = [0, 0].stutter(3);
var progression = [0, 2, 4, 1];
// var chords = ~chords[progression];
var chords = [[  0, 3, 7 ], [ -2, 3, 7 ], [ -2, 1, 7 ], [ -4, 1, 5 ]];
// var chords = [[ 3, 7, 12 ],  [ 3, 7, 10 ], [ 7, 10, 13 ], [ 5, 8, 13]];
var noteIndex = Pseq((0..((chords.stutter(repeats).size*3)-1)), inf).asStream;
var keyIndex = Pseq((0..(chords.size-1)), inf).asStream;
var arpeggio = 0.01;
var r = repeats;
var pr = progression;
var scale = chords.collect({|item|item[0]});
~ascendingChords.stop;
~ascendingChords = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([arpeggio, arpeggio, 8 - (arpeggio * 2)] * r.reciprocal, inf),
    \num, key + FuncStream({
        var n = noteIndex.next;
        // Code to display the Chord functions in the Post window.
        var names = ["I", "II", "III", "IV", "V", "VI", "VII"];
        var c = chords.stutter(repeats).[n/3];
        var name = if (c[1] - c[0] == 4, {names[pr[n/3/r]]}, {names[pr[n/3/r]].toLower});
        var pad = 12;
        if (c[2] - c[0] == 6, {name = name ++ "°"; pad = pad + 1});
        name = ("Chord " ++ name).padRight(pad, string: " ");
        if (n % (3*r) == 0, {((name + chords.stutter(repeats).[n / 3])).postln});
        // End of code to display the Chord functions in the Post window.
        (chords.stutter(repeats).flat + transpositions).[n];
    }),
    \dyn, 1,
    \amp, Pseq([0.25, 0.5, 1] * 0.25, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(~nT, quant: [8, 0.05]);
~ascendingRootNotes.stop;
~ascendingRootNotes = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([8], inf),
    // \num, Pseq(key - 24 + ~scale[0..6], inf),
    // \num, key - 24 + FuncStream({scale[keyIndex.next]}),
    \num, key - 24 + Pseq([0, -2, -2, -4], inf),
    \dyn, Pseq([0], inf),
    \amp, Pseq([0.5, 0.25] * 1, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(~nT, quant: [8, 0.05]);
)
