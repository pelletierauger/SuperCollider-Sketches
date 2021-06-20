(
/*~guitareC.stop;
~guitareC = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 1,
    \spos, Pseq([88.802, 91.203], inf),
    \susT, 1,
    \rate, 0.5,
    \amp, Pseq([2, 2] * 4, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);*/
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 2 / 3,
    \spos, Pseq([90.894], inf),
    \susT, 0.25,
    \amp, Pseq([2, 1, 1] * 4, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
~guitareDB.stop;
~guitareDB = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 1,
    \spos, Pseq([90.894, 91.205], inf),
    \susT, Pseq([0.4, 0.9], inf),
    \rate, Pseq(([-5, -9].wrapExtend(4) ++ [-5, -11].wrapExtend(4)).midiratio, inf),
    \lpf, 1000,
    \amp, Pseq([1.5, 1.5] * 4, inf),
    \out, 0
).play(~nT, quant: [2, -0.21]);
)

(
~guitareE.stop;
~guitareE = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 2 / 3 * 0.5,
    \spos, Pseq([93.3], inf),
    \susT, 0.4,
    \amp, Pseq([2, 1] * 2, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
)

[~guitareC, ~guitareD, ~guitareDB].do({|i| i.stop});