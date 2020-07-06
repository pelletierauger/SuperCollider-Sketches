(
SynthDef(\parabola, {
    arg out = 0, freq = 220, amp = 1, atk = 1, rel = 3;
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
// Synth(\parabola, [\freq, 220 * -27.midiratio, \amp, 8, \atk, 1]);
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
Synth(\parabola, [\freq, 220 * -17.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -1.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -8.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * 2.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\parabola, [\freq, 220 * -11.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -15.midiratio, \amp, 2, \atk, 1]);
Synth(\parabola, [\freq, 220 * -3.midiratio, \amp, 1, \atk, 1]);
Synth(\parabola, [\freq, 220 * -8.midiratio, \amp, 1, \atk, 1]);
)