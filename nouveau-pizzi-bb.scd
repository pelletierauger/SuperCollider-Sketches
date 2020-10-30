b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0001 7-Audio.aif");
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/pizzi1.wav");

b.numFrames;
b.numChannels

// Store the values from the Buffer in a FloatArray called ~fl
~buf.loadToFloatArray(action: { arg array; ~fl = array;});
// Evaluate ~fl and confirm that it is a FloatArray.
~fl;
~fl.size;

(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, filt, susT;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], [-8, -8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // sig = HPF.ar(sig, filt);
    // sig = CombL.ar(sig, 0.05, 48.midicps.reciprocal, 9) * 0.2;
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\samplerKarplus, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, pitch = 60, susT;
    var sig, env, lfo, env2;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], [-8, -8, -8]));
    env2 = EnvGen.kr(Env.new([0, 1, 0], [atk, 16], [-8, -8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // sig = HPF.ar(sig, filt);
    sig = CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [1, 1.001], 16) * 0.2 * env2;
    Out.ar(out, sig);
}).add;
)

~t = TempoClock.new(120/60);
~t.permanent = true;
~t.tempo = 130/60;

(
SynthDef.new(\sine, {
    arg out, freq = 880, lon = 3, amp = 1, pan = 0, atk = 0.001, rel = 0.01;
    var sig, env;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = SinOsc.ar(freq!2, SinOsc.ar(freq) * 1) * 0.1 * env * amp;
    Out.ar(out, sig);
}).add;
)



(
~knockAKar.stop;
~knockAKar = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(48 + [0, -2].stutter(2) - 12, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \rate, Pseq([-3, -5].stutter(2).midiratio, inf),
    \amp, Pseq([4], inf)
).play(~t, quant: [2, -0.06]);
)

(
~knockBKar.stop;
~knockBKar = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, Pseq([2, 1, 1], inf),
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(60 + [-5, 4, 2, 5, -3, 4, 2, 5].reverse + 0, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.06]);
)


(
~metro.stop;
~metro = Pbind(
    \instrument, \sine,
    \amp, 2,
    \freq, 880 * 2
).play(~t, quant: [1]);
)


(
~knockA.stop;
~knockA = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 2,
    \spos, Pseq([0.3509], inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.06]);
)


(
~knockB.stop;
~knockB = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3543], inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.3 + 0.5]);
)


(
var n = 16;
~hats.stop;
~hats = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 0.5,
    \spos, Pseq([0.334], inf),
    \rel, 0.001,
    \susT, 0.8,
    \atk, 0.001,
    \rate, 1,
    \amp, Pseq([1], inf) * Pseq(Pseries(0.5, 1/n, n).asStream.nextN(n).reverse, inf)
    * Pseq([1, 0.5, 0.75, 0.5], inf) * 0.2,
    \filt, Pseq(Pseries(100, 100, n).asStream.nextN(n), inf)
).play(~t, quant: [2, -0.1]);
)



(
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.369], inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \amp, 1.5
).play(~t, quant: [1, -0.0]);
)




(
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.399], inf),
    \atk, 0.001,
    \susT, 1.3,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.29 + 1]);
)




(
~squeak.stop;
~squeak = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, Pseq([Rest(2.5), 1.5], inf),
    \spos, Pseq([0.852], inf),
    \atk, 0.001,
    \susT, 0.55,
    \pitch, Pseq([60, 53].stutter(4), inf),
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 2 * 0.75
).play(~t, quant: [2, -0.3 + 1]);
~squeak2.stop;
~squeak2 = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, Pseq([Rest(2.5), 1.5], inf),
    \spos, Pseq([0.852], inf),
    \atk, 0.001,
    \susT, 0.55,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 0.65 * 0.75
).play(~t, quant: [2, -0.3 + 1]);
)

(
~squeakB.stop;
~squeakB = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, Pseq([Rest(2), 2], inf),
    \spos, Pseq([0.869], inf),
    \atk, 0.001,
    \susT, 0.55,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.1]);
)



(
~guitareB.stop;
~guitareB = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 0.25,
    \spos, Pseq([0.2, 0.195], inf),
    \spos, Pseq([0.195 * 2, 0.1952 * 2] + 0.1, inf),
    \rel, 0.4 + Pseq(Pseries(0.01, 1/16 * 0.1, 16).asStream.nextN(16), inf),
    \atk, 0.02,
    \rate, -7.midiratio,
    \amp, Pseq([8, 8] * 4, inf) * Pseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf)
    * Pseq([1, 0.5, 0.75, 0.5], inf) * 2,
    \pan, 0,
    \out, 0
).play(~t, quant: [1]);
)

(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, Pseq([3, 3, 4, 2, 4] / 8, inf),
    \dur, Pseq([3, 3, 2] / 4, inf),
    // \dur, Pseq([2, 3, 3] / 4, inf),
    \spos, Pseq([0.6], inf),
    \rel, 1.2,
    \atk, 0.001,
    \rate, -8.midiratio,
    \amp, 12 * 4,
    \pan, 0,
    \out, 0
).play(~t, quant: [1]);
)

(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, Pseq([3, 3, 4, 2, 4] / 4, inf),
    // \dur, Pseq([3, 3, 2] / 4, inf),
    // \dur, Pseq([2, 3, 3] / 4, inf),
    \spos, Pseq((0.3!3) ++ (0.21!2) * 2, inf),
    \rel, 1.2,
    \atk, 0.001,
    \rate, Pseq([-8, -8, -8, -5, -5].midiratio, inf),
    \amp, 12 * 4,
    \pan, 0,
    \out, 0
).play(~t, quant: [1]);
)

(3!2) ++ (2!3)

(
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, Pseq([3, 3, 4, 2, 4] / 4, inf),
    // \dur, Pseq([2, 3, 3] / 4, inf),
    \spos, Pseq([0.475], inf),
    \spos, Pseq((0.03!3) ++ (0.0415!2) * 2, inf),
    \rel, 5,
    \atk, 0.001,
    \rate, -12.midiratio,
    \amp, Pseq((6!3) ++ (3!2) * 4, inf),
    \pan, 0,
    \out, 0
).play(~t, quant: [1]);
)


(
~guitareE.stop;
~guitareE = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, Pseq([8] / 8, inf),
    // \dur, Pseq([2, 3, 3] / 4, inf),
    \spos, Pseq([0.475], inf),
    \spos, Pseq([0.0098] * 2, inf),
    \rel, 0.8,
    \atk, 0.001,
    \rate, -12.midiratio,
    \amp, 6 * 4,
    \pan, 0,
    \out, 0
).play(~t, quant: [1]);
)

s.record;
s.stopRecording;


(
~knockBKarB.stop;
~knockBKarB = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, Pseq([2, 1, 1] * 4, inf),
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(60 + [-5, 4, 2, 5, -3, 4, 2, 5].reverse + 0, inf),
    \atk, 0.001,
    \susT, 0.25,
    \rel, 0.001,
    \rate, 24.midiratio,
    \amp, 2
).play(~t, quant: [2, -0.06]);
)
