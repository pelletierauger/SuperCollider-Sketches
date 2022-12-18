
(
var dir = thisProcess.nowExecutingPath.dirname +/+ "hop-samples/";
var sf = PathName.new(dir);
~samples = sf.entries.collect({
    | path |
    Buffer.read(s, path.fullPath);
});
)
~samples;

d = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/hop-samples/hop-ri000.aiff");
e = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/hop-samples/hop-ri001.aiff");
f = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/hop-samples/hop-ri002.aiff");

(
SynthDef(\sampler, {
    arg buf, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.001, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    // env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(
        2, buf,
        rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    );
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
(
SynthDef(\samplerFlip, {
    arg buf, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.001, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    // env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(
        2, buf,
        rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    );
    sig = sig * amp;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    Out.ar(out, sig);
}).add;
)
d.play
s.mute;
s.unmute;

(
~guit2.stop;
~guit2 = Pbind(
    \instrument, \sampler,
    \buf, ~samples[1],
    \dur, 1,
    \amp, 4
).play(~nT, quant: 4);
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
~guit.stop;
~guit = Pbind(
    \instrument, \sampler,
    \buf, ~samples[0],
    \dur, 1,
    \amp, 1.5
).play(~nT, quant: 4);
});
)

(
~guitWA = 0.5;
~guitW.stop;
~guitW = Pbind(
    \instrument, \sampler,
    \buf, ~samples[2],
    \dur, 1,
    // \amp, 0.5
    \amp, FuncStream({~guitWA});
).play(~nT, quant: 4);
)
~guitWA = 1.5;

(
~guit.stop;
~guit2.stop;
~guitW.stop;
)

(
~nT.sched(~nT.timeToNextBeat(quant: 8) + 0.1, {
    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~guitOld.stop;
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
});
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~guit2.stop;
    ~guit2 = Pbind(
        \instrument, \sampler,
        \buf, ~samples[1],
        \dur, 1,
        \amp, 1
    ).play(~nT, quant: 4);
    ~guit.stop;
    ~guit = Pbind(
        \instrument, \sampler,
        \buf, Pseq([~samples[2], ~samples[0]], inf),
        \dur, 2,
        \amp, 1
    ).play(~nT, quant: 4);
    ~guitB.stop;
    ~guitB = Pbind(
        \instrument, \samplerFlip,
        \buf, Pseq([~samples[2], ~samples[0]], inf),
        \dur, 2,
        \amp, 1
    ).play(~nT, quant: [4, 0.25]);
});
)

(
~guit.stop;
~guit = Pbind(
    \instrument, \sampler,
    \buf, d,
    \dur, 2,
    \amp, 0.25
).play(~nT, quant: 4);
)

(
~guit2.stop;
~guit2 = Pbind(
    \instrument, \sampler,
    \buf, e,
    \dur, 1,
    \amp, 1
).play(~nT, quant: 4);
~guit.stop;
~guit = Pbind(
    \instrument, \sampler,
    \buf, d,
    \dur, 2,
    \amp, 0.25
).play(~nT, quant: 4);
)