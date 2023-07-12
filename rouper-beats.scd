(
var dir = "/Volumes/Volumina/Clouds/Clouds - Sample Pack 005/Mangled Beats & Loops/";
var sf = PathName.new(dir);
~mangled = [];
sf.entries.do({| path, i |
    ~mangled = ~mangled.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~mangled.size;
)

~mangled[2].play
~mangled[10].path

~mangled[26].play

~mangled[26].duration


(
SynthDef(\samplerStereoEnv, {
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
    Out.ar(out, sig);
}).add;
)
~mangled[26].play
~mangled[26].duration / 16
~mangled[26].path.openOS
~nT.tempo = (~mangled[26].duration / 16).reciprocal;
~nT.tempo = (~mangled[26].duration / 16).reciprocal;
~nT.tempo

(
~m.stop;
~m = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([1], inf),
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * 0,
    \sus, ~mangled[26].duration / 16,
    \amp, Pseq([1], inf)
).play(~nT, quant: 2);
)

(
~m.stop;
~m = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([4], inf),
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * 4,
    \sus, ~mangled[26].duration / 4,
    \amp, Pseq([1], inf)
).play(~nT, quant: 2);
)

// ----- Celui-ci ---------

(
~m.stop;
~m = Pbind(
    \instrument, \samplerStereoEnvWarps,
    \dur, Pseq([4], inf),
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * 2,
    \sus, ~mangled[26].duration / 4,
    \amp, Pseq([0.25], inf)
).play(~nT, quant: 2);
)

(
~n.stop;
~n = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([2], inf),
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * 0,
    \sus, ~mangled[26].duration / 16 * 1.75,
    \amp, Pseq([0.4], inf)
).play(~nT, quant: 2);
)

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[29],
    \amp, Pseq([0.65, 0.25, 0.5, 0.25] * 0.5, inf) * 2
).play(~nT, quant: 2);
)

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[13],
    \rate, 4,
    \amp, Pseq([0.65, 0.25, 0.5, 0.25] * 0.5, inf) * 1
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
        sig, DelayN.ar(sig, 1, 1/128/2), lev1: 0.25, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.5;
    Out.ar(out, sig);
}).add;
)


(
SynthDef(\samplerStereoEnv, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0.001, sus = 1/16, rel = 0.001;
    var env = EnvGen.kr(Env([0,1,1,0], [atk, sus, rel], [-8]), doneAction: 2);
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * env * amp;
    (rate * BufRateScale.ir(buf)).poll;
    sig = Pan2.ar(sig, pan);
    sig = ~v.(sig, 1000);
    Out.ar(out, sig);
}).add;
)

(
~m.stop;
~m = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Prand([1,2,3,4, 0.5, 0.75], inf),
    \buf, ~mangled[26],
    \spos, ~mangled[26].duration / 16 * Prand([0, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12], inf),
    \sus, ~mangled[26].duration / Pkey(\dur, inf),
    \amp, Pseq([0.5], inf)
).play(~nT, quant: 2);
)

(
var dir = "/Volumes/Volumina/Clouds/Clouds - Sample Pack 005/Kick/";
var sf = PathName.new(dir);
~fX = [];
sf.entries.do({| path, i |
    ~fX = ~fX.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~fX.size;
)
n = 8;
(
~fX[n].play;
n = n + 1;
)


(
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.98 * 0.5), 1.02 * 0.5] * 2, inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~snares[20],
    \amp, Pseq([1], inf)
).play(~nT, quant: 2);
)
