(
~guitare = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec Caroline Project/Samples/Recorded/0005 Guitare.aif");
~guitare.numFrames;
~guitare.numChannels;
7144448/14400/2/60;
SynthDef(\accords, {
    arg buf = ~guitare, rate = 1, spos = 0, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
//     env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    // env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~guitare, rate * BufRateScale.ir(buf), startPos: spos * 1615360, doneAction: 2);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

~guit = Synth.new(\accords, [\spos, 0.1, \amp, 0.1]);
~accordsfinaux.set(\gate, 0);


(
~pattern.stop;
~pattern = Pbind(
    \instrument, \accords,
    \dur, 1/4,
    \spos, Pseq([0.1, 0.2, 0.3, 0.4] + 0.05, inf),
    \rel, 0.2,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)

(
~patternB.stop;
~patternB = Pbind(
    \instrument, \accords,
    \dur, 1/4,
    \spos, Pseq([0.6, 0.61, 0.64, 0.67], inf) - Pseq([0.1, 0.2].stutter(8), inf) - 0.2,
    \rel, 0.25,
    \rate, 0.midiratio,
    \amp, 3,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)

(
~pattern3.stop;
~pattern3 = Pbind(
    \instrument, \accords,
    \dur, 1/32,
    \spos, Pseq([0.41], inf),
    \rel, 0.05,
    \rate, 0.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)



(
~pattern.stop;
~pattern = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.13].stutter(8), inf) + 0 + Pseq([Pseries(0, 0.001, 8)], inf),
    \rel, 0.2,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)

(
~pattern2.stop;
~pattern2 = Pbind(
    \instrument, \accords,
    \dur, 1/128 * 1,
    \spos, Pseq([0.25, 0.45].stutter(1), inf) + 0.2
    + Pseq(Pseries(0, 0.001, 16).asStream.nextN(16).mirror2.stutter(32), inf)
    + Pwhite(-0.001, 0.001, inf),
    \rel, 0.0625 * 8,
    \amp, 2,
    \rate, Pseq([0, 7, -5].midiratio, inf),
    \pan, Pwhite(-1.0, 1.0, inf)
).play();
)


(
~pattern.stop;
~pattern = Pbind(
    \instrument, \accords,
    \dur, 1/8,
    \spos, Pseq([0.1, 0.13].stutter(16), inf) + 0 + Pseq([Pseries(0, 0.001, 16)], inf),
    \rel, 0.2,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf)
).play();
)

(
~pattern.stop;
~pattern = Pbind(
    \instrument, \accords,
    \dur, 1/16 * 2,
    \spos, Pseq([0.03, 0.1].stutter(32 * 4), inf) + 0.1
    + Pseq(Pseries(0, 0.0005, 32).asStream.nextN(32).mirror2.stutter(4), inf),
    \rel, 0.2,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t);
)