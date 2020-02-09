(
var key = 40;
var notes = key + [0, 4, 7, 11].stutter(3);
~pianoRiff2.stop;
~pianoRiff2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.5], inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([0, 1, 2], inf),
    \amp, Pseq([1, 0.5, 0.25] * 1, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 1
).play(quant: [2]);
)

s.record;
s.stopRecording;
~toMidi.("A0")

(20..110).collect({|i|i.postln})


(20..110).size
110 - 20