
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/desa1.wav");
b = Buffer.read(s, "/Users/guillaumepelletier/Downloads/Recorded/Recorded/0001 7-Audio-1.aif")
b.numFrames;

(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(buf), startPos: spos * 6504960);
    sig = sig * env;
    sig = sig * amp;
    // sig = sig!2;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


~t2 = TempoClock.new;
~t2.tempo_(50/60);
~t2.permanent = true;
(
// G, B, D, F#
// G, A, E, F#
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler], inf),
    \dur, 1 / 16 * 1,
    \spos, Pseq([0.4, 0.42, 0.46].stutter(64), inf) + Pwhite(0.001, 0.0001, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0].midiratio,
    \amp, 1,
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t2);
)

(
// G, B, D, F#
// G, A, E, F#
~shimmerD.stop;
~shimmerD = Pbind(
    \instrument, Pseq([\sampler], inf),
    \dur, 1 / 16 * 1,
    \spos, Pseq([0.55].stutter(64), inf) + Pwhite(0.001, 0.0001, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0].midiratio,
    \amp, 2,
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t2);
)


(
~bard.stop;
~bard = Pbind(
    \instrument, \bardane,
    \dur, Pseq([4], inf),
    \freq, 880 * -14.midiratio * Pseq([2, -1, -5], inf).midiratio * [1]
).play(quant: [2]);
)
