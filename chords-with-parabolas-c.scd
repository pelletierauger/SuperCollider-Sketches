(
SynthDef(\parabola, {
    arg out = 0, freq = 220, amp = 1, atk = 1, rel = 6;
    var x, y, e, env;
    e = Env.new([0, 1, 0], [atk, rel]);
    env = EnvGen.kr(e, doneAction: 2);
    x = Phaser.ar(freq * 0.5!2 * [2, 2.01], 0) - 0.5 * 2;
    y = x * x - 0.5 * 2;
    y = y * amp * env;
    Out.ar(out, y);
}).add;
)

(
var r = Rest(1);
~pia.stop;
~pia = Pbind(
    \instrument, \parabola,
    \atk, 0.01,
    \rel, 0.5,
    \dur, Pseq([1, 1, 1, r, 1, 1, r, 1, r, 1, 1, r] * 0.25, inf),
    \freq, Pseq(55 * [-8, -8, -1].midiratio.stutter(4), inf),
    \amp, 2
).play(quant: 1);
/*~pia2.stop;
~pia2 = Pbind(
    \instrument, \parabola,
    \atk, 0.001,
    \rel, 0.1,
    \dur, Pseq([r, r, r, 1] * 0.25, inf),
    \freq, Pseq(880 * 2 * [-11].midiratio.stutter(1), inf),
    \amp, 0.125
).play(quant: 1);*/
)

(
Synth(\parabola, [\freq, 220 * -10.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -22.midiratio, \amp, 4, \atk, 1]);
Synth(\parabola, [\freq, 220 * 4.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -12.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -24.midiratio, \amp, 4, \atk, 1]);
Synth(\parabola, [\freq, 220 * 2.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -19.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * (-19 - 12).midiratio, \amp, 8, \atk, 1]);
Synth(\parabola, [\freq, 220 * 0.midiratio, \amp, 1, \atk, 1]);
)


// bonheur
(
Synth(\parabola, [\freq, 220 * -8.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -20.midiratio, \amp, 4, \atk, 1]);
Synth(\parabola, [\freq, 220 * 1.midiratio, \amp, 1, \atk, 1]);
)

(
Synth(\parabola, [\freq, 220 * -10.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -22.midiratio, \amp, 4, \atk, 1]);
Synth(\parabola, [\freq, 220 * -1.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -11.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -27.midiratio, \amp, 8, \atk, 1]);
Synth(\parabola, [\freq, 220 * -3.midiratio, \amp, 1, \atk, 1]);
)
// autre
(
Synth(\parabola, [\freq, 220 * -11.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -8.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -10.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -8.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -10.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -17.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -6.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -8.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -17.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -5.midiratio, \amp, 1, \atk, 1]);
)
// ailleurs
(
Synth(\parabola, [\freq, 220 * -8.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -13.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -5.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -6.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -13.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -3.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -11.midiratio, \amp, 2, \atk, 1]);
// Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -3.midiratio, \amp, 1, \atk, 1]);
Synth(\parabola, [\freq, 220 * -8.midiratio, \amp, 1, \atk, 1]);
)

(
var r = Rest(1);
var arr = [
    -11, -15, -8,
    -10, -15, -8,
    -10, -17, -6,
    -8, -17, -5,
    // -8, -13, -5,
    // -6, -13, -3,
    -8, -11, -3
].midiratio;
~pia.stop;
~pia = Pbind(
    \instrument, \parabola,
    \atk, 1,
    \rel, 6,
    \dur, Pseq([0, 0, 6], inf),
    \freq, 220 * Pseq(arr, 1),
    \amp, Pseq([2, 2, 1] * 0.5, inf),
).play(quant: 1);
~pia2.stop;
~pia2 = Pbind(
    \instrument, \parabola,
    \atk, 0.01,
    \rel, 0.5,
    \dur, Pseq([1, 1, 1, r, 1, 1, r, 1, r, 1, 1, r] * 0.25, inf),
    \freq, Pseq(55 * [-8, -8, -1].midiratio.stutter(4), inf),
    \amp, 2
).play(quant: 1);
~pia3.stop;
~pia3 = Pbind(
    \instrument, \parabola,
    \atk, 0.001,
    \rel, 0.1,
    \dur, Pseq([1].stutter(12) * 0.125, inf),
    \freq, Pseq(880 * 2 * [-20 - 12, -11 - 12].midiratio.stutter(24), inf) * Pseq([1, 2].stutter(1), inf),
    \amp, Pseq(Pseries(1, -1/6, 6).asStream.nextN(6) * 0.25, inf)
).play(quant: 1);
)

(
~pia2.stop;
~pia3.stop;
)