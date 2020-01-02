(
var f = ~toFreq.("E3") * 5.midiratio;
{

    var op4 = SinOscFB.ar(f * 4, 0.5);
    var op3 = SinOsc.ar(0.1).range(0.4, 1);
    var op2 = SinOsc.ar(f * 0.5, op4 * 0.1) * op3;
    var op1 = SinOsc.ar(f * [1, 1.001], op2) * 0.1;
    op1;
}.play;
)