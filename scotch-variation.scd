(
~muds2.stop;
~muds2 = Pbind(
    \instrument, \scotch,
    \dur, Pseq([5] * 1, inf),
    \freq, 220 * -14.midiratio * Pseq([0, -1].stutter(1).midiratio, inf)
).play(quant: [1, 0.5]);
)

(
SynthDef.new(\scotch, {
    // var op1;
    arg out = 0, freq = 440;
    var env, env2, env3, op1, op2, op3, op4, op5, op6, op7, f;
    f = freq;
    env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.01, 0.02, 14], [0, 0, -18]), doneAction: 0);
    env3 = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.01, 0.02, 12], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    op6 = SinOsc.ar(4) * 0.5;
    op3 = SinOsc.ar(f * 4);
    op2 = SinOsc.ar(f * 2, op3) * env2;
    op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    op7 = SinOsc.ar(f * [1, 1.001] * 8, op6 * 2 + (op5 * 0.1) + (op4 * 0.5)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    Out.ar(0, op1 + op7);
}).add;
)


(
SynthDef.new(\scotch, {
    // var op1;
    arg out = 0, freq = 440;
    var env, env2, env3, op1, op2, op3, op4, op5, op6, op7, f;
    f = freq;
    env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.01, 0.02, 14], [0, 0, -18]), doneAction: 0);
    env3 = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.01, 0.02, 12], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    op6 = SinOsc.ar(4) * 0.5;
    op3 = SinOsc.ar(f * 8);
    op2 = SinOsc.ar(f * 2, op3) * env2;
    op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    op7 = SinOsc.ar(f * [1, 1.001] * 8, op6 * 2 + (op5 * 0.1) + (op4 * 0.5)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    Out.ar(0, op1 + op7);
}).add;
)



// étrange
(
SynthDef.new(\scotch, {
    // var op1;
    arg out = 0, freq = 440;
    var env, env2, env3, op1, op2, op3, op4, op5, op6, op7, f;
    f = freq;
    env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.5, 0.02, 14], [0, 0, -18]), doneAction: 0);
    env3 = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.01, 0.02, 12], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    op6 = SinOsc.ar(4) * 0.5;
    op3 = SinOsc.ar(f * 4);
    op2 = SinOsc.ar(f * 2, op3) * env2;
    op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    op7 = SinOsc.ar(f * [1, 1.001] * 8, op6 * 2 + (op5 * 0.1) + (op4 * 0.5)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    Out.ar(0, op1 + op7);
}).add;
)


(
SynthDef.new(\scotch, {
    // var op1;
    arg out = 0, freq = 440;
    var env, env2, env3, op1, op2, op3, op4, op5, op6, op7, f;
    f = freq;
    env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.5, 0.02, 14], [0, 0, -18]), doneAction: 0);
    env3 = EnvGen.kr(Env.new([0, 1, 0.15, 0], [1.5, 0.02, 12], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    op6 = SinOsc.ar(4) * 0.5;
    op3 = SinOsc.ar(f * 4);
    op2 = SinOsc.ar(f * 2, op3) * env2;
    op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    op7 = SinOsc.ar(f * [1, 1.001] * 8, op6 * 2 + (op5 * 0.1) + (op4 * 0.5)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    Out.ar(0, op1 + op7);
}).add;
)

// très beau
(
SynthDef.new(\scotch, {
    // var op1;
    arg out = 0, freq = 440;
    var env, env2, env3, op1, op2, op3, op4, op5, op6, op7, f;
    f = freq;
    env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.5, 0.02, 14], [0, 0, -18]), doneAction: 0);
    env3 = EnvGen.kr(Env.new([0, 1, 0.15, 0], [1.5, 0.02, 12], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    op6 = SinOsc.ar(4) * 0.5;
    op3 = SinOsc.ar(f * 8);
    op2 = SinOsc.ar(f * 2, op3) * env2;
    op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    op7 = SinOsc.ar(f * [1, 1.001] * 4, op6 * 2 + (op5 * 0.1) + (op4 * 0.5)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    Out.ar(0, op1 + op7 * 0.25);
}).add;
)


(
SynthDef.new(\scotch, {
    // var op1;
    arg out = 0, freq = 440;
    var env, env2, env3, op1, op2, op3, op4, op5, op6, op7, f;
    f = freq;
    env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.5, 0.02, 14], [0, 0, -18]), doneAction: 0);
    env3 = EnvGen.kr(Env.new([0, 1, 0.15, 0], [1.5, 0.02, 12], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    op6 = SinOsc.ar(4) * 0.5;
    op3 = SinOsc.ar(f * 16);
    op2 = SinOsc.ar(f * 16, op3) * env2;
    op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    op7 = SinOsc.ar(f * [1, 1.001] * 4, op6 * 2 + (op5 * 0.1) + (op4 * 0.5)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    Out.ar(0, op1 + op7 * 0.25);
}).add;
)



(
SynthDef.new(\scotch, {
    // var op1;
    arg out = 0, freq = 440;
    var env, env2, env3, op1, op2, op3, op4, op5, op6, op7, f;
    f = freq;
    env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.5, 0.02, 14], [0, 0, -18]), doneAction: 0);
    env3 = EnvGen.kr(Env.new([0, 1, 0.15, 0], [1.5, 0.02, 12], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    op6 = SinOsc.ar(4) * 0.5;
    op3 = SinOsc.ar(f * 16);
    op2 = SinOsc.ar(f * 16, op3) * env2;
    op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    op7 = SinOsc.ar(f * [1, 1.001] * 4, op6 * 2 + (op5 * 0.1) + (op4 * 0.5)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    Out.ar(0, op1 + op7 * 0.25);
}).add;
)