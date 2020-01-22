(
~lerp = {
    |a, b, f|
    a + (f * (b - a));
}
)


(
var f = 440;
{
  var a = SinOsc.ar(f);
  var b = LFTri.ar(f);
  var l = Line.ar(0, 1, 2);
  l = SinOsc.ar(1).range(0, 1);
  a + (l * (b - a));
}.play;

)

(
Phasor.ar(Impulse.ar(440/60), )

)

(
var f = 55 * 0.midiratio;
{
    var r, x, x2, x3, l, l2, sig;
    // r = Phaser.ar(f * 0.5).round * 2 - 1 * 1;
    x = Phaser.ar(f * [1.01, 1], 0) - 0.5 * 2;
    // x = x.pow(2) - 0.5 * 2;
    x = x * x - 0.5 * 2;
    // x = pow(x, 2);
    // x = x.pow(10).abs - 0.5 * 2;
    x2 = Phaser.ar(f * 0.5 * [0.5, 0.502], 1) - 0.5 * 2;
    // x2 = x2.pow(2).abs - 0.5 * 2 * -1;
    x2 = x2 * x2 - 0.5 * -2;
    x3 = x + (0.5 * (x2 - x));
    // l = SinOsc.ar(10).range(0, 1);
    // l2 = SinOsc.ar(2).range(0, 1);
    // sig = x + (l * (x3 - x));
    // sig = sig + (l2 * (x2 - sig));
    // sig;
    // x2 * x3 - 0.015 * r * 10;
    // x * 0.1;
    // x3 * r;
    // x3 + (l * ((x3 * r) - x3));
    // (x3) * 0.1 * 0.5;
    l = Line.ar(0, 1, 1);
    sig = x2 + (l * (x3 - x2)) * 0.1 * 0.5 * 2;
    // -11.pow(2);
    sig * Env.new([0, 1, 0.4, 0], [0.01, 0.25, 0.25]).kr;
}.play;
)


(
SynthDef(\parabass, {
    arg freq = 55, amp = 1, m = 0.5, decLev = 0.4, relTime = 0.25;
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
    env = EnvGen.kr(Env.new([0, 1, decLev, 0], [0.01, 0.25, relTime]), doneAction: 2);
    // sig = x2 + ((1 - env) * (x3 - x2)) * 0.1 * 0.5 * 2;
    Out.ar(0, sig * env * amp);
}).add;
)

t = TempoClock(90/60);
t.tempo = 115/60;
t.permanent = true;
(
~ba.stop;
~ba = Pbind(
    \instrument, \parabass,
    \dur, Pseq([0.5], inf),
    \freq, 55 * Pseq([0, 0, -5, -2].stutter(4).midiratio, inf) * Pseq([0, 12].midiratio, inf),
    \amp, Pseq([1, 0.5, 0.75, 0.5] * 2, inf),
    \decLev, Pseq([0.4, 0.9].stutter(8), inf),
    \relTime, Pseq([0.25, 0.1].stutter(8), inf)
).play(t, quant: [4]);
)
(
~ba2.stop;
~ba2 = Pbind(
    \instrument, \parabass,
    \dur, Pseq([0.25], inf),
    \freq, 220 * Pseq([0, 3, -2, -5].stutter(1).mirror2.midiratio, inf) * Pseq([0, 12].midiratio, inf) * Pseq([0, -5].midiratio.stutter(16), inf),
    \amp, Pseq([1, 0.5, 0.75, 0.5] * 0.3, inf),
    \decLev, Pseq([0.4, 0.1].stutter(1) * 0.01, inf),
    \relTime, Pseq([0.1, 0.01].stutter(8) * 0.01, inf)
).play(t, quant: [4, 0.25]);
)
(
~ba3.stop;
~ba3 = Pbind(
    \instrument, \parabass,
    \dur, Pseq([0.25], inf),
    \freq, 440 * Pseq([0, -9, -5, -2].stutter(8).midiratio, inf) * Pseq([0, 12].midiratio, inf),
    \amp, Pseq([1, 0.5, 0.75, 0.5] * 0.2, inf),
    \decLev, Pseq([0.4, 0.1].stutter(1), inf),
    \relTime, Pseq([0.1, 0.01].stutter(8) * 1, inf)
).play(t, quant: [4]);
)