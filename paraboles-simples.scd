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

(
{
    var x, f = 220;
    x = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    x = x * x - 0.5 * 2;
    x * 0.1;
}.play;
)
(
{
    var x, y, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    y = x * x - 0.5 * 2;
}.plot(2);
)
(
{
    var x, y, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    y = pow(x, 2) - 0.5 * 2;
}.plot(2);
)
-0.5 * -0.5
pow(-1.4, 2)



(
{
    var x, y, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    y = x * x * x;
}.plot(2);
)
(
{
    var x, y, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    y = pow(x, 3);
}.plot(2);
)

(
{
    var x, f = 220;
    x = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    x = x * x * x;
    x * 0.1;
}.play;
)