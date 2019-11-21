




(
{
    var s = -12.midiratio;
    var lfo = SinOsc.kr(0.1).range(1, 10);
    SinOsc.ar((440!2) * s) * 0.1 * SinOsc.ar([110, 111] * s).range(lfo, 1);
}.play;
)


(
{
    var s = -5.midiratio;
    var lfo = SinOsc.kr(0.2).range(0.001, 10);
    SinOsc.ar((440!2) * s) * 0.1 * SinOsc.ar([110, 111] * 0.25 * s).range(lfo, 1);
}.play;
)

(
{
    var s = 4.midiratio;
    var lfo0 = SinOsc.kr([0.1, 0.2]).range(1, 10);
    var lfo = SinOsc.kr(lfo0).range(0.1, 10);
    SinOsc.ar((440!2) * s) * 0.05 * SinOsc.ar([110, 111] * 1 * s).range(lfo, 1);
}.play;
)



(
{
    var s = 12.midiratio;
    var lfo0 = SinOsc.kr([0.1, 0.2] * 1).range(0.01, 100);
    var lfo = SinOsc.kr(lfo0).range(0.1, 2000);
    SinOsc.ar((440!2) * s) * 0.0005 * SinOsc.ar([110, 111] * 0.25 * s).range(lfo, 1);
}.play;
)


(
{
    var s = 0.midiratio;
    var lfo = SinOsc.kr(0.1).range(0.001, 1);
    SinOsc.ar((440!2) * s) * 0.1 * SinOsc.ar([110, 111] * 0.5 * s).range(lfo, 1);
}.play;
)

s.freqscope;


(
{
    var s = -5.midiratio;
    var env = EnvGen.ar(Env.new(
        ([-3, -3, -5, -5, -3, -3] + 12).midiratio,
        [4, 0.01, 4, 0.01, 2, 2],
        \exponential!4,
        releaseNode: 4, loopNode: 0), doneAction: 2
    );
    var lfo = SinOsc.kr(0.2).range(0.001, 10);
    SinOsc.ar((440!2) * env) * 0.1 * SinOsc.ar([110, 111] * 0.25 * env).range(lfo, 1);
}.play;
)


(
{
    var s = -5.midiratio;
    var env = EnvGen.ar(Env.new(
        [0, 0, 2, 2, 4].midiratio,
        [2, 0.1, 2, 0.1],
        \exponential!4,
        releaseNode: 3, loopNode: 0), doneAction: 2
    );
    var lfo = SinOsc.kr(0.2).range(0.001, 10);
    SinOsc.ar((440!2) * env) * 0.1 * SinOsc.ar([110, 111] * 0.25 * env).range(lfo, 1);
}.play;
)


1e-4
10.pow(-4
    1e-1
)


c_{n+1}0.00005 * 1.5
0.00005 * 1.5

(
{
    var env = EnvGen.ar(Env.new(
        ([200, 8000, 200, 200]),
        [4, 4, 2, 2],
        \exponential!4,
        releaseNode: 2, loopNode: 0), doneAction: 2
    );
    var mod = SinOsc.ar(20).range(10, 1000);
    LPF.ar(WhiteNoise.ar(1!2) * 0.1, env + mod);
}.play;
)