c.numFrames
c.duration
c = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dehors/chirp-kit.wav");

~t = TempoClock.new(80/60).permanent_(true);
~t.tempo = 190/60;
~t.beatDur
(
SynthDef(\samplerAbs, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\samplerAbsLPF, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0, lpf = 4000;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    sig = LPF.ar(sig, lpf);
    Out.ar(out, sig);
}).add;
)


(
SynthDef(\samplerAbsLPFFlip, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0, lpf = 4000;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    sig = LPF.ar(sig, lpf);
    Out.ar(out, sig);
}).add;
)


(
SynthDef(\samplerAbsKarplusLPF, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, pitch = 60, susT, lpf = 4000;
    var sig, env, lfo, env2;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], [-8, -8, -8]));
    env2 = EnvGen.kr(Env.new([0, 1, 0], [atk, 16], [-8, -8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // sig = HPF.ar(sig, filt);
    sig = CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [1, 1.001], 16) * 0.2 * env2;
    sig = LPF.ar(sig, lpf) * 1.5;
    Out.ar(out, sig);
}).add;
)




////----

(
SynthDef(\samplerAbs, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, pitch = 45, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 0);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    // sig = sig + (CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [1, 1.001], 16) * 0.025);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Line.kr(0, 1, 10, doneAction: 2);
    Out.ar(out, sig);
}).add;
)


(
SynthDef(\samplerAbsKarp, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, pitch = 45, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 0);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    // sig = HPF.ar(sig, 2000) * 4;
    sig = sig + (CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [1, 1.001], 16) * 0.025);
    sig = Balance2.ar(sig[0], sig[1], pan, 1) * Line.kr(0, 1, 0.0625);
    Line.kr(0, 1, 10, doneAction: 2);
    Out.ar(out, sig);
}).add;
)

///
(
~guitareA.stop;
~guitareA = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 1,
    \spos, Pseq(1.503!1, inf),
    \rel, 0.01,
    \susT, 0.2,
    \amp, Pseq(Pseries(0.1, 0.1, 6).asStream.nextN(6) * 5 * 0.25, inf)
).play(~t, quant: [6]);
~guitareA2.stop;
~guitareA2 = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 0.5,
    \spos, Pseq(1.503!1, inf),
    \rel, 0.01,
    \rate, 2,
    \lpf, 1000,
    \susT, 0.1,
    \amp, Pseq(Pseries(0.1, 0.1, 24).asStream.nextN(24) * 1.25, inf)
).play(~t, quant: [6]);
)

(
~guitareW.stop;
~guitareW = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, Pseq([0.5, 5.5], inf),
    \spos, Pseq([0.464, 1.503].stutter(2), inf),
    \rel, 0.01,
    \rate, Pseq([0.5, 1], inf),
    \susT, Pseq([0.2, 0.2].stutter(2), inf),
    \amp, 2
).play(~t, quant: [6]);
)


// Mélodie descendante

(
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \samplerAbsKarp,
    \buf, c,
    \dur, 6,
    \spos, Pseq([0.464], inf),
    \rel, 0.01,
    \pitch, Pseq([52, 50, 48, 45], inf),
    \susT, Pseq([0.2, 0.2, 0.2, 0.2], inf),
    \amp, 16
).play(~t, quant: [6, 0.5]);
)


// Mélodie descendante 2
(
~guitareD2.stop;
~guitareD2 = Pbind(
    \instrument, \samplerAbsKarp,
    \buf, c,
    \dur, 6,
    \spos, Pseq([0.464], inf),
    \rel, 0.01,
    \rate, 4,
    \pitch, Pseq([52, 50, 48, 45], inf),
    \susT, Pseq([0.2, 0.2, 0.2, 0.2], inf),
    \amp, 3
).play(~t, quant: [6, -2.5]);
)


// Basse mélan
(
~raw.set(\gate, 0, \fadeTime, 0.1);
~raw = {
    var t = Impulse.kr(~t.beatDur.reciprocal / 6 / 4);
    var env = EnvGen.kr(Env([0, 1, 0], [0.85, 7 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-9, -14, -12] + 1 + 0, inf));
    var sig = PlayBuf.ar(2, ~out.bufnum, rate: (note - 0.75).midiratio, trigger: t);
    sig = sig * 0.75 * env;
    sig = LPF.ar(sig, 200 + (17500 * env));
    sig = LPF.ar(sig, SinOsc.ar(0.125).range(400, 18000)) * 2;
    sig;
}.play;
)

(
~guitareE.stop;
~guitareE = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 12,
    \spos, Pseq([9.015], inf),
    \rel, 0.01,
    \rate, 0.25 * 7.5.midiratio,
    \susT, Pseq([4], inf),
    \lpf, 2000,
    \amp, 4
).play(~t, quant: [1]);
)


(
~guitareA.stop;
~guitareA = Pbind(
    \instrument, \sampler,
    \buf, c,
    \dur, 2,
    \spos, Pseq([0.1035], inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 2,
    \rate, 0.5,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 4 * 1,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)


(
~guitareE.stop;
~guitareE = Pbind(
    \instrument, \samplerAbsKarplusLPF,
    \buf, c,
    \dur, 0.5,
    \spos, Pseq([69.61], inf),
    \rel, 0.5,
    // \atk, 0.5,
    \susT, 0.0,
    \rate, Pseq([0, -5].midiratio.stutter(8), inf),
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \pitch, Pseq([60, 58].stutter(8), inf),
    \amp, Pseq(Pseries(2, -1/8, 8).asStream.nextN(8), inf),
    \lpf, 3000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)

(
x.free;
x = {
    var f = 33;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
    (MiVerb.ar(sig) * 0.5);
}.play;
)
y.free;
y = { MiRings.ar(PinkNoise.ar(0.1), pit: 33) * 0.5 * Line.kr(0, 1, 3)}.play;


(
z.free;
z = {
    var f = 33 - 5;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
    (MiVerb.ar(sig) * 0.5);
}.play;
)



(
~guitareB.stop;
~guitareB = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 2,
    \spos, Pseq([90.882, 93.748, 90.882, 99.599], inf),
    \rel, 1.5,
    \susT, 0,
    // \atk, 0.5,
    // \susT, 1.5,
    // \rate, 0.5,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 4 * 1,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1, -0.25]);
)


(
~chirp.stop;
~chirp = Pbind(
    \instrument, \samplerAbs,
    \buf, d,
    \dur, 2,
    \spos, Pseq([2.366, 0], inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 0.1,
    // \rate, -5.midiratio,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 2,
    \lpf, 3000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)

(
~chirp.stop;
~chirp = Pbind(
    \instrument, \samplerAbs,
    \buf, d,
    \dur, 0.25,
    \spos, Pseq([Rest(), 0].stutter(8), inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 0.1,
    // \rate, -5.midiratio,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 0.5,
    \lpf, 3000,
    \amp, Pseq([0.5, 0.3].stutter(1), inf),
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)


(
~chirpB.stop;
~chirpB = Pbind(
    \instrument, \samplerAbs,
    \buf, d,
    \dur, 1,
    \spos, Pseq([1.81].stutter(8), inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 0.1,
    // \rate, -5.midiratio,
    \rate, Pseq([0].midiratio.stutter(8), inf),
    \amp, 1,
    \lpf, 3000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1, 0.5]);
)

(
x.free;
x = {
    var t = Impulse.ar(0.125);
    var f = 33 + Demand.ar(t, 0, Dseq([2, 0], inf));
    // var f = 33;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
    (MiVerb.ar(sig) * 0.5);
}.play;
)

(
~chirpC.stop;
~chirpC = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, d,
    \dur, 0.5,
    \spos, Pseq([1.81].stutter(8), inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 0.75,
    \rate, -10.midiratio,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 2,
    \lpf, 4000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1, 0.25]);
)

(
~chirpD.stop;
~chirpD = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, d,
    \dur, 1,
    \spos, Pseq([0].stutter(8), inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 1.5,
    \rate, -36.midiratio,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 1,
    \lpf, 500,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)

(
~chirpC.stop;
~chirpC = Pbind(
    \instrument, \samplerAbs,
    \buf, d,
    \dur, 0.5,
    \spos, Pseq([2.657 * 0].stutter(8), inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 0.1,
    // \rate, -10.midiratio,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, Pseq([2, 1].stutter(1) * 0.25, inf),
    \lpf, 4000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)


(
~guitareG.stop;
~guitareG = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 4,
    \spos, Pseq([16.954], inf),
    \spos, Pseq([17.35], inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 2.0,
    // \rate, -12.midiratio,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 5,
    \lpf, 3000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)


(
~chirpGG.stop;
~chirpGG = Pbind(
    \instrument, \samplerAbs,
    \buf, d,
    \dur, 2,
    \spos, Pseq([Rest(0), 3.595].stutter(1), inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 1.25,
    // \rate, -5.midiratio,
    \rate, Pseq([0, -5].midiratio.stutter(2), inf),
    \amp, 0.5,
    \lpf, 3000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1, 0.5]);
)