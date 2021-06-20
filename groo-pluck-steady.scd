(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
var sw = 0.01;
~sPA.stop;
~sPA = Pbind(
    \instrument, \samplerLPF,
    \dur, Pseq([4, 3 - sw, 3 + sw, 4 - sw, 4 + sw, 2] / 4, inf),
    \spos, 0,
    \atk, 0.001,
    \susT, 0.6,
    \rel, 0.001,
    \rate, Pseq([-5, -5, -5, -5, -4, -4].midiratio, inf),
    \amp, Pseq([2, 1, 1.5, 1, 1.75, 1.5], inf) * 1.4 * 1,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
    \buf, Pseq([~softPluckA].stutter(4) ++ [~softPluckB].stutter(2), inf)
).play(~nT, quant: [1, 0]);
~sPC.stop;
~sPC = Pbind(
    \instrument, Pseq([\samplerFlip, \sampler], inf),
    \dur, Pseq([4, 3 - sw, 3 + sw, 4 - sw, 4 + sw, 2] / 4, inf),
    \spos, 0.047,
    \atk, 0.001,
    \susT, 1.1,
    \rel, 0.001,
    \rate, -2.midiratio,
    \amp, Pseq([2, 1, 2, 1, 2, 1], inf) * 0.75 * 1,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
).play(~nT, quant: [1, 0]);
)