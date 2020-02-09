(
var key = ~toMidi.("E4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key - 2 + [-24 + 7, 4 - 12, 0, 7, 11];
var nn = (notes ++ notes2);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(1!4 ++ 2, inf),
    \amp, Pseq(1!4 ++ 0.5, inf) * 0.5
).play(quant: [4, -0.4]);
~piaBas.stop;
~tamb.stop;
)

(
var key = ~toMidi.("A5");
var notes = key + [0, -8, -6, 4 - 12, 11] - 0;
// var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes.reverse.stutter(1);
~piaHaut.stop;
~piaHaut = Pbind(
    \type, \playPiano,
    \dur, Pseq([2,2,1,2,1] ++ [Rest(1),2,2,1,2] * 0.25, inf),
    \num, Pseq(nn, inf) + Pseq([0, 0], inf),
    \dyn, Pseq([2, 2, 2, 2, 2], inf),
    \amp, Pseq(0.15!4 ++ 0.25, inf) * 0.5
).play(quant: [4]);
)

(
var key = ~toMidi.("E4");
var notes = key + [-12 + 7, 4 - 12, 0, 7, 11];
var notes2 = key - 2 + [-12 + 7, 4 - 12, 0, 7, 11];
var nn = (notes ++ notes2).reverse;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(1!4 ++ 2, inf),
    \amp, Pseq(1!4 ++ 0.5, inf) * 0.5
).play(quant: [4, -0.4]);
~piaBas.stop;
~tamb.stop;
)

(
var key = ~toMidi.("E4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key - 2 + [-24 + 7, 4 - 12, 0, 7, 11];
var nn = (notes ++ notes2);
~pia2.stop;
~pia2 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(1!4 ++ 2, inf),
    \amp, Pseq(1!4 ++ 0.5, inf) * 0.5
).play(quant: [2, -0.4]);
~piaBas.stop;
~tamb.stop;
)