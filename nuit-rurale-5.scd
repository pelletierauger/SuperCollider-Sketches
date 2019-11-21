(
var key = ~toMidi.("D5");
var notes = key + [-24 + -7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] - 1;
var notes3 = key + [-24, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 12, 0, 3, 6, 12];
var nn = notes4 ++ notes3 ++ notes + 12;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.125!3) ++ 0.125 * 2, inf),
    \num, Pseq(nn, inf) + Pseq(-12!1 ++ (0!4), inf)
).play(t, quant: 1);
)