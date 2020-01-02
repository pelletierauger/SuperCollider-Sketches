
// un délice
(
// var f = 880 * 5.midiratio;
SynthDef.new(\pizzicato, {
    arg freq = 880, amp = 1, mult = 1, pan = 0;
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0.0125, 0], [0.01, 0.1, 2], [3, -3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    var env3 = Env.new([0, 1, 0], [0.0001, 0.025], [3, -7]).kr;
    var pEnv = Env.new([0.9, 1], [0.15], [3]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op4 = SinOsc.ar(f * 0.0625) * env3 * 10;
    var op3 = SinOsc.ar(f * 1, lfo * 12);
    var op2 = SinOsc.ar(f * 1, op4 * 12 + (op3 * 4) * (1 - env2)) * env2;
    var op5 = SinOscFB.ar(f * 0.25, 0.125) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001] * 0.5, op2 * mult + op4 + op5) * lfo * 0.1;
    var op6 = SinOsc.ar(f * 0.25) * 0.1;
    var sig = op1 + op6 * env * amp;
    sig = sig * LFTri.ar(f * 0.5).range(0.92, 1);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(0, sig);
}).add;
)

(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.2], inf),
    \freq, 440 * -2.midiratio *
    Pseq([19, 12, 14].stutter(30), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play();
)


(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.01, 0.15, 0.01, 2], inf),
    \freq, 220 * -2.midiratio *
    Pseq([19, 12, 14].reverse.stutter(4), inf).midiratio * Pseq([0, -5].midiratio.stutter(2), inf),
    \amp, 1,
    \mult, 0.95,
    \pan, Pseq([-0.9, 0.9], inf)
).play();
)


(
// G, B, D, F#
// G, A, E, F#
~shimmerD.stop;
~shimmerD = Pbind(
    \instrument, Pseq([\sampler], inf),
    \dur, 1 / 16 * 1,
    \spos, Pseq([0.55].stutter(64), inf) + Pwhite(0.0001, 0.00025, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [-12, 0].midiratio,
    \amp, 1,
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t2);
)