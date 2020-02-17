(
var f = 220 * -1.midiratio;
{
    var op1, env, amp = 0.1, op2, op3;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.00125, 0.5]), doneAction: 2);
    op2 = 1 - (LFTri.ar(f * 0.5) * 4 * (env));
    op3 = 1 - (LFTri.ar(f * 1.01) * 4 * (env));
    op1 = SinOsc.ar(f!2) * op2 * op3 * env * amp;
}.play;
)
(
var f = 220 * 0.midiratio;
{
    var op1, env, amp = 0.125, op2, op3;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.00125, 0.5]), doneAction: 2);
    op2 = 1 - (LFTri.ar(f * 0.125) * 32 * (env));
    op3 = 1 - (LFTri.ar(f * 0.5) * 1 * (env));
    op1 = SinOsc.ar(f!2) * op2 * op3 * env * amp;
}.play;
)

(
SynthDef.new(\chirp, {
    |freq = 440, amp = 4|
    var op1, env, op2, op3;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.00125, 0.5]), doneAction: 2);
    op2 = 1 - (LFTri.ar(freq * 0.75) * 1 * (env));
    op3 = 1 - (LFSaw.ar(freq * 0.5) * 1 * (env));
    op1 = SinOsc.ar(freq!2) * op2 * op3 * env * amp;
    op1 = HPF.ar(op1, 900);
    Out.ar(0, op1);
}).add;
)

(
SynthDef.new(\chirp, {
    |freq = 440, amp = 4|
    var op1, env, op2, op3;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.0125, 0.5]), doneAction: 2);
    op2 = 1 - (LFTri.ar(freq * 0.25) * Line.kr(0, 1, 0.5) * (env));
    op3 = 1 - (LFTri.ar(freq * 0.25) * 4 * (env));
    op1 = SinOsc.ar(freq!2) * op3 * env * amp;
    // op1 = HPF.ar(op1, 900);
    Out.ar(0, op1);
}).add;
)
(
var key = ~toFreq.("Bb3");
~melo.stop;
~melo = Pbind(
    \instrument, \chirp,
    \dur, Pseq([1, 1, 0.25, 0.75] ++ [1, 1, 0.75, 0.25] * 0.5, inf),
    \freq, Pseq(key * [0, 2, 3, 10, -5, 2, 3, 7].midiratio.stutter(1), inf) * Pseq([1, 1], inf),
    \amp, Pseq(0.15!3 ++ 0.25, inf) * 1
).play(quant: [1]);
)


(
var key = ~toFreq.("Bb3");
~melo.stop;
~melo = Pbind(
    \instrument, \chirp,
    \dur, Pseq([1, 1, 0.5, 0.5] * 0.5, inf),
    \freq, Pseq(key * [0, 2, 3, 10, -5, 2, 3, 7].midiratio.stutter(2), inf) * Pseq([1, 2], inf),
    \amp, Pseq(0.15!3 ++ 0.25, inf) * 1
).play(quant: [1]);
)

(
SynthDef.new(\chirp, {
    |freq = 440, amp = 4|
    var op1, env, op2, op3, pres, abse;
    pres = Rand(4, 8);
    abse = pres.reciprocal;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.005, 0.5]), doneAction: 2);
    op2 = 1 - (LFTri.ar(freq * 0.25) * Line.kr(0, 1, 0.5) * (env));
    op3 = 4 - (LFTri.ar(freq * 0.25) * 4 * Line.kr(1, 0, 0.125) * (env));
    op1 = SinOsc.ar(freq!2) * op3 * env * amp * 1;
    // op1 = HPF.ar(op1, 900);
    Out.ar(0, op1);
}).add;
)
