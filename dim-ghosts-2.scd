



a = [1, 1, 3, 1, 1, 1, 3, 1];
a = [1, 2, 1, 2, 1, 2, 1, 2];
a = [2, 2, 1, 1, 2, 2, 1, 1];

(
~n = 0;
b = ([0] ++ a.collect({arg item, i; ~n = ~n + item; ~n;})).wrapExtend(a.size);
)
~n;
b;
a;

[1, 2, 3].wrapExtend(1)



a = [2, 2, 1, 1, 2, 2, 1, 1];
(
var key = ~toMidi.("E#3");
// var chord0 = [b[0], b[2], b[4], b[6]] + [-12, 0, 0, 0];
var shift = [-12, 0, 12, 12];
var chord0 = [b[2], b[4], b[6], b[0] + 12] + shift;
// var chord1 = [b[1], b[3], b[5], b[7]] + [-12, 0, 0, 0];
var chord1 = [b[5], b[7], b[1] + 12, b[3] + 12] + shift;
var chord2 = [b[4], b[6], b[0] + 12, b[2] + 12] + shift;
var nn = chord0.wrapExtend(4)/* ++ (chord1.wrapExtend(8))*/
 ++ (chord2.wrapExtend(4) + 1) ++ (chord1.wrapExtend(8) - 3);
nn = nn + [-1, 0, 0, -1].wrapExtend(nn.size);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq([0.35], inf),
    \num, Pseq(key + nn, inf),
    // + Pseq((-12!1 ++ (0!9)).wrapExtend(20) + (12!1 ++ (0!19)), inf),
    \dyn, Pseq([0, 0, 0, 1], inf),
    \amp, Pseq([0.2, 0.1, 0.07, 0.07], inf) * 2
).play(t, quant: [4, -0.4]);
)


(
var key = ~toMidi.("E#3");
// var chord0 = [b[0], b[2], b[4], b[6]] + [-12, 0, 0, 0];
var shift = [0, 0, 12, 12];
var chord0 = [b[2], b[4], b[6], b[0] + 12] + shift;
// var chord1 = [b[1], b[3], b[5], b[7]] + [-12, 0, 0, 0];
var chord1 = [b[5], b[7], b[1] + 12, b[3] + 12] + shift;
var chord2 = [b[4], b[6], b[0] + 12, b[2] + 12] + shift;
var nn = chord0.wrapExtend(4)/* ++ (chord1.wrapExtend(8))*/
 ++ (chord2.wrapExtend(4) + 1) ++ (chord1.wrapExtend(8) - 3);
nn = nn + [-1, -1, 0, -1].wrapExtend(nn.size);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq([0.35], inf),
    \num, Pseq(key + nn, inf),
    // + Pseq((-12!1 ++ (0!9)).wrapExtend(20) + (12!1 ++ (0!19)), inf),
    \dyn, Pseq([0, 0, 0, 1], inf),
    \amp, Pseq([0.2, 0.1, 0.07, 0.07], inf)
).play(t, quant: [4, -0.4]);
)