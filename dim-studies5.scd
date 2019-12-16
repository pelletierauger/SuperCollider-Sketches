(
var key = ~toMidi.("C#4");
var dim1 = key + [-12 + 6, 6, 0, 3, 9];
var dim2 = key + [-12 + 0, 0, 3, 6, 9];
var dim3 = key + [-12 + 3, 3, 0, 6, 9];
var dim4 = key + [-12 + 9, 9, 0, 3, 6];
var upper = [1, 1, 0, 1, 1];
var nn = dim1 + upper;
nn = nn.wrapExtend(10);
nn = nn ++ ((dim2 + upper).wrapExtend(10));
nn = nn ++ ((dim3 + upper).wrapExtend(10));
nn = nn ++ ((dim4 + upper).wrapExtend(10));
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.5!1 ++ (0.15!3) ++ (4 - 0.3)).wrapExtend(10) * (1!4 ++ 0 ++ (1!5)), inf),
    \num, Pseq(nn, inf) + Pseq([0, -7].stutter(5), inf) + Pseq(0!5 ++ (0!3) ++ (13) ++ 14, inf),
    // + Pseq((-12!1 ++ (0!9)).wrapExtend(20) + (12!1 ++ (0!19)), inf),
    \dyn, Pseq([1], inf),
    \amp, Pseq([10, 5].stutter(5) + (0!9 ++ 10), inf)
).play(t, quant: [4, -0.4]);
)