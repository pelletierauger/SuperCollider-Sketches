(
~muds2.stop;
~muds2 = Pbind(
    \instrument, \scotch,
    \dur, Pseq([2] * 1, inf),
    \freq, 220 * -14.midiratio * Pseq([0, 7].midiratio, inf)
).play(t, quant: 1);
)