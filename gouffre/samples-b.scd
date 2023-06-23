(
var dir = thisProcess.nowExecutingPath.dirname +/+ "samples";
var sf = PathName.new(dir);
~samples = [];
sf.entries.do({| path, i |
    ~samples = ~samples.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~samples.size;
)


(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([4], inf),
    \spos, 1.782,
    \spos, 3.46,
    \atk, 0.01, \dec, 0, \susT, ~nT.beatDur * 4, \rel, 0.01,
    \buf, ~samples[0],
    \amp, Pseq([0.65] * 0.5, inf) * 0.5
).play(~nT, quant: 2);
)

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([0, 4], inf),
    \spos, Pseq([1.782, 3.46], inf),
    \spos, Pseq([5.155, 3.46], inf),
    // \spos, ,
    \atk, 0.01, \dec, 0, \susT, ~nT.beatDur * 4, \rel, 0.01,
    \buf, ~samples[0],
    \pan, Pseq([-1.0, 1.0] * 0.5, inf),
    \amp, Pseq([0.65] * 0.5, inf) * 4
).play(~nT, quant: 2);
)

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([0, 4], inf),
    \spos, Pseq([1.782, 3.46], inf),
    \spos, Pseq([5.155, 3.46], inf),
    //\rate, 0.5,
    // \spos, ,
    \atk, 0.1, \dec, 0, \susT, ~nT.beatDur * 4, \rel, 0.1,
    \buf, ~samples[0],
    \pan, Pseq([-1.0, 1.0] * 0.5, inf),
    \amp, Pseq([0.65] * 0.5, inf) * 4
).play(~nT, quant: 2);
)
(
~h.stop;
~h = Pbind(
    \instrument, Prand([\samplerStereoEnvDel, \samplerStereoEnv], inf),
    \dur, Pseq([0, 4], inf),
    \spos, Pseq([1.782, 3.46], inf),
    \spos, Pseq([5.155, 3.46], inf),
    //\rate, 0.5,
    // \spos, ,
    \atk, 0.1, \dec, 0, \susT, ~nT.beatDur * 4, \rel, 0.1,
    \buf, ~samples[0],
    \pan, Pseq([-1.0, 1.0] * 0.5, inf),
    \amp, Pseq([0.65] * 0.5, inf) * 4
).play(~nT, quant: 2);
)
(
~n.stop;
~n = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([4], inf),
    \rate, Pseq([-5, -5, 0, -2].midiratio, inf),
    \spos, 0.05,
    \buf, ~samples[1],
    \amp, Pseq([0.65] * 1, inf) * 2
).play(~nT, quant: [1,  -0.05]);
)



~samples[0].play

(
SynthDef(\samplerStereoEnv, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0.1, dec = 0.1, sus = 1, susT = 0.1, rel = 0.1;
    var env = EnvGen.kr(Env([0, 1, sus, sus, 0], [atk, dec, susT, rel], [0, -8, -8, -8]), doneAction: 2);
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp * env;
    // sig = ~v.(sig, 1000);
    sig = Balance2.ar(sig[0], sig[1], pan);
    Out.ar(out, sig);
    // Out.ar(~distBus, sig * 4);
}).add;
)

(
SynthDef(\samplerStereoEnv, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0.1, dec = 0.1, sus = 1, susT = 0.1, rel = 0.1;
    var env = EnvGen.kr(Env([0, 1, sus, sus, 0], [atk, dec, susT, rel], [0, -8, -8, -8]), doneAction: 2);
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp * env;
    // sig = ~v.(sig, 1000);
    sig = Balance2.ar(sig[0], sig[1], pan);
    sig = ~v.(sig, 1000, 0, 1) * 1;
    Out.ar(out, sig);
    // Out.ar(~distBus, sig * 4);
}).add;
)


(
SynthDef(\samplerStereo, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0;
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp;
    // sig = ~v.(sig, 1000);
    sig = Pan2.ar(sig, pan);
    // sig = ~v.(sig, 1000, 0, 5) * 4;
    // sig = ~v.(sig, 8000, 0, 1);
    Out.ar(out, sig);
    // Out.ar(~distBus, sig * 4);
}).add;
)