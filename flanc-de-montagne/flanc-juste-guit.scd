(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 1,
    \spos, Pseq([88.802, 91.203], inf),
    \susT, 1,
    \rate, 0.5,
    \amp, Pseq([2, 2] * 4, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 2 / 3,
    \spos, Pseq([90.894], inf),
    \susT, 0.3,
    \amp, Pseq([2, 2] * 2, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
~guitareDB.stop;
~guitareDB = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 1,
    \spos, Pseq([90.894], inf),
    \susT, 0.3,
    \rate, -5.midiratio,
    \amp, Pseq([2, 2] * 2, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
)

[~guitareC, ~guitareD, ~guitareDB].do({|i| i.stop});