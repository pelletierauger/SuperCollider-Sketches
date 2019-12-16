t = TempoClock.new(90/60);


(
var key = ~toMidi.("A3");
var dim = key + [0, 3, 6, 9];
var nn = dim;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!3 ++ 3.6, inf),
    \num, Pseq(nn, inf) +
    Pseq(0!4 ++ (1 - 12), inf),
    \dyn, Pseq([1], inf),
    \amp, Pseq([10], inf)
).play(t, quant: [4, -0.4]);
)


(
var nn = ~toMidi.("A4") * 0 + [0, 3, 6, 9];
(Pseq(nn, inf) + Pseq(0!4 ++ 1, inf)).asStream.nextN(30);
)


A°...
0, 3, 6, 9
E = a + 7, a, c, g
Am7/E
7, 0, 3, 9 = e, a, c, f#

(
var key = ~toMidi.("A3");
var dim1 = key + [-12 + 6, 6, 0, 3, 9];
var dim2 = key + [-12 + 0, 0, 3, 6, 9];
var dim3 = key + [-12 + 3, 3, 0, 6, 9];
var dim4 = key + [-12 + 9, 9, 0, 3, 6];
var upper = [1, 1, 0, 0, 1];
var nn = dim1 + upper;
// nn = nn ++ (dim2 + upper);
// nn = nn ++ (dim3 + upper);
nn = nn ++ (dim4 + upper);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.2!3) ++ (4 - 0.3), inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq([1], inf),
    \amp, Pseq([10], inf)
).play(t, quant: [4, -0.4]);
)
