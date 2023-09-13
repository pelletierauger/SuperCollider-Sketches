~mangled[48].duration
~mangled[61].duration

~mangled[60].play

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([4], inf),
    \buf, ~mangled[48],
    \spos, ~mangled[48].duration / 16 * 8,
    \sus, ~mangled[48].duration / 8 * 4,
    \amp, Pseq([0.4], inf)
).play(~nT, quant: 2);
)


(
var dur = 2;
~n.stop;
~n = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([2], inf),
    \atk, 0,
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * 12,
    \sus, ~mangled[26].duration / 16 * dur * 0.99 * 0.75,
    \amp, Pseq([0.24], inf)
).play(~nT, quant: 2);
)


(
var dur = 2;
~n.stop;
~n = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([1], inf),
    \atk, 0,
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * 12,
    \sus, ~mangled[26].duration / 16 * dur * 0.99 * Pseq([0.25, 0.25], inf),
    \amp, Pseq([0.4], inf)
).play(~nT, quant: 2);
)



(
var dur = 2;
~n.stop;
~n = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([1, 0.5, 0.5], inf),
    \atk, 0,
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * Pseq([0, 12, 6], inf),
    \sus, ~mangled[26].duration / 16 * dur * 0.99 * Pseq([0.5, 0.25, 0.25], inf),
    \amp, Pseq([0.4], inf)
).play(~nT, quant: 2);
)
(
~m.stop;
~m = Pbind(
    \instrument, \samplerStereoEnvWarps,
    \dur, Pseq([4], inf),
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * 4,
    \sus, ~mangled[26].duration / 16 * 4 * 0.99,
    \amp, Pseq([0.25], inf)
).play(~nT, quant: 2);
)

(
~m.stop;
~m = Pbind(
    \instrument, \samplerStereoEnvWarps,
    \dur, Pseq([8], inf),
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * 4,
    \sus, ~mangled[26].duration / 16 * 8,
    \amp, Pseq([1], inf)
).play(~nT, quant: 2);
)


(
SynthDef(\samplerStereoEnvWarps, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0.001, sus = 1/16, rel = 0.001;
    var env = EnvGen.kr(Env([0,1,1,0], [atk, sus, rel], [-8]), doneAction: 2);
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * env * amp;
    // (rate * BufRateScale.ir(buf)).poll;
    sig = Pan2.ar(sig, pan);
                sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128/2), lev1: 0.5, lev2: 0.5,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    Out.ar(out, sig);
}).add;
)