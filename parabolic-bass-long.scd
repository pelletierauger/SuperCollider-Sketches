(
~ba.stop;
~ba = Pbind(
    \instrument, \parabass,
    \dur, Pseq([4], inf),
    \freq, 55 * Pseq([3, 0].stutter(2).midiratio, inf),
    \freq, 55 * Pseq([0, -5].stutter(2).midiratio, inf),
    \amp, 1.5,
    \decLev, Pseq([0.4, 0.4].stutter(8), inf)
).play(t, quant: [1]);
)

(
SynthDef(\parabass, {
    arg freq = 55, amp = 1, m = 0.5, decLev = 0.4, relTime = 7;
    var env, f, r, x, x2, x3, l, l2, sig;
    f = freq;
    x = Phaser.ar(f * [1.001, 1], 0) - 0.5 * 2;
    x = x * x - 0.5 * 2;
    x2 = Phaser.ar(f * 0.5 * [0.5, 0.5001], 1) - 0.5 * 2;
    x2 = x2 * x2 - 0.5 * -2;
    x3 = x + (0.5 * (x2 - x));
    l = Line.ar(0, 1, 1);
    sig = x2 + (l * (x3 - x2)) * 0.1 * 0.5 * 2;
    sig = x2 * 0.1 * 0.5 * 2;
    env = EnvGen.kr(Env.new([0, 1, decLev, 0], [0.5, 0.25, relTime]), doneAction: 2);
    // sig = x2 + ((1 - env) * (x3 - x2)) * 0.1 * 0.5 * 2;
    Out.ar(0, sig * env * amp);
}).add;
)
