(
~knockBKar.stop;
~knockBKar = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, Pseq([2, 1, 1], inf),
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(60 + [-5, 4, 2, 5, -3, 4, 2, 5].reverse + 0, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.06]);
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.399], inf),
    \atk, 0.001,
    \susT, 1.3,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.29 + 1]);
)

~guitareD.stop;


~guitareD = nil;


~guitareD.play(~t, quant: [2, -0.29 + 1]);
~d = ~guitareD.play(~t, quant: [2, -0.29 + 1]);
~d.stop;

(
~guitareD = Pbind.new(
    \instrument, \sampler,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.399], inf),
    \atk, 0.001,
    \susT, 1.3,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 1
);
)
Pbindef
~knockPlay = ~knockBKar.play(~t, quant: [2, -0.06]);
~knockPlay.stop;


(
~knockPlay.reset.play;
~d.reset.play;
)

(
~knockBKar = Pbind.new(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, Pseq([2, 1, 1], inf),
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(60 + [-5, 4, 2, 5, -3, 4, 2, 5].reverse + 0, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \amp, 1
);
)