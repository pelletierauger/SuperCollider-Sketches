(
var key = ~toMidi.("A6");
var notes = key + [-12, -8, -6, 4 - 12, 11 - 12] - 0;
// var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes.reverse.stutter(1);
~piaHaut.stop;
~piaHaut = Pbind(
    \type, \playPiano,
    \dur, Pseq([2,2,1,2,1] ++ [Rest(1),2,2,1,2] * 0.5, inf),
    \num, Pseq(nn, inf) + Pseq([0, 0], inf),
    \dyn, Pseq([2, 2, 2, 2, 2], inf),
    \amp, Pseq(0.15!4 ++ 0.75, inf)
).play(t, quant: [4]);
)