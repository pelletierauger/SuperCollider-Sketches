(
var n = 16;
~knockA.stop;
~knockA = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \atk, 0.001,
    \susT, 2,
    \rel, 0.001,
    \rate, -0.midiratio,
    \amp, 0.5
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
~hats.stop;
~hats = Pbind(
    \instrument, \samplerKarplusLPF,
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
/*~squeak.stop;
~squeak = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, Pseq([Rest(2.5), 1.5], inf),
    \spos, Pseq([0.852], inf),
    \atk, 0.001,
    \susT, 0.55,
    \pitch, Pseq([60, 53].stutter(4), inf),
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 2 * 0.75
).play(~t, quant: [2, -0.3 + 1]);
~squeak2.stop;
~squeak2 = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, Pseq([Rest(2.5), 1.5], inf),
    \spos, Pseq([0.852], inf),
    \atk, 0.001,
    \susT, 0.55,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 0.65 * 0.75
).play(~t, quant: [2, -0.3 + 1]);*/
~knockAKar.stop;
~knockAKar = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(48 + [0, 5].stutter(2) - 12 - 12, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \rate, Pseq(([-3, -3].stutter(2)).midiratio, inf),
    \amp, Pseq([2], inf),
    \filt, 20000
).play(~t, quant: [2, -0.06]);
)