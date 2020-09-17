Server.local.options.sampleRate = 48000;


(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3");
f = 62 + 3 - 7;
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 0.25).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 0.25, pi).range(0.025, 0.85);
    var sig = MiBraids.ar(f - 12 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + (MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 6);
    sig = sig + (MiBraids.ar(f * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 2);
    // sig = sig + MiBraids.ar(f + 12 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    sig = LPF.ar(sig, 1000);
    sig = sig + (MiBraids.ar(f + 12 + 12 * [1, 1.001], lfo, lfo2, 4, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 1);
    sig = sig + (MiBraids.ar(f + 0 + 12 * [1, 1.001], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25);
    sig = sig + (MiBraids.ar(f + 2 + 12 * [1, 1.001], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25);
    sig = sig + (MiBraids.ar(f + 4 + 12 * [1, 1.001], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25);
    sig = sig + (MiBraids.ar(f - 1 + 12 * [0.998, 1], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25);
    sig = sig + (MiBraids.ar(f - 3 + 12 * [1.002, 1], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25);
    sig = sig + (MiBraids.ar(f - 3 + 12 * [1.001, 1.004] * 2, lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25);
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)
~drone.free;



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

s.stopRecording;

(
var n = 4 * 16 * 16;
var r = Pseries(0, 0.00001, n).asStream.nextN(n).mirror2;
// s.record;
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 14,
    \spos, Pseq([0.2545].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * 1.midiratio,
    \amp, Pseq(Pseries(2, -2/128, 128).asStream.nextN(128).reverse.mirror2, inf),
    \pan, Pwhite(-0.85, 0.85, inf),
    \out, 0
).play();
)
Pseries(2, -2/128, 128).asStream.nextN(128).reverse.mirror2.size
256 * (1/16)
140 / 14
140 secondes au total

(
var n = 4 * 16 * 16;
var r = Pseries(0, 0.00001, n).asStream.nextN(n).mirror2;
// s.record;
~shimmerCB.stop;
~shimmerCB = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 28 * Pseq([1].stutter(64) ++ 32, inf),
    \spos, Pseq([0.1].stutter(4 * 16), inf) + Pseq([0.7].stutter(28*2) * 1e-3, inf)
    + Pseq(Pseries(0, 0.0001, 16).asStream.nextN(16).stutter(4), inf),
    \rel, 0.2,
    \atk, 0.5,
    \rate, [1] * 4.midiratio * 0.5,
    \amp, Pseq(Pseries(2, -2/128, 128).asStream.nextN(128).reverse.mirror2 * 8, inf),
    \pan, Pwhite(-0.85, 0.85, inf),
    \out, 0
).play();
)

// très beau grésillement bas
(
var n = 4 * 16 * 16;
var r = Pseries(0, 0.00001, n).asStream.nextN(n).mirror2;
// s.record;
~shimmerCB.stop;
~shimmerCB = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 28 * Pseq([1].stutter(32) ++ 32, inf),
    \spos, Pseq([0.425].stutter(4 * 16), inf) + Pseq([0.7].stutter(28*2) * 1e-3, inf)
    + Pseq(Pseries(0, 0.0001, 16).asStream.nextN(16).stutter(4), inf),
    \rel, 0.2,
    \atk, 0.5,
    \rate, [1] * 4.midiratio * 0.5,
    \amp, Pseq(Pseries(2, -2/128, 128).asStream.nextN(128).reverse.mirror2 * 8, inf),
    \pan, Pwhite(-0.85, 0.85, inf),
    \out, 0
).play();
)




(
var n = 4 * 16 * 2;
var r = Pseries(0, 1 / n, n).asStream.nextN(n).mirror2;
~shimmerD.stop;
~shimmerD = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 16,
    \spos, Pseq([0.38].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * 1.midiratio,
    \amp, 2 * Pseq(r, inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
var n = 4 * 16 * 16;
Pseries(0, 1 / n, n).asStream.nextN(n)[n - 1]
)

s.record;
s.stopRecording;