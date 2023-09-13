
(
~grBu = Buffer.read(s,
"/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dirt-Samples-master/808sd/SD1075.WAV"
)

)
(
~gr.stop;
~gr = Pbind(
    \instrument, \samplerMono,
    \dur, Pseq([Rest(3), 1], inf),
    \buf,~grBu,
    \amp, 8,
    \ff, 5000
).play(~nT, quant: 2);
)
(
~gr.stop;
~gr = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(3), 1], inf),
    \buf,d,
    \amp, 8,
    \ff, 5000
).play(~nT, quant: 2);
)
(
SynthDef(\samplerMono, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, ff = 1000, atk = 0.5, rel = 0.5;
    var e = EnvGen.kr(Env([0,1,1, 0], [atk, BufDur.ir(buf)-(atk+rel), rel]));
    var sig = PlayBuf.ar(
        numChannels: 1,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp * e;
    // sig = ~v.(sig, ff);
    // sig = Pan2.ar(sig, pan);
    Out.ar(out, sig ! 2);
}).add;
)

(
SynthDef(\samplerStereo, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, ff = 1000, atk = 0.5, rel = 0.5;
    var e = EnvGen.kr(Env([0,1,1, 0], [atk, BufDur.ir(buf)-(atk+rel), rel]));
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp * e;
    // sig = ~v.(sig, ff);
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
}).add;
)