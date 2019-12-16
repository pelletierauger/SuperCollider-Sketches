(
var f = 220 * 7.midiratio;
x = {
    var env = Env.circle([0, 1, 0.5, 0], [0.5, 0.03, 0.2, 0.5], [0, 4, 4]);
    var envG = EnvGen.kr(env, doneAction: 0);
    var env2 = Env.circle([6, 12], [10, 10] * 0.5).kr;
    var op3 = SinOsc.ar(f * 4 * [1.03, 1.02]) * 0.45 * envG * env2 * 0.2;
    var op2 = SinOsc.ar(f * 1 * [1.001, 1], op3) * 4 * envG;
    var op1 = SinOsc.ar(env2, op2) * 2 * (1 - envG);
    var sig = SinOsc.ar(f * [1, 1.001], op1) * 0.5;
    // sig = sig * LFTri.ar(f);

    // HPF.ar(sig, 100);

    sig = sig * EnvGen.kr(env, doneAction: 0);
    // sig = GVerb.ar(sig, 10, 1) * 0.1;
    sig = HPF.ar(sig, 880);
}.play;
)
x.free;

Env.new([0, 1, 0.5, 0], [0.01, 0.5, 4.85], [0, 4, -4]).plot

0.0625 * 48



(
var f = 220 * -8.midiratio;
x = {
    var env = Env.circle([0, 1, 0.5, 0], [0.5, 0.03, 0.2, 0.5], [0, 4, 4]);
    var envG = EnvGen.kr(env, doneAction: 0);
    var env2 = Env.circle([2, 1], [10, 10] * 0.5).kr;
    var op4 = SinOsc.ar(f * 1) * 1 * (1 - envG);
    var op3 = SinOsc.ar(f * 8 * [1.02, 1.01]) * 0.45 * envG * env2 * 0.05;
    var op2 = SinOsc.ar(f * 2 * [1.001, 1], op3) * 16 * envG;
    var op1 = SinOsc.ar(env2 * 2, op2) * 1 * (1 - envG);
    var sig = SinOsc.ar(f * [1, 1.001], op1 + op4) * 0.5;
    // sig = sig * LFTri.ar(f);

    // HPF.ar(sig, 100);

    sig = sig * EnvGen.kr(env, doneAction: 0);
    // sig = GVerb.ar(sig, 10, 1) * 0.1;
    sig = HPF.ar(sig, 440);
}.play;
)



(
var f = ~toFreq.("D#5") * 0.25 * 7.midiratio;
x = {
    var op1;
    var envRate = f.linlin(0, 800, 2, 0.25);
    var env = EnvGen.kr(Env.new([0, 1, 0.75, 0], [0.001, 0.02, 2] * envRate, [0, 0, -9]), doneAction: 2);
    var env2 = Env.new([0, 1, 0.75, 0], [0.01, 0.02, 2] * envRate, [0, 0, -9]).kr;
    var op5 = SinOsc.ar(f * 8 * [1.01, 1.02]) * 0.25 * (1 - env);
    var op4 = SinOsc.ar(f * 4, op5) * 0.125;
    var op3 = SinOsc.ar(Line.kr(5, 25, 10), op4) * 2 * Line.kr(1, 4, 5);
    var op2 = SinOsc.ar(f * 2, op3) * 2 * env2;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2) * 0.5 * env;
}.play;
)


(
var f = 440 * 0.25 * -5.midiratio;
x = {
    var op1;
    var envRate = f.linlin(0, 800, 2, 0.25);
    var env = EnvGen.kr(Env.new([0, 1, 0.75, 0], [0.01, 0.02, 4] * envRate, [0, 0, -9]), doneAction: 2);
    var env2 = Env.new([0, 1, 0.75, 0], [0.01, 0.02, 2] * envRate, [0, 0, -9]).kr;
    var op5 = SinOsc.ar(f * 8 * [1.01, 1.02]) * 0.25 * (1 - env);
    var op4 = SinOsc.ar(f * 4, op5) * 0.125;
    var op3 = SinOsc.ar(Line.kr(5, 25, 20), op4) * 2;
    var op2 = SinOsc.ar(f * 2, op3) * 2 * env2;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op3) * 0.5 * env;
}.play;
)



(
var f = 440 * 0.25 * 0.midiratio;
x = {
    var op1;
    var envRate = f.linlin(0, 800, 2, 0.25);
    var env = EnvGen.kr(Env.new([0, 1, 0.75, 0], [0.001, 0.02, 2] * envRate, [0, 0, -9]), doneAction: 2);
    var env2 = Env.new([0, 1, 0.75, 0], [0.01, 0.02, 2] * envRate, [0, 0, -9]).kr;
    var op5 = SinOsc.ar(f * 8 * [1.01, 1.02]) * 0.25 * (1 - env);
    var op4 = SinOsc.ar(f * 4, op5) * 0.125;
    var op3 = SinOsc.ar(Line.kr(5, 25, 10), op4) * 2 * Line.kr(1, 4, 5);
    var op2 = SinOsc.ar(f * 2, op3) * 2 * env2;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2) * 0.5 * env;
}.play;
)



(
var f = 440 * 0.25 * 5.midiratio;
x = {
    var op1;
    var env = EnvGen.kr(Env.new([0, 1, 0.25, 0], [0.01, 0.02, 2], [0, 0, -18]), doneAction: 0);
    var env3 = EnvGen.kr(Env.new([0, 1, 0.25, 0], [0.01, 0.02, 5], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    var op6 = SinOsc.ar(4) * 0.5;
    var op3 = SinOsc.ar(f * 8);
    var op2 = SinOsc.ar(f * 2, op3) * env2;
    var op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    var op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    var op7 = SinOsc.ar(f * [1, 1.001], op6 * 2 + (op5 * 0.1) + (op4 * 0.1)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    op1 + op7;
    // op1 = LPF.ar(op1, 2500);
}.play;
)

(
SynthDef.new(\scotch, {
    // var op1;
    arg out = 0, freq = 440;
    var env, env2, env3, op1, op2, op3, op4, op5, op6, op7, f;
    f = freq;
    env = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.01, 0.02, 2], [0, 0, -18]), doneAction: 0);
    env3 = EnvGen.kr(Env.new([0, 1, 0.15, 0], [0.01, 0.02, 7], [0, 0, -18]), doneAction: 2);

    // var env = Env.circle([0, 1, 0.25, 0], [0.01, 0.02, 0.5, 0], [0, 0, -18]).kr;
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.2], [0, 0]));
    op6 = SinOsc.ar(4) * 0.5;
    op3 = SinOsc.ar(f * 8);
    op2 = SinOsc.ar(f * 2, op3) * env2;
    op4 = SinOsc.ar(f * 1, op3 + op6 * 0.5);
    op5 = SinOsc.ar(f * 0.5, op3 + op6) * Line.kr(1, 2, 2);
    // var op8 = SinOsc.ar()
    op7 = SinOsc.ar(f * [1, 1.001], op6 * 2 + (op5 * 0.1) + (op4 * 0.1)) * 1 * env3;
    op1 = SinOsc.ar(f * [1.001, 1.0], op2 + op4 + op5) * 0.25 * env;
    Out.ar(0, op1 + op7 * 0.5);
}).add;
)


(
~muds2.stop;
~muds2 = Pbind(
    \instrument, \scotch,
    \dur, Pseq([1, 0.25, 0.5, 0.25], inf),
    \freq, ~toFreq.("D#2") * Pseq([0, 10, 14, 7].midiratio, inf)
).play(quant: 1);
)


(
var key = ~toMidi.("D#4");
var notes = key + [-12 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-12 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
~pia.stop;
~pia = Pbind(
    \instrument, \bouette,
    \dur, Pseq(0.5!1 ++ (0.2!3) ++ 3.1, inf),
    \freq, Pseq(nn.midicps, inf)
).play(t, quant: [4, -0.4]);
~piaBas.stop;
~tamb.stop;
)

(
SynthDef.new(\bouette, {
    arg freq = 440, amp = 1;
    // var op1;
    var f = freq;
    var envRate = f.linlin(0, 800, 2, 0.25);
    var env = EnvGen.kr(Env.new([0, 1, 0.75, 0], [0.01, 0.02, 4] * envRate, [0, 0, -9]), doneAction: 2);
    var env2 = Env.new([0, 1, 0.75, 0], [0.01, 0.02, 2] * envRate, [0, 0, -9]).kr;
    var op5 = SinOsc.ar(f * 8 * [1.01, 1.02]) * 0.25 * (1 - env);
    var op4 = SinOsc.ar(f * 4, op5) * 0.125;
    var op3 = SinOsc.ar(Line.kr(5, 25, 10), op4) * 2 * Line.kr(1, 4, 5);
    var op2 = SinOsc.ar(f * 2, op3) * 2 * env2;
    var op1 = SinOsc.ar(f * [1.001, 1.0], op2) * 0.5 * env;
    // var recLine = XLine.kr(400,1000, 4, doneAction: 2);
    // RecordBuf.ar(op1, 365);
    Out.ar(0, op1 * amp);
}).add;
)

b = Buffer.alloc(s, 44100 * 4.0, 2); // a four second 2 channel Buffer;
b.bufnum;
b.play;
Synth.new(\bouette, [\freq, ~toFreq.("D#3")]);

(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \bouette,
    \dur, Pseq([2, 1, 1], inf),
    \freq, ~toFreq.("D#3") * Pseq([3, 2, 5, 7, 10].midiratio, inf),
    \amp, 0.25
).play(quant: [1, 0.5]);
)


(
~piz.stop;
~piz = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([2, 1, 2, 0.5, 0.5] * 0.25, inf),
    \amp, Pseq([1, 0.25], inf) * 34,
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf)
).play(quant: 1);
)
b.numFrames;

(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(buf), startPos: spos * 176400);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
(
SynthDef(\samplerFlip, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(buf), startPos: spos * 176400);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    Out.ar(out, sig);
}).add;
)

t = TempoClock.new;
t.tempo_(50/60);
t.permanent = true;
(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, 1 / 16 * 1,
    \spos, Pseq([0.5], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq([0, 4, 11, 14].midiratio, inf) * 0.midiratio,
    \amp, 4,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
~shimmer.stop;
~shimmer = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
    \dur, 1 / 16 * 1,
    \spos, Pseq([0.5], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq([18, 16].midiratio.stutter(120), inf) * 0.midiratio,
    \amp, Pseq(Pseries(0, 4/60, 60).asStream.nextN(60).mirror2, inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)
(
~muds2.stop;
~muds2 = Pbind(
    \instrument, \scotch,
    \dur, Pseq([1] * 2, inf),
    \freq, ~toFreq.("D#2") * Pseq([0].midiratio, inf)
).play(quant: 1);
)

Pseries(0, 4/60, 60).asStream.nextN(60).mirror2.size

Pseries(0, 0.001, 640).asStream.nextN(640)[639]
Pseries(0.2, 0.001, 160).asStream.nextN(160)[159]