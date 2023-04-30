
// Loading a folder of samples into an array.
(
var dir = "/Volumes/Volumina/Clouds/Clouds - Sample Pack 005/Kick/";
var sf = PathName.new(dir);
~kicks = [];
sf.entries.do({| path, i |
    ~kicks = ~kicks.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~kicks.size;
)

(
var dir = "/Volumes/Volumina/Clouds/Clouds - Sample Pack 005/Hat/";
var sf = PathName.new(dir);
~hats = [];
sf.entries.do({| path, i |
    ~hats = ~hats.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~hats.size;
)

(
var dir = "/Volumes/Volumina/Clouds/Clouds - Sample Pack 005/Hit/";
var sf = PathName.new(dir);
~hits = [];
sf.entries.do({| path, i |
    ~hits = ~hits.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~hits.size;
)

(
~allHits.stop;
~allHits = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.5), 0.5], inf),
    \buf, Pindex(~hits, Pseq([1, 3]+23, inf)),
    // \buf, ~kicks[0],
    \amp, 0.125 * 0.25
).play(~nT, quant: 2);
)


(
var dir = "/Volumes/Volumina/Clouds/Clouds - Sample Pack 005/Kick/";
var sf = PathName.new(dir);
~kicks = [];
sf.entries.do({| path, i |
    ~kicks = ~kicks.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~kicks.size;
)


// Listening to the first sample in the array.
~kicks[0].play;
~kicks[0]

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
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
}).add;
)

// Listening to all samples using a Pbind.
(
~allSnares.stop;
~allSnares = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([2], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~kicks[0],
    \amp, 1
).play;
)

t.tempo
(
~allSnares.stop;
~allSnares = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq(0.5 * [1.5, 2.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~kicks[6],
    \amp, 1
).play(~nT, quant: 2);
)

~nT.tempo = 1.75
~nT.tempo = 1.5
(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[0],
    \amp, Pseq([0.65, 0.25, 0.5, 0.25] * 0.5, inf) * 0.125
).play(~nT, quant: 2);
)


(
~h2.stop;
~h2 = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.5), 0.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[8],
    \amp, Pseq([0.5, 0.25] * 0.5, inf) * 1
).play(~nT, quant: 2);
)



(
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.98 * 0.5), 1.02 * 0.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~snares[5],
    \amp, Pseq([0.125], inf)
).play(~nT, quant: 2);
)


(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq(0.5 * [1.5, 1.5, 1], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, Pseq([~kicks[6], ~kicks[6], ~kicks[9]], inf),
    \amp, 0.25
).play(~nT, quant: 2);
)


(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq(0.5 * [0.5, 1, 1.5, 1], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, Pseq([~kicks[6], ~kicks[6], ~kicks[6], ~kicks[9]], inf),
    \amp, 0.25
).play(~nT, quant: 2);
)


~nT.tempo = 1.75
~nT.tempo = 1.25
~nT.tempo = 1.35 // Le bon
~nT.tempo
(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(0.5 * [0.5, 1, 0.5, 1, 1], inf),
    \buf, Pindex(~kicks, Pseq([6, 6, 6, 6, 9] + 0, inf)),
    // \buf, Pseq([~kicks[6], ~kicks[6], ~kicks[6], ~kicks[9]], inf),
    \amp, Pseq([0.25, 0.2, 0.25, 0.2, 0.25], inf),
    \ff, Pseq([2000, 3000, 1500, 3000, 9000], inf)
).play(~nT, quant: 2);
)

(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(0.5 * [0.5, 1, 0.5, 0.98, 1.02], inf),
    \buf, Pindex(~kicks, Pseq([6, 4, 6, 4, 9] + 17, inf)),
    // \buf, Pseq([~kicks[6], ~kicks[6], ~kicks[6], ~kicks[9]], inf),
    \amp, Pseq([0.25, 0.5, 0.25, 0.5, 0.25] * 0.5, inf),
    \ff, Pseq([2000, 1000, 1500, 1000, 3000], inf)
).play(~nT, quant: 2);
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
    Out.ar(out, sig);
    // Out.ar(~distBus, sig * 4);
}).add;
)


(
SynthDef(\samplerStereoLPF, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, ff = 1000;
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp;
    sig = ~v.(sig, ff);
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
}).add;
)


(
SynthDef(\samplerStereoLPF, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, ff = 1000;
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp;
    sig = ~v.(sig, ff);
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
    Out.ar(~distBus, sig * 1);
}).add;
)


~distBus = Bus.audio(s, 2)

(
~dist.free;
~dist = {
    var in = In.ar(~distBus, 2);
    in = AnalogVintageDistortion.ar(
        input: in,
        drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
        shelvingfreq: 600, oversample: 0
    ) * 0.25;
    in = AnalogVintageDistortion.ar(
        input: in,
        drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
        shelvingfreq: 600, oversample: 0
    ) * 0.25;
    in  * 0.1;
}.play;
)
