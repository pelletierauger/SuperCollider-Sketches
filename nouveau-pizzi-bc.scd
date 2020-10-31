

// Profond et angélique

(
~knockAKar.stop;
~knockAKar = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(48 + [0, -2].stutter(2) - 12 - 12, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \rate, Pseq(([-3, -5].stutter(2)).midiratio, inf),
    \amp, Pseq([4], inf)
).play(~t, quant: [2, -0.06]);
)


// Lunaire, nuageux, angélique
(
~knockAKar.stop;
~knockAKar = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(48 + [0, -2].stutter(2) - 12 - 12, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \rate, Pseq(([-3, -5].stutter(2) + 12).midiratio, inf),
    \amp, Pseq([4], inf)
).play(~t, quant: [2, -0.06]);
)


// Bas et posé

(
~knockAKar.stop;
~knockAKar = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(48 + [0, 5].stutter(2) - 12, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \rate, Pseq(([-3, -3].stutter(2)).midiratio * 0.5, inf),
    \amp, Pseq([1.5], inf),
    \filt, 8000
).play(~t, quant: [2, -0.06]);
)


// Lumineux

(
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
    \filt, 8000
).play(~t, quant: [2, -0.06]);
)
