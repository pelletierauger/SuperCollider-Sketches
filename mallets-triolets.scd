s.boot;

(
SynthDef(\pulse, {
    arg freq = 440, pan = 0, out = 0, amp = 1, sus = 0.125, atk = 0.001;
    var sig, sig2, sig3, env, env2;
    sus = sus * (220 / freq);
    sig = Impulse.ar(1, mul: 0.4)!2;
    sig2 = LFTri.ar([freq, freq + 1]) * 0.9;
    sig3 = LFTri.ar([freq, freq + 1] * 2) * 0.9;
    env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [atk, sus * 1.5, 2]), doneAction: 2);
    env2 = EnvGen.kr(Env.new([0, 1, 0], [atk, sus * 0.1]));
    sig = sig + sig2 * sig3 * env2;
    sig = sig * 4.0 + Ringz.ar(sig, [freq, freq + 2], sus);
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)

Synth.new(\pulse, [\freq, 10, \sus, 0.4, \amp, 0.05]);
s.meter;
(
~key = ~toFreq.("Db4");
u.stop;
u = Pbind(
    \instrument, \pulse,
    \dur, Pseq([0.125] * 1, inf),
    \freq, Pseq(~key * -5.midiratio * [0, 7].stutter(4).midiratio, inf) * Pseq([2, 4].stutter(8), inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \amp, Pseq([Pgeom(0.025, 0.65, 4)], inf),
    \sus, 0.15,
    \out, 0
).play(quant: [0.5, 0.25]);
w.stop;
w = Pbind(
    \instrument, \pulse,
    \dur, Pseq([0.25] * 1, inf),
    \freq, Pseq(~key * [0, 4, 7].stutter(4).midiratio, inf) * Pseq([0.5, 1].stutter(10), inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \amp, Pseq([Pgeom(0.025, 0.65, 4)], inf),
    \sus, 0.15,
    \out, 0
).play(quant: 0.5);
t.stop;
t = Pbind(
	\instrument, \fm,
	\dur, Pseq([1, 1, 6], inf),
    \freq, ~key * Pseq([[0, 4, 7, 11, -12]], inf).midiratio * [0.5, 1, 2, 4],

    // \freq, 329.63 * -14.midiratio * Pseq([11, 7, 4, 9, 5, [-2, 2, -10]], inf).midiratio * [1, 2, 3, 4, 8],
    // \freq, 329.63 * -10.midiratio * Pseq([10, 7, 3, 12, 7, [0, 3, -12]], inf).midiratio * [1, 2, 3],
    \amp, 330 * 0.0625 * 0.35,
    \sus, 8,
    \freqMod, Pwhite(0.9, 1.1, inf),
    \pan, Pwhite(-0.5, 0.5, inf)
).play;
v.stop;
v = Pbind(
    \instrument, \pulse,
    \dur, Pseq([1, 0.5] * 1, inf),
    \freq, Pseq(~key * [4, 0].stutter(4).midiratio, inf) * Pseq([1].stutter(10), inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \amp, Pseq([Pgeom(0.015, 0.65, 4)], inf),
    \sus, 0.5,
    \out, 0
).play(quant: 0.5);
~v2.stop;
~v2 = Pbind(
    \instrument, \pulse,
    \dur, Pseq([1, 0.5] * 0.25 * 2 / 3, inf),
    \freq, Pseq(~key * [-5, 0].stutter(8).midiratio, inf) * Prand([1, 2, 4, 8].stutter(8), inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \amp, Pseq([Pgeom(0.025, 0.65, 8)], inf),
    \sus, 0.5,
    \out, 0
).play(quant: 0.75);
)