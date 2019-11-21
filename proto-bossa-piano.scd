(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [4, -0.4]);
~piaBas.stop;
~tamb.stop;
)

(
var key = ~toMidi.("A5") + 0 - 12;
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
nn = (key + 16)!1 ++ ((key + 7)!2) ++ (key + 11) + 12;
~tamb.stop;
~tamb = Pbind(
    \type, \playPiano,
    \dur, Pseq([2,2,1,2,1] ++ [Rest(1),2,2,1,2] * 0.5, inf),
    \num, Pseq(nn, inf)
).play(t, quant: 4);
)

(
var key = ~toMidi.("A3");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
nn = [key, key - 5].stutter(8);
nn = [key, key];
~surdo.stop;
~surdo = Pbind(
    \type, \playPiano,
    \dur, Pseq(2!1, inf),
    \num, Pseq(nn, inf)
).play(t, quant: 4);
)

(4..1)/4;

[2,2,1,2,1] ++ [Rest(1),2,2,1,2] * 0.25;
~toMidi.("A4")

(
var key = ~toMidi.("A5") - 0;
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
nn = key;
~tamb2.stop;
~tamb2 = Pbind(
    \type, \playPiano,
    \dur, Pseq([2,2,1,2,1] ++ [Rest(1),2,2,1,2] * 0.5, inf),
    \num, Pseq(nn!1, inf)
).play(t, quant: [4, -0.05]);
)