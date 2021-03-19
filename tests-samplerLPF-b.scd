
~t = TempoClock.new(80/60).permanent_(true);

(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
c.plot;
c.play;
(
~guitareB.stop;
~guitareB = Pbind(
    \instrument, \sampler,
    \buf, c,
    \dur, 2,
    \spos, Pseq([0.1035], inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 2,
    \rate, 0.5,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 4 * 1,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)

(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, \sampler,
    \buf, c,
    \dur, 4,
    \spos, Pseq([0.14], inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 3,
    \rate, -5.midiratio,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 4 * 1,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [0.5]);
)

(
~guitareB.stop;
~guitareB = Pbind(
    \instrument, \samplerKarplusLPF,
    \buf, b,
    \dur, 4,
    \spos, Pseq([0.1105], inf),
    // \rel, 1.5,
    // \atk, 0.5,
    \susT, 1,
    \rate, 6.midiratio,
    \pitch, 50,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 4,
    \filt, 8000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)