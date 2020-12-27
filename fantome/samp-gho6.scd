t = TempoClock.new(122/60); t.permanent = true;

b = Buffer.read(s, "/Volumes/Volumina 1/fantomes/vibes-loop.wav");
b = Buffer.read(s, "/Volumes/Volumina 1/fantomes/vibes-loop-low.wav");
b = Buffer.read(s, "/Volumes/Volumina 1/fantomes/vibes-loop-low-long.wav");
b
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
