(
var key = ~toMidi.("D#4");
var c0 = key + [0, 3, 6, 9] + 3 + 12 + 3 - 12;
var nn = c0;
~pia3.stop;
~pia3 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.05!4, 1),
    \num, Pseq(nn, inf)
).play(t);
)

(
var key = ~toMidi.("D#4");
var c0 = key + [-24, 5, 7, 0].reverse + 3 + 12 + 2 - 12;
var nn = c0;
~pia3.stop;
~pia3 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.05!4, 1),
    \num, Pseq(nn, inf)
).play(t);
)