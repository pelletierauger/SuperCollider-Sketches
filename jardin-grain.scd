

// -----------------------
(
// t = TempoClock.new;
// t.tempo_(50/60);
// t.permanent = true;
~guitare2 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/0001\ 7-Audio.aif");
SynthDef(\guitare2, {
    arg buf = ~guitare2, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~guitare2, rate * BufRateScale.ir(buf), startPos: spos * 7144448);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)



(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 16,
    \spos, Pseq([0.58, 0.2545].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * 1.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 16,
    \spos, Pseq([0.58, 0.2545].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * -2.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)


(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 16,
    \spos, Pseq([0.614, 0.38].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * -2.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)
// ambient : 0.382
(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 16,
    \spos, Pseq([0.382].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * -5.midiratio * Pseq([-5, 0].stutter(4 * 16).midiratio, inf),
    \amp, Pseq([2, 2].stutter(4 * 16), inf) * 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play();
)