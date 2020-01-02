(
~pizBas.stop;
~pizBas = Pbind(
    \instrument, \pizzicato_bas,
    \dur, Pseq([0.4], inf),
    \freq, 110 * -2.midiratio *
    Pseq([19, 12, 14].stutter(30), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(30) * 0.75, inf) * 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play();
)

(
// var f = 880 * 5.midiratio;
SynthDef.new(\pizzicato_bas, {
    arg freq = 880, amp = 1, mult = 1, pan = 0;
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0.0125, 0], [0.025, 0.1, 2], [3, -3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.001, 4], [3, -7]).kr;
    var env3 = Env.new([0, 1, 0], [0.0001, 0.025], [3, -7]).kr;
    var pEnv = Env.new([0.9, 1], [0.15], [3]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op4 = SinOsc.ar(f * 0.0625) * env3 * 10;
    var op3 = SinOsc.ar(f * 1, lfo * 12);
    var op2 = SinOsc.ar(f * 1, op4 * 12 + (op3 * 4) * (1 - env2)) * env2;
    var op5 = SinOscFB.ar(f * 0.25, 0) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001] * 1, op2 * mult + op4 + op5) * lfo * 0.1;
    var op6 = SinOsc.ar(f * 0.25) * 0.1;
    var sig = op1 + op6 * env * amp;
    sig = sig * LFTri.ar(f * 0.25).range(0.5, 1);
    sig = sig + LPF.ar(((sig * 1000).clip(0, 1) * env * 0.25) * amp, 200);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(0, sig);
}).add;
)

~t1 = TempoClock(80/60);
~t1.permanent = true;

(
~pizBas.stop;
~pizBas = Pbind(
    \instrument, \pizzicato_bas,
    \dur, Pseq([0.5], inf),
    \freq, 440 * -2.midiratio *
    Pseq([19, 12, 14, 12].stutter(1), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 4).asStream.nextN(4) * 0.75, inf) * 0.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
)

(
~pizBas2.stop;
~pizBas2 = Pbind(
    \instrument, \pizzicato_bas,
    \dur, Pseq([4], inf),
    \freq, 220 * -2.midiratio *
    Pseq([19 - 12].stutter(1), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 4).asStream.nextN(4) * 0.75, inf) * 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [4]);
)

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzicato_haut,
    \dur, Pseq([0.125], inf),
    \freq, 880 * -2.midiratio *
    Pseq([16, 12, 14].stutter(64), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.95, 64).asStream.nextN(64).reverse * 0.75, inf) * 0.65,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
)

(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.25], inf),
    \freq, 440 * -2.midiratio *
    Pseq([19, 12, 14].stutter(32), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 32).asStream.nextN(32) * 0.75, inf) * 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
)


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
    \amp, 0.5,
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t2);
)