(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(1!4 ++ 2, inf),
    \amp, Pseq(1!4 ++ 0.5, inf)
).play(t, quant: [4, -0.4]);
~piaBas.stop;
~tamb.stop;
)