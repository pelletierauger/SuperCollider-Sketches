
~distBus = Bus.audio(s, 2)



(
~dist.free;
~dist = {
    | trigGate = 1 |
    var sig = In.ar(~distBus, 2);
        var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var timb = Demand.kr(t, 0, Dwhite(0.00, 1.00, inf));
    // var timb = \timb.kr(0.4);
    var algo = 1;
    sig[0] = MiWarps.ar(sig[0],
        sig[0], 0.9, 0.95, algo: algo, timb: timb)[0];
    sig[1] = MiWarps.ar(sig[1],
        sig[1], 0.9, 0.95, algo: algo, timb: timb)[0];
    sig[0] = MiWarps.ar(sig[0],
        sig[0], 0.9, 0.95, algo: algo, timb: timb)[0];
    sig[1] = MiWarps.ar(sig[1],
        sig[1], 0.9, 0.95, algo: algo, timb: timb)[0];
    sig = ~v.(sig, 6000, 0, 1);
    /*    sig = MiWarps.ar(sig,
    sig, 0.9, 0.75, algo:4, timb: m)[0] * 0.2;*/
    /*    in = AnalogVintageDistortion.ar(
    input: in,
    drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
    shelvingfreq: 600, oversample: 0
    ) * 0.25;
    in = AnalogVintageDistortion.ar(
    input: in,
    drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
    shelvingfreq: 600, oversample: 0
    ) * 0.25;*/
    sig * 0.1;
}.play;
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
    Out.ar(out, sig * 0.1);
    Out.ar(~distBus2, sig * 1);
}).add;
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
    Out.ar(out, sig * 0.1);
    Out.ar(~distBus2, sig * 4);
}).add;
)