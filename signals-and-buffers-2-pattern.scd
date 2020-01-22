
b.numFrames;
(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(buf), startPos: spos * 1103254);
    sig = sig * env;
    sig = sig * amp;
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
    \instrument, \sampler,
        \dur, Pseq([0.5, 0.25, 0.25], inf),
    \spos, Pseq([0.45, 0.6, 0.25] + 0.2, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq([0, -5].midiratio.stutter(6), inf),
    \amp, 1.5,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t2);
)

(
// G, B, D, F#
// G, A, E, F#
~shimmerD.stop;
~shimmerD = Pbind(
    \instrument, \sampler,
        \dur, Pseq([0.5, 0.25, 0.25], inf),
    \spos, Pseq([0.45, 0.6, 0.25] + 0.05, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq([0, -12].midiratio.stutter(6) * 2, inf),
    \amp, 0.5,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t2);
)