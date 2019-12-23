(
var r = Rest(1);
~pia.stop;
~pia = Pbind(
    \instrument, \pizzicato,
    \atk, 0.001,
    \rel, 1,
    \dur, Pseq([1, 1, 1, r, 1, 1, r, 1, r, 1, 1, r] * 0.25, inf),
    \freq, Pseq([440 * 17.midiratio], inf),
    \amp, 0.5
).play(quant: [4, 0.02]);
)
