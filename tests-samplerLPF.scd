b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dehors/longue-note.wav");



(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
(
SynthDef(\samplerLPF, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0, lpf = 4000;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    sig = LPF.ar(sig, lpf);
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\samplerLPFFlip, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0, lpf = 4000;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    sig = LPF.ar(sig, lpf);
    Out.ar(out, sig);
}).add;
)

(
~guitareA.stop;
~guitareA = Pbind(
    \instrument, \samplerLPF,
    \instrument, Pseq([\samplerLPF, \samplerLPFFlip], inf),
    \buf, b,
    \dur, Pseq(0!4 ++ 8, inf),

    \dur, 8,
    // \spos, Pseq([0.42], inf),
    \rel, 1.5,
    \susT, 5,
    // \atk, 0.5,
    // \rate, Pseq(([-5, 0, 2, 4] - 2).midiratio, inf),
    \rate, -7.midiratio,
    \amp, 6,
    // \lpf, 2000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~t, quant: [1]);
)
