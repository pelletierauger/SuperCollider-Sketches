(
var key = ~toMidi.("A3");
var dim = key + [-12 + 6, 6, 0, 3, 10];
var dim2 = ~toMidi.("C3") + [-12 + 0, 0, 4, 7, 9];
var nn = dim + [1, 1, 0, 0, 0];
var sp;
nn = nn.wrapExtend(10) ++ (dim2.wrapExtend(10) + [0, 0, 0, 0, 0]);
sp = Pseries(0.25, -0.02, 8).asStream.nextN(8);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    // \dur, Pseq(0.5!1 ++ (sp) ++ (4 - 0.8), inf),
    \dur, Pseq(0.5!1 ++ (sp) ++ (4 - 0.8), inf),
    \num, Pseq(nn, inf) + Pseq([0, 12, 0, 24].stutter(5), inf),
    \dyn, Pseq([1], inf),
    \amp, Pseq([10], inf)
).play(t, quant: [4, -0.4]);
)


(
var key = ~toMidi.("A3");
var dim = key + [-12 + 6, 6, 0, 3, 10];
var dim2 = ~toMidi.("C3") + [-12 + 0, 0, 4, 7, 9];
var nn = dim + [1, 1, 0, 0, 0];
var sp;
nn = nn.wrapExtend(10) ++ (dim2.wrapExtend(10) + [0, 0, 0, 0, 0]);
sp = Pseries(0.25, -0.02, 8).asStream.nextN(8);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    // \dur, Pseq(0.5!1 ++ (sp) ++ (4 - 0.8), inf),
    \dur, Pseq(0.5!1 ++ (sp), inf) ++ Pseq([0, (4 - 0.8)], inf),
    \num, Pseq(nn, inf) + Pseq([0, 12, 0, 24].stutter(5), inf),
    \dyn, Pseq([1], inf),
    \amp, Pseq([10], inf)
).play(t, quant: [4, -0.4]);
)