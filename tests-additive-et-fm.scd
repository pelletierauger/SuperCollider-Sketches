// Generating a square wave by adding sine waves.
(
var n = 40;
var f = Pseries(1,2,n).asStream.nextN(n);
var a = 1 / f;
{Mix(SinOsc.ar(220 * f, 0, a)) * 0.1}.play;
)


(
var f = 440 * -24.midiratio;
{
    // (1..10).collect(SinOsc.ar(_)/_).sum;
    var n = 15;
    var arr = Pseries(2,2,n).asStream.nextN(n);
    var op2 = SinOsc.ar(1 * f * [1, 1.001]) * 2;

    var op5 = SinOsc.ar(4).range(0.1, 1);
    var op1 = (SinOsc.ar(1 * f * arr, rrand(0, 4pi)!n + op2 + op5) / arr * 16).sum;
    var op3 = SinOsc.ar(f * 0.5, op1 * 0.2 + (1 - op5));
    var op4 = SinOsc.ar(f * [1.001, 1]) * 0.1;
    Balance2.ar(op4[0], op4[1], 0, 0.5);
}.play;
)


(1..10).collect(_ * 2);

[1, 2] * [10, 100].reverse

rrand(0, 1.0)!10