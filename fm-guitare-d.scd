// Tentative de guitare, notre aigüe et soutenue
(
var f = 880 * 12.midiratio;
{
    var env = EnvGen.kr(Env.new([0, 1, 0.1, 0], [0.01, 0.2, 4], [3, -3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    var env3 = Env.new([0, 1, 0], [0.001, 0.05], [3, -7]).kr;
    var pEnv = Env.new([0.9, 1], [0.15], [3]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op4 = SinOsc.ar(f * 0.5) * env3 * 5;
    var op3 = SinOsc.ar(f * 1, lfo * 12);
    var op2 = SinOsc.ar(f * 1, op4 * 12 + (op3 * 4) * (1 - env2)) * env2;
    var op5 = SinOsc.ar(f * 1) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001], op2 * 1 + op4 + op5) * lfo * 0.1;
    op1 * env;
}.play;
)
SinOscFB
Env.new([0, 1, 0], [0.05, 4], [3, -3]).plot

Env.new([0, 1, 0], [0.01, 2], [3, -7]).plot;
Env.new([0, 1, 0], [0.01, 0.05], [3, -7]).plot;
Env.new([0.99, 1], [0.01], [3]).plot
Env.new([0, 1, 0.25, 0], [0.01, 0.2, 4], [3, -3, -3]).plot
(
var f = 880 * -14.midiratio;
{
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 4], [3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op3 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 1.999, op3 * 2 * (1 - env2)) * env2;
    var op1 = SinOsc.ar(f * [1, 1.001], op2 * 1) * lfo * 0.2;
    op1 * env;
}.play;
)


(
var f = 880 * 5.midiratio;
{
    var env = EnvGen.kr(Env.new([0, 1, 0.025, 0], [0.01, 0.2, 2], [3, -3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    var env3 = Env.new([0, 1, 0], [0.001, 0.05], [3, -7]).kr;
    var pEnv = Env.new([0.9, 1], [0.15], [3]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op4 = SinOsc.ar(f * 0.5) * env3 * 5;
    var op3 = SinOsc.ar(f * 1, lfo * 12);
    var op2 = SinOsc.ar(f * 1, op4 * 12 + (op3 * 4) * (1 - env2)) * env2;
    var op5 = SinOsc.ar(f * 1) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001], op2 * 1 + op4 + op5) * lfo * 0.1;
    op1 * env;
}.play;
)


(
// var f = 880 * 5.midiratio;
SynthDef.new(\pizzicato, {
    arg freq = 880, amp = 1;
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0.0125, 0], [0.01, 0.1, 4], [3, -3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    var env3 = Env.new([0, 1, 0], [0.0001, 0.025], [3, -7]).kr;
    var pEnv = Env.new([0.9, 1], [0.15], [3]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op4 = SinOsc.ar(f * 0.0625) * env3 * 10;
    var op3 = SinOsc.ar(f * 1, lfo * 12);
    var op2 = SinOsc.ar(f * 1, op4 * 12 + (op3 * 4) * (1 - env2)) * env2;
    var op5 = SinOsc.ar(f * 0.5) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001] * 0.25, op2 * 1 + op4 + op5) * lfo * 0.1;
    var op6 = SinOsc.ar(f * 0.125) * 0.1;
    Out.ar(0, op1 + op6 * env * amp);
}).add;
)

(
~piz0.stop;
~piz0 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.5, 0.5, 0.25, 0.25] * 1, inf),
    \freq, 880 * -2.midiratio *
    Pseq([-12, -5, 3, 7, 9, 2].stutter(1), inf).midiratio *
    Pseq([2], inf),
    \amp, Pseq([1, 0.5] * 0.75, inf)
).play();
)

(
~piz.stop;
~piz = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.2], inf),
    \freq, 880 * -2.midiratio *
    Pseq([21, 19].stutter(30), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 0.35
).play();
)

(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.2], inf),
    \freq, 880 * -2.midiratio *
    Pseq([19, 12, 14].stutter(30), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 0.5
).play();
)

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.8], inf),
    \freq, 880 * -2.midiratio *
    Pseq([7].stutter(30), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(8) * 0.75, inf) * 0.5
).play();
)



(
SynthDef.new(\bardane, {
    arg freq = 440;
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 8], [3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op3 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 1.999, op3 * 2 * (1 - env2)) * env2;
    var op1 = SinOsc.ar(f * [1, 1.001], op2 * 1) * lfo * 0.2;
    Out.ar(0, op1 * env);
}).add;
)

(
~bard.stop;
~bard = Pbind(
    \instrument, \bardane,
    \dur, Pseq([4], inf),
    \freq, 880 * -14.midiratio * Pseq([0, -8, -5], inf).midiratio * [1]
).play(t, quant: [2]);
)


(
~muds2.stop;
~muds2 = Pbind(
    \instrument, \scotch,
    \dur, Pseq([3] * 1, inf),
    \freq, 220 * -14.midiratio * Pseq([-5, 0].stutter(2).midiratio, inf)
).play(quant: [1, 0.5]);
)