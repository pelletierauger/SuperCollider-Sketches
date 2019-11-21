(
var key = ~toMidi.("B4");
var notes = key + [-24 + -7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] - 1;
var notes3a = key + [-12, -12 + 3, 0, 7, 10] + 3;
var notes3 = key + [-24, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 12, 0, 3, 6, 9];
var nn = notes4 ++ notes3a ++ notes3 ++ notes;
var d = 0.5!1 ++ (0.125!3) ++ 0.125 * 2;
var d2 = (0.125!4 * ((4..1)/4)) ++ 0.5;
d = d ++ d2 ++ d ++ d;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(d, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)


(
var key = ~toMidi.("B4");
var notes = key + [-24 + 0, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] - 1;
var notes3a = key + [-12, -12 + 3, 0, 7, 10] + 3;
var notes3 = key + [-24, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 12, 0, 3, 6, 9];
var nn = notes4 ++ notes3a ++ notes3 ++ (notes + 1) ++ (notes.scramble + 12) + 0;
var d = 0.5!1 ++ (0.125!3) ++ 0.125 * 2;
var d2 = (0.125!4 * ((4..1)/4)) ++ 0.5;
d = d ++ d2 ++ d ++ d2 ++ (d2 * 1);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(d, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)


(0.5!1 ++ (0.125!3) ++ 0.125 * 2).sum

1 - ((0.125!4 * ((4..1)/4)) ++ (0.5 + 0.1875)).sum


(
var key = ~toMidi.("B4");
var notes = key + [-24 + 0, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] - 1;
var notes3a = key + [-12, -12 + 3, 0, 7, 10] + 3;
var notes3 = key + [-24, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 12, 0, 3, 6, 9];
var nn = notes4 ++ notes3a ++ notes3 ++ (notes + 1) ++ (notes.scramble + 12) + 0;
var d = 0.5!1 ++ (0.125!3) ++ 0.125 * 2;
var d2 = (0.125!4 * ((4..1)/4)) ++ (0.5 + 0.1875);
d = d ++ d2 ++ d ++ d2 ++ (d2 * 1);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(d, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)
