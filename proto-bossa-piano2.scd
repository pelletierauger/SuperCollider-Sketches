(
var key = ~toMidi.("A4") + 12;
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24, 0, 3, 6, 10];
var nn = notes ++ (notes2 + 2) ++ notes ++ (notes2 + 4);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [4, -0.4]);
)



(
var baseOsc = rrand(1, 12);
var minOsc = baseOsc - 0.05 / 12;
var maxOsc = baseOsc + 0.05 / 12;
Synth.new(\chirp, [\freq, ~toFreq.("A4") * 4.midiratio, \amp, 4, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
)


(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24, 0, 3, 6, 10];
var nn = notes ++ (notes2 + 2) ++ notes ++ (notes2 + 4);
~piaBas.stop;
~piaBas = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [4, -0.4]);
)


(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24, 0, 3, 6, 10];
var nn = notes ++ (notes2 + 2) ++ notes ++ (notes2 + 4 + [-4, 0, 0, 0, 0]);
~piaBas.stop;
~piaBas = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [4, -0.4]);
)


(
var key = ~toMidi.("A5");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24, 0, 3, 6, 10];
var nn = notes ++ (notes2 + 2) ++ notes ++ (notes2 + 4 + [-4, 0, 0, 0, 0]);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [4, -0.4]);
)