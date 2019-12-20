(
~bard2.stop;
~bard2 = Pbind(
    \instrument, \bardane,
    \dur, Pseq([2] * 1, inf),
    \freq, 880 * -14.midiratio * Pseq([0, -2, 3, -4], inf).midiratio * [0.5]
).play();
)