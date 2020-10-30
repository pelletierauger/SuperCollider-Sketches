s.options.memSize = 2.pow(16);

(
SynthDef(\samplerKarplusFog, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, pitch = 60, susT;
    var sig, sigB, sigC, env, lfo, env2;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], [-8, -8, -8]));
    env2 = EnvGen.kr(Env.new([0, 1, 0], [atk, 16], [-8, -8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // sig = HPF.ar(sig, filt);
    sig = CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [Rand(0.999, 1.001), Rand(0.999, 1.001)], 16) * 0.2 * env2;
    // sigB = CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [1.001, 1] * 1.001, 16) * 0.1 * env2;
    // sigC = CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [1.001, 1] * 0.999, 16) * 0.1 * env2;
    // sig = sig + sigB + sigC * 0.333;
    sig = 0 + (LPF.ar(sig, 440 * 4) * EnvGen.kr(Env.new([0, 1, 0], [10, 0.5], -4!3)) * 8);
    // sig = sig.round(2**(-7));
    // sig = sig.round(2**(-4));
    // sig = DelayC.ar(sig, 0.01, 0.01) * 0.5 * env2;
    // 3.do { |i| sig = DelayN.ar(RLPF.ar(sig, Rand(500, 1000), 0.03), 1, 1 / (2**i), 1, sig * 0.5) };

    // sig = (sig * 100).clip(-0.1, 0.1);
    sig = LPF.ar(sig, 440 * 3) * SinOsc.ar(Rand(3, 6)).range(0.25, 1);
    // sig = sig + ((sig * 10).clip(-0.1, 0.1) * 0.1);
    // sig = Disintegrator.ar(sig, probability: 0.5, multiplier: -0.5);
    Out.ar(out, sig);
}).add;
)
(Rand(1, 1.001))!2
60.midicps.reciprocal
{EnvGen.ar(Env.new([0, 1, 0], [8, 0.5] * 0.1, -8!3)).lag(1)}.plot(1)
(
~knockAKar.stop;
~knockAKar = Pbind(
    \instrument, \samplerKarplusFog,
    \buf, b,
    \dur, 4,
    \spos, Pseq([Rest(1), 0.3509], inf),
    \pitch, Pseq(48 + [0, -2].stutter(2) - 12, inf),
    \atk, 0.001,
    \susT, 1.25,
    \rel, 0.001,
    \rate, -5.midiratio,
    \rate, Pseq([-5, -3, -7, -5].stutter(1).midiratio, inf),
    \amp, Pseq([4], inf)
).play(~t, quant: [2, -0.06]);
)
(
~knockAKarA.stop;
~knockAKarA = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(48 + [0, -2].stutter(2) - 12, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \amp, Pseq([2], inf)
).play(~t, quant: [2, -0.06]);
)
)




(
~knockAKar2.stop;
~knockAKar2 = Pbind(
    \instrument, \samplerKarplusFog,
    \buf, b,
    \dur, 4,
    \spos, Pseq([Rest(1), 0.3509], inf),
    \pitch, Pseq(48 + [0, -2].stutter(2) - 12, inf) + 24,
    \atk, 0.001,
    \susT, 1.25,
    \rel, 0.001,
    \rate, -5.midiratio,
    \rate, Pseq([-5, -3, -7, -5].stutter(1).midiratio, inf),
    \amp, Pseq([16], inf)
).play(~t, quant: [2, -0.06]);
)