
// un délice
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
    var op5 = SinOsc.ar(f * 0.25) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001] * 0.5, op2 * 1 + op4 + op5) * lfo * 0.1;
    var op6 = SinOsc.ar(f * 0.25) * 0.1;
    Out.ar(0, op1 + op6 * env * amp);
}).add;
)


(
// var f = 880 * 5.midiratio;
SynthDef.new(\pizzicato, {
    arg freq = 880, amp = 1;
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.01, 0.1, 4], [3, -3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    var env3 = Env.new([0, 1, 0], [0.0001, 0.025], [3, -7]).kr;
    var pEnv = Env.new([0.9, 1], [0.15], [3]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op4 = SinOsc.ar(f * 0.0625) * env3 * 10;
    var op3 = SinOsc.ar(f * 1, lfo * 12);
    var op2 = SinOsc.ar(f * 1, op4 * 12 + (op3 * 4) * (1 - env2)) * env2;
    var op5 = SinOsc.ar(f * 0.5) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001] * 0.5, op2 * 1 + op4 + op5) * lfo * 0.1;
    var op6 = SinOsc.ar(f * 0.5) * 0.1;
    Out.ar(0, op1 + op6 * env * amp);
}).add;
)