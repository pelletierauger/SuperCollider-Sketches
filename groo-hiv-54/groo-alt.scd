(
~sPA.stop;
~sPA = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 0.4 * 1,
    \rel, 0.001,
    \rate, 1 * Pseq([-5].midiratio.stutter(12) ++ [-4].midiratio.stutter(8), inf),
    \amp, Pseq([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 1,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
    \buf, Pseq([~softPluckA].stutter(12) ++ [~softPluckB].stutter(8), inf)
).play(~nT, quant: [5, 0]);
// [1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0];
~sPC.stop;
~sPC = Pbind(
    // \instrument, \samplerBee,
    \instrument, Pseq([\samplerBeeFlip, \samplerBee], inf),
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0.05,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 1,
    \rel, 0.001,
    \rate, 1 * -2.midiratio,
    \amp, Pseq([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
    // \buf, Pseq([~softPluckA, ~softPluckA, ~softPluckB, ~softPluckB], inf)
).play(~nT, quant: [5, 0]);
)


(
~sPA.stop;
~sPA = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 0.4 * 1,
    \rel, 0.001,
    \rate, 1 * Pseq([-5].midiratio.stutter(20), inf),
    \amp, Pseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 1,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
    \buf, Pseq([~softPluckA], inf)
).play(~nT, quant: [5, 0]);
~sPC.stop;
~sPC = Pbind(
    // \instrument, \samplerBee,
    \instrument, Pseq([\samplerBeeFlip, \samplerBee], inf),
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0.05,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 1,
    \rel, 0.001,
    \rate, 1 * -2.midiratio,
    \amp, Pseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
    // \buf, Pseq([~softPluckA, ~softPluckA, ~softPluckB, ~softPluckB], inf)
).play(~nT, quant: [5, 0]);
)
