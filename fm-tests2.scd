(
var f = 220 * 0.midiratio;
{
    var env = Env.circle([0, 1, 0], [0.01, 0.85, 1]).kr;
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 2, op1 * 6 * (env));
    var op3 = SinOsc.kr(0.1, op1).range(0.25, 1);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);

    sig * env;
}.play;
)
(
var f = 220 * 0.midiratio;
{
    var env = Env.circle([0, 1, 0], [0.01, 0.05, 0.01]).kr;
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 2, op1 * 1 * (1 - env));
    var op3 = SinOsc.kr(0.1, op1).range(0.25, 1);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);

    sig * env;
}.play;
)

(
var f = 440 * (-24 + 7).midiratio;
{
    var env = Env.circle([0, 1, 0.5, 0], [0.005, 0.05, 0.1, 0.5]).kr;
    var envReciprocal = 1 / env;
    var cy = SinOsc.kr(0.1).range(env * 0.25, env * 0.1);
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 1, op1 * 25 * cy);
    var op3 = SinOsc.kr(0.1, cy * 40).range(0.25, 0.5);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.4;
    // HPF.ar(sig, 100);

    sig * env;
}.play;
)