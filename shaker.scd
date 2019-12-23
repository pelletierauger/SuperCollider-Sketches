(
var f = 440;
{
    var op2 = SinOscFB.ar(f * 100, 10);
    var op1 = SinOsc.ar(f * [1, 1.01] * 40, op2 * 0.25) * 0.1;
    op1;
}.play;
)

(
var f = 440;
{
    var op2 = SinOscFB.ar(f * 100, 10);
    var op1 = SinOsc.ar(f * [1, 1.01] * 40, op2 * 1) * 0.1;
    op1;
}.play;
)

~wh = Buffer.alloc(s, 44100 * 6.0, 2);
~wh.bufnum;
~wh.play;
~wh.numChannels
~wh.numFrames
(
{
    var noise = WhiteNoise.ar(0.4!2) * 0.1;
    var recLine = XLine.kr(400, 1000, 6, doneAction: 2);
    RecordBuf.ar(noise, 1);
}.play;
)

(
SynthDef(\noiseSampler, {
    arg buf = ~wh, rate = 1, spos = 0, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~wh, rate * BufRateScale.ir(buf), startPos: spos * 264600);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

Synth(\noiseSampler, [\rate, 0.5, \atk, 0.01, \rel, 0.4]);


(
var d = 0.01;
~shaker.stop;
~shaker = Pbind(
    \instrument, \noiseSampler,
    \dur, 1/1 + Pseq([0.01, -0.01] * 2, inf),
    \rel, Pseq([0.25, 0.15, 0.45, 0.15] * 1.75, inf),
    \atk, 0.12,
    \spos, Pseq([0, 264600], inf),
    \rate, Pseq([0.65, -0.45, 0.5, -0.45], inf),
    \amp, Pseq([1, 0.5, 1, 0.5], inf) * 0.5,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)




(
SynthDef(\sineSynth, {
    arg freq = 1, pan = 0, amp = 1, rel = 3, atk = 0.1, out = 0;
    var op1, op2, op3, env, env2, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    env2 = Env.new([0, 1, 0.125], [0.001, 0.2]).kr;
    op3 = SinOsc.ar(freq * 0.5);
    op2 = SinOsc.ar(freq * 2, op3 * Line.kr(0, 8, 3)) * env2;
    lfo = SinOsc.kr(1, 1).range(0.25, 1);
    op1 = SinOsc.ar(freq * [1, 1.001], op2 * 0.6) * env * 0.8 * lfo * amp;
    Out.ar(out, op1);
}).add;
)


(
var key = ~toMidi.("A3");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
~pia.stop;
~pia = Pbind(
    \instrument, \sineSynth,
    \atk, 0.001,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \freq, Pseq(nn.midicps, inf)
).play(t, quant: [4, -0.4]);
)

(
var key = ~toMidi.("A2");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
nn = [key, key - 5].stutter(8);
nn = [key, key];
~surdo.stop;
~surdo = Pbind(
    \instrument, \sineSynth,
        \atk, 0.005,
    \dur, Pseq(2!1, inf),
    \freq, Pseq(nn.midicps, inf)
).play(t, quant: 4);
)

(
var key = ~toMidi.("A5");
var notes = key + [-12, -8, -6, 4 - 12, 11 - 12] - 0;
// var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes.reverse.stutter(1);
~piaHaut.stop;
~piaHaut = Pbind(
    \instrument, \sineSynth,
            \atk, 0.001,
    \rel, 1,
    \dur, Pseq([2,2,1,2,1] ++ [Rest(1),2,2,1,2] * 0.5, inf),
    \freq, Pseq(nn.midicps, inf)
).play(t, quant: [4]);
)