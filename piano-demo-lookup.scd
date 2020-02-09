
~pianoFunction.(45, 1, 2)
I need a lookup array of buffer indices, and another lookup array of pitch ratios.


(
~pianoMakeTable = {|i, dy = 1|
    var note = i;
    var dynamic = dy;
    var octave = floor(note / 12) - 1;
    var degree = note - 24 % 12;
    var noteDeltas = [-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2];
    var pitch = noteDeltas[degree].midiratio;
    var sampledNote = [1,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3];
    var sampleToGet = (octave - 1) * 3 + sampledNote[degree];
    var dynamicOffset = dynamic - 1 * 23;
    sampleToGet = sampleToGet + dynamicOffset;
    [sampleToGet, pitch];
}
)

~pianoIndices = [];


(
var indices, pitches;
indices = 111.collect({|i| ~pianoMakeTable.(i, 1)[0]});
indices = indices ++ 111.collect({|i| ~pianoMakeTable.(i, 2)[0]});
indices = indices ++ 111.collect({|i| ~pianoMakeTable.(i, 3)[0]});
pitches = 111.collect({|i| ~pianoMakeTable.(i, 1)[1]});
pitches = pitches ++ 111.collect({|i| ~pianoMakeTable.(i, 2)[1]});
pitches = pitches ++ 111.collect({|i| ~pianoMakeTable.(i, 3)[1]});
~indices = indices;
~pitches = pitches;
)

333.do

i * dy

\buf, Pindex(pianoIndices, Pkey(\note) * Pkey(\dyn), inf),
\pitchRatio, Pindex(pianoPitches, Pkey(\note) * Pkey(\dyn), inf),


Synth.new(\pianoSynth, [
    \buf, ~pianoSamples[sampleToGet],
    \rate, pitch.midiratio,
    \pan, rrand(-0.75, 0.75),
    \amp, am,
    \out, 0,
]);

(
var key = ~toMidi.("A4");
var notes = key + [0, 3, 7, 10, 14];
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.1!4 ++ ((2 - (0.1 * 4))!1), inf),
    \num, Pseq(notes, inf) + Pseq([0, 0], inf),
    \dyn, Pseq([2, 1, 1, 1, 2], inf),
    \amp, Pseq([1, 2, 2, 2, 1], inf),
    \pan, Pwhite(-0.75, 0.75, inf)
).play(quant: [2]);
)

(
var key = ~toMidi.("A3");
var notes = key + [0, 3, 7 + 12, 10];
~pianoRiff2.stop;
~pianoRiff2 = Pbind(
    \type, \pianoEvent,
    \dur, 0.5,
    \num, Pseq(notes, inf) + Pseq([0, 0], inf),
    \dyn, Pseq([1, 1, 1, 1], inf),
    \amp, Pseq([1, 1, 1, 1] * 0.5, inf),
    \pan, Pwhite(-0.75, 0.75, inf)
).play(quant: [2]);
)

(
var key = ~toFreq.("A2");
var notes = key * [0, -5].midiratio;
~sineRiff.stop;
~sineRiff = Pbind(
    \instrument, \sineTest,
    \dur, 1,
    \freq, Pseq(notes, inf),
    \dyn, 2,
    \amp, 0.15
).play(quant: [2]);
)