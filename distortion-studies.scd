(
SynthDef(\samplerAbsLPF, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0, lpf = 4000;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 0);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    sig = LPF.ar(sig, lpf);
    sig = sig.clip(-0.1, 0.1) * 4;
    sig = CombC.ar(in: sig,
    maxdelaytime: 0.5,
    delaytime: [0.01],
    decaytime: 4,
    mul: 1, add: 0) * env;

    sig = sig.clip(-0.025, 0.025) * 2;
    sig = LPF.ar(sig, 2000) * 4;
    sig = sig.clip(-0.025, 0.025) * 2;
    sig = LPF.ar(sig, 2000) * 4;
    sig = sig.clip(-0.025, 0.025) * 2;
    sig = LPF.ar(sig, 2000) * 4;
    sig = sig.clip(-0.025, 0.025) * 2;
    sig = LPF.ar(sig, 2000) * 4;
    sig = sig.clip(-0.0125, 0.0125) * 4;
    sig = LPF.ar(sig, 2000) * 4 * 0.5;
    sig = ~part.(sig);
    Line.kr(0, 1, 4, doneAction: 2);
    Out.ar(out, sig);
}).add;
)

(
~part = {
    |in|

    LPF.ar(in.clip(-0.0125, 0.0125), 2000);
};
)


(
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 2 / 3 * 4,
    \spos, Pseq([90.894], inf),
    \lpf, 10000,
    \rel, 2,
    \susT, 0.25,
    \rate, Pseq([0].stutter(3).midiratio, inf),
    \amp, Pseq([2, 1, 1] * 4, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
)



(
SynthDef(\samplerAbsLPF, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0, lpf = 4000;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 0);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    sig = LPF.ar(sig, lpf);
    sig = sig.clip(-0.1, 0.1) * 4;
    sig = CombC.ar(in: sig,
    maxdelaytime: 0.5,
    delaytime: [0.01],
    decaytime: 4
    ) * env;

    sig = sig.clip(-0.025, 0.025) * 2;
    sig = LPF.ar(sig, 2000) * 4;
    sig = sig.clip(-0.025, 0.025) * 2;
    sig = LPF.ar(sig, 2000) * 4;
    sig = sig.clip(-0.025, 0.025) * 2;
    sig = LPF.ar(sig, 2000) * 4;
    sig = sig.clip(-0.025, 0.025) * 2;
    sig = LPF.ar(sig, 2000) * 4;
    sig = sig.clip(-0.0125, 0.0125) * 4;
    sig = LPF.ar(sig, 2000) * 4 * 0.5;
    sig = ~part.(sig) * 16;
    Line.kr(0, 1, 4, doneAction: 2);
    Out.ar(out, sig);
}).add;
)

(
~part = {
    |in|

    LPF.ar(in.clip(-0.0125, 0.0125), 1000);
};
)


(
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 2 / 3 * 4,
    \spos, Pseq([90.894], inf),
    \lpf, 10000,
    \rel, 2,
    \susT, 0.25,
    \rate, Pseq([0, 0, 0].stutter(1).midiratio, inf),
    \amp, Pseq([0.5, 1] * 4, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
)


