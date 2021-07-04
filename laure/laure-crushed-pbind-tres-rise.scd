(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, Pseq([\crushedNoHPF, \crushedNoHPF], inf),
    \dur, Pseq([3, 3, 2] * 0.5, inf),
    \pitch, 12,
    \color, Pseq([0.8, 0.95, 0.95] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq([1.25, 0.25, 0.25] / 1, inf),
    \rel, 0.001,
    \amp, Pseq([1, 3, 3] * 4, inf) *
    min(Pseries(0.1, 0.1, inf), 1.0),
    \out, 0
).play(~nT, quant: [4, -0.2]);
)