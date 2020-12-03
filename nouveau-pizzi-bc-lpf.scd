(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, filt = 4000, susT;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], [-8, -8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // sig = HPF.ar(sig, filt);
    // sig = CombL.ar(sig, 0.05, 48.midicps.reciprocal, 9) * 0.2;
    sig = LPF.ar(sig, filt) * 1.5;
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\samplerKarplus, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, pitch = 60, susT, filt = 4000;
    var sig, env, lfo, env2;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], [-8, -8, -8]));
    env2 = EnvGen.kr(Env.new([0, 1, 0], [atk, 16], [-8, -8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // sig = HPF.ar(sig, filt);
    sig = CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [1, 1.001], 16) * 0.2 * env2;
    // sig = LPF.ar(sig, filt) * 1.5;
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\samplerKarplusLPF, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0, pitch = 60, susT, filt = 4000;
    var sig, env, lfo, env2;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], [-8, -8, -8]));
    env2 = EnvGen.kr(Env.new([0, 1, 0], [atk, 16], [-8, -8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // sig = HPF.ar(sig, filt);
    sig = CombL.ar(sig, 0.05, pitch.midicps.reciprocal * [1, 1.001], 16) * 0.2 * env2;
    sig = LPF.ar(sig, filt) * 1.5;
    Out.ar(out, sig);
}).add;
)


(
~knockBKar.stop;
~knockBKar = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, Pseq([2, 1, 1], inf),
    \spos, Pseq([0.3509], inf),
    \pitch, Pseq(60 + [-5, 4, 2, 5, -3, 4, 2, 5].reverse + 0, inf),
    \atk, 0.001,
    \susT, 1.5,
    \rel, 0.001,
    \rate, -5.midiratio,
    \filt, 1000,
    \amp, 1
).play(~t, quant: [2, -0.06]);
)


(
~squeak.stop;
~squeak = Pbind(
    \instrument, \samplerKarplus,
    \buf, b,
    \dur, Pseq([Rest(2.5), 1.5], inf),
    \spos, Pseq([0.852], inf),
    \atk, 0.001,
    \susT, 0.55,
    \pitch, Pseq([60, 53].stutter(4), inf),
    \filt, 1000,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 2 * 0.75 * 3
).play(~t, quant: [2, -0.3 + 1]);
/*~squeak2.stop;
~squeak2 = Pbind(
    \instrument, \sampler,
    \buf, b,
    \dur, Pseq([Rest(2.5), 1.5], inf),
    \spos, Pseq([0.852], inf),
    \atk, 0.001,
    \susT, 0.55,
    \rel, 0.001,
    \rate, 0.midiratio,
    \amp, 0.65 * 0.75
).play(~t, quant: [2, -0.3 + 1]);*/
)