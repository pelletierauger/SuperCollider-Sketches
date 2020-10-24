b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0001 7-Audio.aif");
b.numFrames;
b.numChannels

// Store the values from the Buffer in a FloatArray called ~fl
~buf.loadToFloatArray(action: { arg array; ~fl = array;});
// Evaluate ~fl and confirm that it is a FloatArray.
~fl;
~fl.size;

(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

~t = TempoClock.new(80/60);

(
~guitareA.stop;
~guitareA = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 2,
    \spos, Pseq([0.42], inf),
    \rel, 1.5,
    \atk, 0.5,
    \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 4 * 4 * 2,
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)


(
~guitareB.stop;
~guitareB = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, 0.25,
    \spos, Pseq([0.2, 0.195], inf),
    \spos, Pseq([0.195 * 2], inf),
    \rel, 0.1,
    \atk, 0.001,
    \rate, -7.midiratio,
    \amp, Pseq([8, 4] * 4, inf),
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