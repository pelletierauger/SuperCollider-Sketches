(
var key = ~toFreq.("F#3");
var freq = key * [-5, 2, 6, 11, 14].midiratio;
var freq2 = key * [0, 2, 3, 10, 14].midiratio * 2.midiratio;
var freq3 = key * [-5, 2, 3 - 12, 10, 14 - 12].midiratio * 4.midiratio;
var freq4 = key * [-5, 0, 2, 4, 10].midiratio * 4.midiratio;
freq = freq ++ freq2 ++ freq3 ++ freq4;
~oceanBlue.stop;
~oceanBlue = Pbind(
    \instrument, \ponddrop,
    \dur, Pseq((0.05!4) ++ 6, inf),
    \freq, Pseq(freq, inf),
    \atk, 0.15,
    \freqOsc, 2 * 0.25,
    \triMod, Pseq([0.5, 0.501] * 2, inf),
    \dec, 0.25,
    \amp, 7.7 * Pseq([1, 1.75], inf) * 0.5,
    \rel, 10  * Pseq((1!5) ++ 1.5, inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t, quant: [1]);
)

(
var key = ~toFreq.("Db3");
var freq = key * [-5, 2, 6, 11, 14].midiratio;
var freq2 = key * [0, 2, 3, 10, 14].midiratio * 2.midiratio;
var freq3 = key * [3 - 12, -5, 0, 2, 10].midiratio * 4.midiratio;
var freq4 = key * [-5, 0, 2, 3, 9].midiratio * 2.midiratio;
freq = [freq, freq2, freq3, freq4].stutter(2).flat;
~oceanBlue.stop;
~oceanBlue = Pbind(
    \instrument, \ponddrop,
    \dur, Pseq((0.125!9) ++ 6, inf),
    \freq, Pseq(freq, inf) * Pseq([1, 2].stutter(5), inf),
    \atk, 0.15,
    \freqOsc, 2 * 0.25,
    \triMod, Pseq([0.5, 0.501] * 4, inf),
    \dec, 0.25,
    \amp, 7.7 * Pseq([1, 1.75], inf) * 0.5,
    \rel, 10  * Pseq((1!5) ++ 1.5, inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~highPassBus
).play(t, quant: [1]);
)

[1, 2, 3, 4].do({|i, item| item * 4});

(
var i = [1, 2, 3];
var j = [4, 5, 6];
var k = [7, 8, 9];
var f = [i, j, k].stutter(2).flat;
f;
)
