(
var key = ~toMidi.("B4");
var notes = key + [-12, -8, -5, 4 - 12, 10 - 12] + 17 + 12;
// var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes.reverse.stutter(4);
~piaHaut.stop;
~piaHaut = Pbind(
    \type, \playPiano,
    \dur, Pseq(1!20 * 0.25, inf),
    \num, Pseq(nn, inf) + Pseq([-12, 0], inf)
).play(t);
)


(
var key = ~toMidi.("A6");
var notes = key + [-12, -8, -6, 4 - 12, 11 - 12] - 0;
// var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes.reverse.stutter(1);
~piaHaut.stop;
~piaHaut = Pbind(
    \type, \playPiano,
    \dur, Pseq([2,2,1,2,1] ++ [Rest(1),2,2,1,2] * 0.5, inf),
    \num, Pseq(nn, inf) + Pseq([0, 0], inf)
).play(t, quant: [4]);
)


(
var baseOsc = rrand(0.25, 1);
var minOsc = baseOsc - 0.05 / 12;
var maxOsc = baseOsc + 0.05 / 12;
Synth.new(\chirp, [\freq, ~toFreq.("A4") * 6.midiratio, \amp, 8, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
)


(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24, 0, 3, 6, 10];
var nn = notes ++ (notes2 + 2) ++ notes ++ (notes2 + 4 + [-4, 0, 0, 0, 0]);
var keyB = ~toMidi.("A5");
var notesB = keyB + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2B = keyB + [-24, 0, 3, 6, 10];
var nnB = notesB ++ (notes2B + 2) ++ notesB ++ (notes2B + 4 + [-4, 0, 0, 0, 0]);
~piaHaut.stop;
~piaBas.stop;
~piaBas = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [4, -0.4]);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nnB, inf)
).play(t, quant: [4, -0.4]);
)