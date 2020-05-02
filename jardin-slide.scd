// -----------------------
(
t = TempoClock.new;
t.tempo_(50/60);
t.permanent = true;
~guitare = Buffer.read(s, "/Users/guillaumepelletier/Desktop/slide-0008.wav");
~guitare.numFrames;
SynthDef(\guitare, {
    arg buf = ~guitare, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~guitare, rate * BufRateScale.ir(buf), startPos: spos * 4452881);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare,
    \dur, 1,
    \spos, Pseq([0.1].stutter(4 * 16), inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, 1,
    \amp, 4,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
~shimmerD.stop;
~shimmerD = Pbind(
    \instrument, \guitare,
    \dur, 0.5,
    \spos, Pseq([0.29, 0.21].stutter(8), inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, 1,
    \amp, 1,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
~shimmerE.stop;
~shimmerE = Pbind(
    \instrument, \guitare,
    \dur, 0.25,
    \spos, Pseq([0.43].stutter(8), inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1],
    \amp, 0.5,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
~shimmerF.stop;
~shimmerF = Pbind(
    \instrument, \guitare,
    \dur, 0.5,
    \spos, Pseq([0.555].stutter(8), inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1],
    \amp, 1,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)