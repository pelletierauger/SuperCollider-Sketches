(
~knockA.stop;
~knockA = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
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
    \dur, Pseq([Rest(2), 2], inf),
    \spos, Pseq([0.399], inf),
    \atk, 0.001,
    \susT, 1.3,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.29]);
)


(
~knockB.stop;
~knockB = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3543], inf),
    \pitch, Pseq(48 + [0, 5], inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \amp, 2
).play(~t, quant: [2, -0.3 + 0.5]);
)


(
var n = 16;
~hats.stop;
~hats = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, 0.5,
    \spos, Pseq([0.334], inf),
    \rel, 0.001,
    \susT, 0.8,
    \atk, 0.001,
    \rate, 1,
    \amp, Pseq([1], inf) * Pseq(Pseries(0.5, 1/n, n).asStream.nextN(n).reverse, inf)
    * Pseq([1, 0.5, 0.75, 0.5], inf) * 0.4 * 2,
    \filt, Pseq(Pseries(500, 100, n).asStream.nextN(n), inf)
).play(~t, quant: [2, -0.1]);
~hats2.stop;
~hats2 = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 0.5,
    \spos, Pseq([0.334], inf),
    \rel, 0.001,
    \susT, 0.8,
    \atk, 0.001,
    \rate, 1,
    \amp, Pseq([1], inf) * Pseq([1.4375] ++ Pseries(0.5, 1/n, n).asStream.nextN(n - 1), inf)
    * Pseq([1, 0.5, 0.75, 0.5], inf) * 0.15 * 4,
    \filt, Pseq([2000] ++ Pseries(500, 100, n).asStream.nextN(n - 1), inf)
).play(~t, quant: [2, -0.1]);
)

Pseries(500, 100, 16).asStream.nextN(16)

(
~hats.stop;
~hats2.stop;
)


(
var n = 16;
Pseries(0.5, 1/n, n).asStream.nextN(n);
)