(
var key = ~toMidi.("D5");
var notes = key + [-24 + -7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] - 1;
var notes3 = key + [-24, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 12, 0, 3, 6, 12];
var nn = notes4 ++ notes3 ++ notes;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.125!3) ++ 0.125 * 2, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)


(
var key = ~toMidi.("A5");
var notes = key + [-24, -5, 2, 5, 11, 12].mirror + 12;
var nn = notes;
~pia2.stop;
~pia2 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.125!4, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)

(
var key = ~toMidi.("A3");
var notes = key + [-24, -5, 2, 5, 11, 12].mirror + 12;
var notes2 = key + [-24, -5, 4, 7, 11, 12].mirror + 12;
var nn = notes ++ notes ++ notes2 ++ notes2;
~pia3.stop;
~pia3 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.25!4, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)

(
var key = ~toMidi.("A3");
var notes = key + [-24, -6, 3, 6, 9, 12].mirror + 12;
var notes2 = key + [-24, -5, 4, 7, 11, 12].mirror + 12;
var nn = notes ++ notes ++ notes2 ++ notes2;
~pia3.stop;
~pia3 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.25!4, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)