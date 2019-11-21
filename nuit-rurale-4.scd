(
var key = ~toMidi.("B4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 5, -12, 3, 6, 11];
var nn = notes ++ (notes.reverse + 13) ++ notes2 ++ (notes2.reverse + 13);
var du = 0.1!4 ++ 1.6;
var du2 = 0.1!4 ++ 0.6;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(du ++ du2, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [1, -0.2]);
)


(
var key = ~toMidi.("B4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 5, -12, 3, 6, 11];
var nn = notes ++ (notes.reverse + 13) ++ notes2 ++ (notes2.reverse + 13);
var du = 0.1!4 ++ 1.6;
var du2 = 0.1!4 ++ 0.6;
var du3 = (5..1) * 2.pow(-5) + [0, 0, 0, 1 - 0.46875];
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(du ++ du3 * 2, inf),
    \num, Pseq(nn + 0, inf)
).play(t, quant: [1, -0.2]);
)


[1, 2, 3].stutter(2) + [-12, 0]

0.1!4
((5..1) * 2.pow(-5) + [0, 0, 0, 1 - 0.46875]).sum

(5..1) * 2.pow(-5) + [0, 0, 0, 1 - 0.46875]