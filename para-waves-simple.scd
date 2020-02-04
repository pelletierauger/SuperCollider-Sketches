(
SynthDef(\parabass, {
    arg freq = 55, amp = 1, m = 0.5, rel = 4, atk = 0.1;
    var env, f, r, x, x2, x3, l, l2, sig;
    f = freq;
    x = Phaser.ar(f * [1, 1], 0) - 0.5 * 2;
    x = x * x - 0.5 * 2;
//     x2 = Phaser.ar(f * 0.5 * [0.5, 0.5001], 1) - 0.5 * 2;
//     x2 = x2 * x2 - 0.5 * -2;
//     x3 = x + (0.5 * (x2 - x));
//     l = Line.ar(0, 1, 1);
//     sig = x2 + (l * (x3 - x2)) * 0.1 * 0.5 * 2;
//     sig = x2 * 0.1 * 0.5 * 2;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    // sig = x2 + ((1 - env) * (x3 - x2)) * 0.1 * 0.5 * 2;
    Out.ar(0, x * 0.1 * env * amp);
}).add;
)
Synth(\parabass, [\freq, 220 * -12.midiratio, \amp, 1, \atk, 1]);

t = TempoClock(90/60);
t.tempo = 115/60;
t.permanent = true;


(
Synth(\parabass, [\freq, 220 * -10.midiratio, \amp, 1, \atk, 1]);
Synth(\parabass, [\freq, 220 * -15.midiratio, \amp, 1, \atk, 1]);
Synth(\parabass, [\freq, 220 * -22.midiratio, \amp, 2, \atk, 1]);
Synth(\parabass, [\freq, 220 * 4.midiratio, \amp, 0.5, \atk, 1]);
)
(
Synth(\parabass, [\freq, 220 * -12.midiratio, \amp, 1, \atk, 1]);
Synth(\parabass, [\freq, 220 * -15.midiratio, \amp, 1, \atk, 1]);
Synth(\parabass, [\freq, 220 * -24.midiratio, \amp, 2, \atk, 1]);
Synth(\parabass, [\freq, 220 * 2.midiratio, \amp, 0.5, \atk, 1]);
)
(
Synth(\parabass, [\freq, 220 * -19.midiratio, \amp, 1, \atk, 1]);
Synth(\parabass, [\freq, 220 * -15.midiratio, \amp, 1, \atk, 1]);
Synth(\parabass, [\freq, 220 * (-19 - 12).midiratio, \amp, 4, \atk, 1]);
Synth(\parabass, [\freq, 220 * 0.midiratio, \amp, 0.5, \atk, 1]);
)


(
~ba.stop;
~ba = Pbind(
    \instrument, \parabass,
    \dur, Pseq([0.5], inf),
    \freq, 55 * Pseq([0, 0, -5, -2].stutter(4).midiratio, inf) * Pseq([0, 12].midiratio, inf),
    \amp, Pseq([1, 0.5, 0.75, 0.5] * 1, inf),
    \decLev, Pseq([0.4, 0.9].stutter(8), inf),
    \relTime, Pseq([0.25, 0.1].stutter(8), inf)
).play(t, quant: [4]);
)