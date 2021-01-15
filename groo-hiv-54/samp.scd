
(
t = TempoClock.new(122/60); t.permanent = true;
// b = Buffer.read(s, "/Volumes/Volumina 1/fantomes/vibes-loop-low.wav");
y = Buffer.read(s, "/Volumes/Volumina/fantomes/6-abeille.wav");
~softPluckA = Buffer.read(s, "/Volumes/Volumina/fantomes/6-samples/soft-pluck-a.wav");
~softPluckB = Buffer.read(s, "/Volumes/Volumina/fantomes/6-samples/soft-pluck-b.wav");
~softPluckC = Buffer.read(s, "/Volumes/Volumina/fantomes/6-samples/soft-pluck-c.wav");
~scratch = Buffer.read(s, "/Volumes/Volumina 1/fantomes/6-samples/gratt.wav");
~oneHit = Buffer.read(s, "/Volumes/Volumina 1/fantomes/6-samples/vib-one-hit.wav");
~chillScratch = Buffer.read(s, "/Volumes/Volumina/fantomes/6-samples/chill-scratch.wav");
)

b = Buffer.read(s, "/Volumes/Volumina 1/fantomes/vibes-loop.wav");
b = Buffer.read(s, "/Volumes/Volumina 1/fantomes/vibes-loop-low-long.wav");
b.numFrames

(
SynthDef(\sampler, {
    arg buf, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, susT = 0.1;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env;
    sig = sig * amp;
    sig = LPF.ar(sig, 6000) * 1.1;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\samplerBee, {
    arg buf, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, susT = 0.1;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env;
    sig = sig * amp;
    // sig = LPF.ar(sig, 6000) * 1.1;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\samplerBeeFlip, {
    arg buf, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, susT = 0.1;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env;
    sig = sig * amp;
    // sig = LPF.ar(sig, 6000) * 1.1;
    sig = [sig[1], sig[0]];
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

b.duration

(
~shimmer.stop;
~shimmer = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    \dur, 8,
    \spos, 0,
    \rel, 0.1,
    \atk, 0.001,
    \susT, b.duration,
    \rel, 0.001,
    \rate, 1,
    \amp, 1,
    \pan, 0,
    \out, 0,
    \buf, b
).play(t, quant: [8, 0]);
)


(
~hit.stop;
~hit = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    // \dur, Pseq([Rest(8*2), Rest(3.5), 1, Rest(3.5), Rest(8)], inf),
    \dur, Pseq([Rest(8), Rest(3.5), 1, Rest(3.5)], inf),
    \spos, 0,
    \rel, 0.1,
    \atk, 0.001,
    \susT, 1,
    \rel, 0.001,
    \rate, 1,
    \amp, 0.8,
    \pan, 0,
    \out, 0,
    \buf, ~oneHit
).play(t, quant: [8, 0]);
)

(
SynthDef(\sampler, {
    arg buf, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, susT = 0.1;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    lfo = SinOsc.kr(12).range(0.25, 1);
    // sig = sig + (LPF.ar(Decimator.ar(sig, bits: 2), 1500) * lfo * 0.2);
    sig = MiMu.ar(MiMu.ar(sig, 40), 120) * 0.0625;
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~bee.stop;
~bee = Pbind(
    // \instrument, \samplerBee,
    \instrument, Pseq([\samplerBee, \samplerBeeFlip], inf),
    // \dur, 8 / (122/60),
    \dur, 5 * 4,
    \spos, 0.0125,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, y.duration - 4,
    \rel, 2,
    \rate, 1,
    \amp, 0.85,
    \pan, 0,
    \out, 0,
    \buf, y
).play(~nT, quant: [5, 0]);
)



(
~sPA.stop;
~sPA = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    \dur, Pseq([2, 1, 1, 1], inf),
    \spos, 0,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 0.4 * 2,
    \rel, 0.001,
    \rate, 0.5 * -2.midiratio,
    \amp, 1.2,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
     \buf, Pseq([~softPluckA, ~softPluckB, ~softPluckB, ~softPluckB], inf)
).play(~nT, quant: [5, 0]);
)

(
~sPB.stop;
~sPB = Pbind(
    \instrument, \samplerBee,
    // \dur, 8 / (122/60),
    \dur, Pseq([Rest(1), 1, 0.5, 1.5], inf),
    \spos, 1,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 1,
    \rel, 0.001,
    \rate, -1,
    \amp, 0.5,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
     \buf, Pseq([~softPluckA, ~softPluckA, ~softPluckB, ~softPluckB], inf)
).play(t, quant: [2, 0]);
)

(
~sPA.stop;
~sPA = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 0.4 * 1,
    \rel, 0.001,
    \rate, 1 * Pseq([-5].midiratio.stutter(20), inf),
    \amp, Pseq([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 1,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
     \buf, Pseq([~softPluckA], inf)
).play(~nT, quant: [5, 0]);
)

(
// [1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0];
~sPC.stop;
~sPC = Pbind(
    // \instrument, \samplerBee,
    \instrument, Pseq([\samplerBeeFlip, \samplerBee], inf),
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0.05,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 1,
    \rel, 0.001,
    \rate, 1 * -2.midiratio,
    \amp, Pseq([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
    // \buf, Pseq([~softPluckA, ~softPluckA, ~softPluckB, ~softPluckB], inf)
).play(~nT, quant: [5, 0]);
)



(
[1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0];
~sPD.stop;
~sPD = Pbind(
    // \instrument, \samplerBee,
    \instrument, Pseq([\samplerBeeFlip, \samplerBee], inf),
    // \dur, 8 / (122/60),
    // \dur, 1 / 4,
    \dur, Pseq([Rest(1), 1, Rest(1), 2], inf),
    \spos, 0.4,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 0.5,
    \rel, 0.001,
    \rate, 1 * -2.midiratio,
    \amp, 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
    // \buf, Pseq([~softPluckA, ~softPluckA, ~softPluckB, ~softPluckB], inf)
).play(~nT, quant: [5, 0]);
)




(
[c, u, v].do({|i| i.set(\gate, 0, \fadeTime, 1)});
~shimmer.stop;
~bee.stop;
~sPA.stop;
~sPB.stop;
~sPB = Pbind(
    \instrument, \samplerBee,
    // \dur, 8 / (122/60),
    \dur, 8,
    \spos, 0,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, ~scratch.duration - 0.1,
    \rel, 0.001,
    \rate, 1,
    \amp, 1.5,
    \pan, 0,
    \out, 0,
     \buf, ~scratch
).play(t, quant: [2, 0]);
)

(
[h, z].do({|i| i.set(\gate, 0, \fadeTime, 30)});
x.free;
x = {
    var trig = Impulse.kr(0.5);
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.99], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 48!2 - 36,
        timbre: 0.5 + lfo,
        color: 0.0 + dem2,
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0
    );
    sig = LPF.ar(sig, 2000);
    // sig = LPF.ar(sig, 2000) * env;
    // sig = sig + (LPF.ar(CombL.ar(sig, 0.05, (notes + 0).midicps.reciprocal, 4), 1000) * 0.4);
    sig * 0.75 * 0.5 * 0.4 * 2;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play(fadeTime: 30);
)


(
~chill.stop;
~chill = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    // \dur, Pseq([Rest(8*2), Rest(3.5), 1, Rest(3.5), Rest(8)], inf),
    \dur, Pseq([3, 2], inf),
    \spos, 0,
    \rel, 0.1,
    \atk, 0.001,
    \susT, ~chillScratch.duration - 0.002,
    \rel, 0.001,
    \rate, 1,
    \amp, 1.5,
    \pan, 0,
    \out, 0,
    \buf, ~chillScratch
).play(~nT, quant: [5, 0]);
)

~chillScratch.duration