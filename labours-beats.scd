(
var dir = "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dirt-Samples-master/";
var sf = PathName.new(dir ++ "808bd" ++ "/");
~s808bd = [];
sf.entries.do({| path, i |
    ~s808bd = ~s808bd.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~s808bd.size;
)

(
var dir = "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dirt-Samples-master/";
var sf = PathName.new(dir ++ "808sd" ++ "/");
~s808sd = [];
sf.entries.do({| path, i |
    ~s808sd = ~s808sd.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~s808sd.size;
)

(
var dir = "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dirt-Samples-master/";
var sf = PathName.new(dir ++ "808ht" ++ "/");
~s808ht = [];
sf.entries.do({| path, i |
    ~s808ht = ~s808ht.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~s808ht.size;
)

(
var dir = "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dirt-Samples-master/";
var sf = PathName.new(dir ++ "808" ++ "/");
~s808hc = [];
sf.entries.do({| path, i |
    ~s808hc = ~s808hc.add(Buffer.read(s, path.fullPath));
    path.postln;
});
~s808hc.size;
)


(
SynthDef(\samplerMono, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, ff = 1000;
    var sig = PlayBuf.ar(
        numChannels: 1,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp;
    // sig = ~v.(sig, ff);
    // sig = Pan2.ar(sig, pan);
    Out.ar(out, sig ! 2);
}).add;
)

s.record;
s.stopRecording;
~rec.openOS
"a" ++ "b"
s.mute
s.unmute
~nT.tempo = 60/80
~nT.tempo
60/70
(
~ht.stop;
~ht = Pbind(
    \instrument, \samplerMono,
    \dur, Pseq([0.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~s808hc[1],
    \amp, Pseq([0.65, 0.25, 0.5, 0.25] * 0.25, inf)
).play(~nT, quant: 2);

~bd.stop;
~bd = Pbind(
    \instrument, \samplerMono,
    \dur, Pseq([0.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~s808bd[3],
    \amp, Pseq([0.65] * 0.5, inf)
).play(~nT, quant: 2);

~sd.stop;
~sd = Pbind(
    \instrument, \samplerMono,
    \dur, Pseq([Rest(0.5), 0.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~s808sd[1],
    \amp, Pseq([0.65] * 0.35, inf)
).play(~nT, quant: 2);
)