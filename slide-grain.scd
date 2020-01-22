~guitare = Buffer.read(s, "/Users/guillaumepelletier/Desktop/slide-0008-propre.wav");

(
// ~guitare = Buffer.read(s, "/Users/guillaumepelletier/Desktop/slide-0008.wav");
// ~guitare.numFrames;
// ~guitare.numChannels;
// 7144448/14400/2/60;
SynthDef(\accords, {
    arg buf = ~guitare, rate = 1, spos = 0, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
//     env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    // env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~guitare, rate * BufRateScale.ir(buf), startPos: spos * 4452881, doneAction: 2);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


(
~pattern.stop;
~pattern = Pbind(
    \instrument, \accords,
    \dur, 1/4,
    \spos, Pseq([0.1, 0.2, 0.3, 0.4].stutter(4) + 0.05, inf) + Pseq([Pseries(0, 0.01, 4)], inf),
    \rel, 0.2,
    \amp, 0.5,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)



(
~pattern2.stop;
~pattern2 = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.75].stutter(4) + 0.05, inf) + Pseq([Pseries(0, 0.001, 16)], inf),
    \rel, 0.2,
    \rate, 1,
    \amp, 0.1,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)

// beau
(
~pattern3.stop;
~pattern3 = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.38].stutter(4) + 0.05, inf) + Pseq([Pseries(0, 0.001, 32)], inf),
    \rel, 0.2,
    \rate, 1,
    \amp, 0.25,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)



(
~pattern3.stop;
~pattern3 = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.38].stutter(4) + 0.05, inf) + Pseq([Pseries(0, 0.001, 64)], inf)
     + Pwhite(0, 0.001, inf),
    \rel, 1,
    \rate, 1,
    \amp, 0.5,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)



(
~pattern3.stop;
~pattern3 = Pbind(
    \instrument, \accords,
    \dur, 1/4,
    \spos, Pseq([0.38, 0.1].stutter(1) + 0.05, inf) + Pseq([Pseries(0, 0.001, 16)], inf),
    \rel, 0.2,
    \rate, 1,
    \amp, 0.25,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)
