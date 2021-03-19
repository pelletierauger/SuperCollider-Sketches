(
var n = 16;
~knockA.stop;
~knockA = Pbind(
    // \instrument, \sampler,
    \instrument, \samplerKarplusLPF,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \atk, 0.001,
    \susT, 2,
    \rel, 0.001,
    \rate, -2.midiratio,
    \pitch, 60 + Pseq([-2, 0], inf),
    \amp, 0.5
).play(~t, quant: [2, -0.06]);
~knockB.stop;
~knockB = Pbind(
    \instrument, \sampler,
    // \instrument, \samplerKarplusLPF,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \atk, 0.001,
    \susT, 2.5,
    \rel, 0.001,
    \rate, -2.midiratio,
    \amp, 0.5
).play(~t, quant: [2, -0.06]);
)


(
var n = 16;
~knockC.stop;
~knockC = Pbind(
    // \instrument, \sampler,
    \instrument, \samplerKarplusLPF,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \atk, 0.5,
    \susT, 0.1,
    \rel, 0.001,
    \rate, Pseq((22 - [0, 2, 5]).midiratio, inf),
    \pitch, 60 + Pseq([-2, 0] - 24, inf),
    \amp, 0.5
).play(~t, quant: [2, -0.06]);
)