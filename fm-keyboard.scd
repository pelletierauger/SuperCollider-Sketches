(
var f = 220 * 14.midiratio;
{
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 1]), doneAction: 2);
    var op2 = SinOsc.ar(f);
    var op1 = SinOsc.ar(f!2, op2 * 2 % 2pi);
    op1 * 0.2 * env;
}.play;
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var f = num.midicps;
    {
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [0.0001, 0.2, 0.005]), doneAction: 2);
        var op4 = SinOsc.ar(f);
        var op3 = SinOsc.ar(f, op4 * 1.5 % 2pi);
        var op2 = SinOsc.ar(f, op3 * 1.5 % 2pi);
        var op1 = SinOsc.ar(f!2, op2 * 2 % 2pi);
        op1 * 0.2 * env;
    }.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var f = num.midicps;
    {
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [4.5, 0, 6.5], ['lin', 'lin', -8]), doneAction: 2);
        var op4 = SinOsc.ar(f);
        var op3 = SinOsc.ar(f, op4 * 1.5 % 2pi);
        var op2 = SinOsc.ar(f, op3 * 1.5 % 2pi);
        var op1 = SinOsc.ar(f!2, op2 * 0 % 2pi);
        op1 * 0.2 * env;
    }.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)
// ---------------------------------------
// 12743 fichiers
// ---------------------------------------

Env.new([0, 1, 1, 0], [4.5, 0, 6.5], ['lin', 'lin', -8]).plot


(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var f = num.midicps * [1.002, 1, 1.001, 0.999].scramble;
    {
        var env = EnvGen.kr(Env.new([0, 1, 0.75, 0], [0.0001, 0.8, 1], ['lin', 'lin', -8]), doneAction: 2);
        var env2 = EnvGen.kr(Env.circle([1, 0], [0.5]));
        var op4 = SinOsc.ar(f);
        var op3 = SinOsc.ar(f, op4 * 0 % 2pi);
        var op2 = SinOsc.ar(f * 16 * 0.5, op3 * 0.5 % 2pi);
        var op1a = SinOsc.ar(f!2, (op2 * env2 % 2pi) + op3 % 2pi);
        var op1b = SinOsc.ar(f!2 * 2, (op2 * env2 % 2pi) + op3 % 2pi) * 0.8;
        var op1c = SinOsc.ar(f!2 * 4, (op2 * env2 % 2pi) + op3 % 2pi) * 0.7;
        var op1 = op1a + op1b + op1c;
        var sig = op1 * 0.2 * env;
        Splay.ar(sig, 1);
    }.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)