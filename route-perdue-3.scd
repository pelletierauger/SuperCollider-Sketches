~tail = Buffer.read(s, "/Users/guillaumepelletier/Desktop/tail.wav")
~impact = Buffer.read(s, "/Volumes/Volumina/Clouds/Clouds - Sample Pack 005/Impact/Impact 15.wav")
~tail.play;
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
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, ff = 1000, atk = 0.5, rel = 0.5;
    var e = EnvGen.kr(Env([0,1,1, 0], [atk, BufDur.ir(buf)-(atk+rel), rel]));
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp * e;
    sig = ~v.(sig, ff);
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
}).add;
)

(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq([3], inf),
    \buf,~tail,
    \amp, 8,
    \ff, 5000
).play(~nT, quant: 2);
)
~impact.duration
~nT.beatDur * 8
(
~imp.stop;
~imp = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq([8], inf),
    \buf,~impact,
    \amp, 0.25,
    \atk, 0.001,
    \ff, 5000
).play(~nT, quant: 2);
)
~nT.beatDur*2

(
x.free;
x = {
    var sig = (PlayBuf.ar(2, b, rate: 1, loop: 1));
/*    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.085 + ~lfo.(0.1,0,1),
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    sig;
}.play;
)