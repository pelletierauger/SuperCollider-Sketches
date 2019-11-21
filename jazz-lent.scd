(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] + 3;
var notes3 = key + [-24 + 7, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 5, -12, 3, 6, 11];
var nn = notes ++ notes2 ++ notes3 ++ notes4;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.1!3) ++ 1 * 2, inf),
    \num, Pseq(nn, inf) + Pseq(-12!1 ++ (0!4), inf)
).play(t, quant: 1);
)

(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] + 3;
var notes3 = key + [-24 + 7, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 5, -12, 3, 6, 11];
var nn = notes ++ notes2 ++ notes3 ++ notes4;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.025!3) ++ 1 * 4, inf),
    \num, Pseq(nn, inf) + Pseq(-12!1 ++ (0!4), inf)
).play(t, quant: 1);
)