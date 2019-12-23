(
var key = ~toMidi.("A3");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
var r = Rest(1);
~pia.stop;
~pia = Pbind(
    \instrument, \sineSynth,
    \atk, 0.001,
    \rel, 1,
    \dur, Pseq([1, 1, 1, r, 1, 1, r, 1, r, 1, 1, r] * 0.5, inf),
    \freq, Pseq([440 * 5.midiratio], inf)
).play(t, quant: [4, 0.02]);
~pia2.stop;
~pia2 = Pbind(
    \instrument, \sineSynth,
    \atk, 0.001,
    \rel, 1,
    \dur, Pseq([1, 1, 1, r, 1, 1, r, 1, r, 1, 1, r] * 0.5, inf),
    \freq, Pseq([440 * 0.midiratio], inf)
).play(t, quant: [4]);
)

(
~acc.stop;
~acc = Pbind(
    \instrument, \sineSynth,
    \atk, 0.001,
    \rel, 0.25,
    \dur, Pseq([Rest(1.5), 0.25, Rest(1.75), 0.5], inf),
    \freq, Pseq(440 * [14, 12].midiratio.stutter(2), inf),
    \amp, 0.5
).play(t, quant: [4]);
)



F, B, D, A, D, E, A, D
(
var f = ~toFreq.("F#3");
var chord = f * [0 - 12, 5 - 12, 8, 16, 20, 22, 28, 8 + 24].midiratio;
~acc.stop;
~acc = Pbind(
    \instrument, \sineSynth,
    \atk, 0.001,
    \rel, 1.75,
    \dur, Pseq(0.025!7 ++ 4, inf),
    \freq, Pseq(chord, inf),
    \amp, 0.5
).play(t, quant: [4]);
)