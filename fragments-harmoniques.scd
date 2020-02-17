(
var key = ~toMidi.("A4");
// Aadd2, A6add2
var notes = key + [0, 2, 4, 7, 2, 4, 7, 9];
var nn = notes;
~pia.stop;
~pia = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.05!3 ++ (4 - 0.3), inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(0!3 ++ 1, inf),
    \amp, Pseq(1!3 ++ 0.5, inf) * 2
).play(quant: [2]);
)
(
var key = ~toMidi.("A4");
// Am7, Am6add2
var notes = key + [0, 3, 7, 10, 0, 3, 7, 10, -3, 2, 3, 7, -3, 2, 3, 7];
var nn = notes + ((0!4) ++ (12!4));
~pia.stop;
~pia = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.05!3 ++ (0.75 - 0.3) ++ (0.5!3) ++ (4 - 1.5), inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(0!3 ++ 1, inf),
    \amp, Pseq(1!3 ++ 0.5, inf) * 2
).play(quant: [2]);
)

(
var key = ~toMidi.("A4");
// Aadd2, A6add2
var notes = key + [0, 2, 4, 7, -1, 2, 4, 7, -2, 2, 4, 7,  -3, 2, 4, 7];
var nn = notes;
~pia.stop;
~pia = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.05!3 ++ (2 - 0.3), inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(0!3 ++ 1, inf),
    \amp, Pseq(1!3 ++ 0.5, inf) * 2
).play(quant: [2]);
)

(
var key = ~toMidi.("A4");
// Am(M7), Cm(M7/9)
var notes = key + [0, 3, 7, 11, 3, 7, 11, 14];
var nn = notes;
~pia.stop;
~pia = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.05!3 ++ (4 - 0.3), inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(0!3 ++ 1, inf),
    \amp, Pseq(1!3 ++ 0.5, inf) * 2
).play(quant: [2]);
)

(
var key = ~toMidi.("A4");
// Gbm7, Am6add2
var notes = key + [0, 3, 7, 10, 0, 3, 7, 10, -3, 2, 3, 7, -3, 2, 3, 7] + 12;
// var notes = key + [0, 3, 7, 10, 0, 3, 7, 10, -1, 2, 4, 7, -1, 2, 4, 7];
var nn = notes + ((0!4) ++ (12!4)) + (-3!8 ++ (0!8)) + [0].wrapExtend(16);
~pia.stop;
~pia = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.05!3 ++ (0.75 - 0.3) ++ (0.5!3) ++ (4 - 1.5), inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(0!3 ++ 1, inf),
    \amp, Pseq(1!3 ++ 0.5, inf) * 1.5
).play(quant: [2, -0.15]);
~pia2.stop;
~pia2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.05, 4.6 / 4 - 0.05], inf),
    \num, Pseq(key + ([0, 7 - 3].wrapExtend(8) ++ [0, 3].wrapExtend(8)) - 12, inf),
    \dyn, Pseq(0!3 ++ 1, inf),
    \amp, Pseq(1!3 ++ 0.5, inf) * 1
).play(quant: [2]);
)

(0.05!3 ++ (0.75 - 0.3) ++ (0.5!3) ++ (4 - 1.5)).sum

(
var key = ~toMidi.("A4");
// Gbm7, Am6add2
var notes = key + [0, 3, 7, 10, 0, 3, 7, 10, -3, 2, 3, 7, -3, 2, 3, 7] + 12;
// var notes = key + [0, 3, 7, 10, 0, 3, 7, 10, -1, 2, 4, 7, -1, 2, 4, 7];
var nn = notes + ((0!4) ++ (12!4)) + (-3!8 ++ (0!8)) + [0].wrapExtend(16);
~pia.stop;
~pia = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.05!3 ++ (0.75 - 0.3) ++ (0.5!3) ++ (4 - 1.5), inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(0!3 ++ 1, inf),
    \amp, Pseq(1!3 ++ 0.5, inf) * 1.5
).play(quant: [2, -0.15]);
~pia2.stop;
~pia2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.05, 4.6 / 8 - 0.05, 0.05, 4.6 / 8 - 0.05], inf),
    \num, Pseq(key + ([0, 7 - 3].wrapExtend(16) ++ [0, 3].wrapExtend(16)) - 12, inf) +
    Pseq([0, 0].stutter(2), inf),
    \dyn, Pseq(0!3 ++ 1, inf),
    \amp, Pseq(1!3 ++ 0.5, inf) * 1
).play(quant: [2]);
)
