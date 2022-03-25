(
var key = ~toMidi.("E#4");
var dim1 = key + [-36 + 6, 6, 0, 3, 9];
var dim2 = key + [-24 + 0, 0, 3, 6, 9];
var dim3 = key + [-36 + 3, 3, 0, 6, 9];
var dim4 = key + [-36 + 9, 9, 0, 3, 6];
var upper = [1, 1, 0, 1, 2] * 3;
var nn = dim1 + upper;
nn = nn.wrapExtend(10);
// nn = nn ++ (dim2 + upper);
// nn = nn ++ (dim3 + upper);
nn = nn ++ ((dim4 + upper).wrapExtend(10)) + 12;
// nn = nn.rotate(7).reverse + 7;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.5!1 ++ (0.2!3) ++ (4 - 0.3)).wrapExtend(10) * (1!4 ++ 0 ++ (1!5)), inf),
    \num, Pseq(nn, inf) + Pseq([0, -7].stutter(5), inf) + Pseq(0!5 ++ (0!3) ++ (8) ++ 7, inf),
    // + Pseq((-12!1 ++ (0!9)).wrapExtend(20) + (12!1 ++ (0!19)), inf),
    \dyn, Pseq([0], inf),
    \amp, Pseq([10, 5].stutter(5) + (0!9 ++ 10) * 0.1 * 0.5, inf)
).play(t, quant: [4, -0.4]);
)


(
var key = ~toMidi.("E#4");
var dim1 = key + [-36 + 6, 6, 0, 3, 9];
var dim2 = key + [-24 + 0, 0, 3, 6, 9];
var dim3 = key + [-36 + 3, 3, 0, 6, 9];
var dim4 = key + [-36 + 9, 9, 0, 3, 6];
var upper = [1, 1, 0, 1, 2] * 3;
var nn = dim1 + upper;
nn = nn.wrapExtend(10);
// nn = nn ++ (dim2 + upper);
// nn = nn ++ (dim3 + upper);
nn = nn ++ ((dim4 + upper).wrapExtend(10)) + 12;
// nn = nn.rotate(7).reverse + 7;
nn = nn.reverse.rotate(1);
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.5!1 ++ (0.2!3) ++ (4 - 0.3)).wrapExtend(10) * (1!4 ++ 0 ++ (1!5)), inf),
    \num, Pseq(nn, inf) + Pseq([0, -7].stutter(5), inf) + Pseq(0!5 ++ (0!3) ++ (8) ++ 7, inf),
    // + Pseq((-12!1 ++ (0!9)).wrapExtend(20) + (12!1 ++ (0!19)), inf),
    \dyn, Pseq([1], inf),
    \amp, Pseq([10, 5].stutter(5) + (0!9 ++ 10) * 0.1 * 0.5, inf)
).play(t, quant: [4, -0.4]);
)