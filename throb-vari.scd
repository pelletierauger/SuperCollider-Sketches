(
var f = 440 * (-24 + 0).midiratio;
~x.free;
~x = {
    var env = Env.circle([0, 1, 0.5, 0], [0.015, 0.05, 0.1, 0.5]).kr;
    var envReciprocal = 1 / env;
    var cy = SinOsc.kr(0.1).range(env * 0.1, env * 1);
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 1, op1 * 15 * cy);
    var op3 = SinOsc.kr(0.1, cy * 40).range(0.25, 0.25);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.4;
    // HPF.ar(sig, 100);

    sig * env;
}.play;
)

(
var f = 440 * (-24 + 9 + 7).midiratio;
~y.free;
~y = {
    var env = Env.circle([0, 1, 0.5, 0], [0.015, 0.05, 0.1, 0.5]).kr;
    var envReciprocal = 1 / env;
    var cy = SinOsc.kr(0.1).range(env * 0.1, env * 0.1);
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 1, op1 * 15 * cy);
    var op3 = SinOsc.kr(0.1, cy * 40).range(0.25, 0.25);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.4;
    // HPF.ar(sig, 100);

    sig * env;
}.play;
)


(
var f = 440 * (-24 + 9 + 7 + 8).midiratio;
~z.free;
~z = {
    var env = Env.circle([0, 1, 0.5, 0], [0.015, 0.05, 0.1, 0.25]).kr;
    var envReciprocal = 1 / env;
    var cy = SinOsc.kr(0.1).range(env * 0.1, env * 0.1);
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 1, op1 * 15 * cy);
    var op3 = SinOsc.kr(0.1, cy * 40).range(0.25, 0.25);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.4;
    // HPF.ar(sig, 100);

    sig * env;
}.play;
)