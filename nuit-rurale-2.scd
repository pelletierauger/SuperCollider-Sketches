(
var key = ~toMidi.("B4");
var notes = key + [-24 + -7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] - 1;
var notes3 = key + [-24, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 12, 0, 3, 6, 9];
var nn = notes4 ++ notes3 ++ notes;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.125!3) ++ 0.125 * 2, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)

(0.5!1 ++ (0.125!3) ++ 0.125 * 2).sum


(
var key = ~toMidi.("B4");
var notes = key + [-24 + -7, 4 - 12, 0, 7, 11] + 2;
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] - 1;
var notes3 = key + [-24 + 12,  -12 + 2, -7, 5, 12] + 2;
var notes4 = key + [-24 + 12, 0, 3, 6, 9] - 2;
var nn = notes4 ++ notes3 ++ notes + 12;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.125!3 * [1, 0.5, 0.25]) ++ 0.25 * 2, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)


0.125!3 * [1, 0.5, 0.25]

2 - (0.5!1 ++ (0.125!3 * [1, 0.5, 0.25]) ++ (0.25 + 2.pow(-5)) * 2).sum
0.0625 * 0.5

(4..1)/4



(
var key = ~toMidi.("B4");
var notes = key + [-24 + -7, 4 - 12, 0, 7, 11] + 2;
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] - 1;
var notes3 = key + [-24 + 12,  -12 + 2, -7, 5, 12] + 2;
var notes4 = key + [-24 + 12, 0, 3, 6, 9] - 2;
var nn = notes4 ++ notes3 ++ notes + 12;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.125!3 * [1, 0.5, 0.25]) ++ (0.25 + 2.pow(-5)) * 2, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)





(
var key = ~toMidi.("B4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 5, -12, 3, 6, 11];
var nn = notes ++ notes2;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 1.6, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [1, -0.2]);
)


(0.1!4 ++ 1.6).sum



(
var key = ~toMidi.("B4");
var notes = key + [-24 + 7, 4 - 12, 0 - 12, 7 - 12, 11 - 12];
var notes2 = key + [-24 + 7, -12, 3, 7, 12] + 5 - 12;
var notes3 = key + [-24, -12 - 5, 4 - 12, -2, 10] + 8 - 12;
var nn = notes ++ notes3 ++ (notes2 + 0) + 2 + 0;
var dur = 0.1!4 ++ 1.6;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(dur ++ (dur * 0.5) ++ (dur * 0.5) * 2, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [1, -0.2]);
)

().sum
