

(
var    bufCount;
~midinotes = (39, 46 .. 88);
bufCount = ~midinotes.size;

~test = (1, 2 .. 50);


fork {
        // record the samples at different frequencies
    b = Buffer.allocConsecutive(~midinotes.size, s, 44100 * 2, 1);
    SynthDef(\sampleSource, { |freq = 440, bufnum|
        var    initPulse = Impulse.kr(0),
            mod = SinOsc.ar(freq) * Decay2.kr(initPulse, 0.01, 3) * 5,
            car = SinOsc.ar(freq + (mod*freq)) * Decay2.kr(initPulse, 0.01, 2.0);
        RecordBuf.ar(car, bufnum, loop: 0, doneAction: Done.freeSelf);
    }).send(s);
    s.sync;
        // record all 8 buffers concurrently
    b.do({ |buf, i|
        Synth(\sampleSource, [freq: ~midinotes[i].midicps, bufnum: buf]);
    });
};
o = OSCFunc({ |msg|
    bufCount = bufCount - 1;
    if(bufCount == 0) {
        "done recording".postln;
        o.free;
    };
}, '/n_end', s.addr);

SynthDef(\multiSampler, { |out, bufnum, bufBase, baseFreqBuf, freq = 440, amp = 1|
    var    buf1 = bufnum.floor,
        buf2 = buf1 + 1,
        xfade = (bufnum - buf1).madd(2, -1),
        basefreqs = Index.kr(baseFreqBuf, [buf1, buf2]),
        playbufs = PlayBuf.ar(1, bufBase + [buf1, buf2], freq / basefreqs, loop: 0, doneAction: Done.freeSelf),
        sig = XFade2.ar(playbufs[0], playbufs[1], xfade, amp);
    Out.ar(out, sig ! 2)
}).add;

~baseBuf = Buffer.alloc(s, ~midinotes.size, 1, { |buf| buf.setnMsg(0, ~midinotes.midicps) });
)

(
TempoClock.default.tempo = 1;
p = Pbind(
    \instrument, \multiSampler,
    \bufBase, b.first,
    \baseFreqBuf, ~baseBuf,
    \degree, Pseries(0, Prand(#[-2, -1, 1, 2], inf), inf).fold(-11, 11),
    \dur, Pwrand([0.25, Pn(0.125, 2)], #[0.8, 0.2], inf),
    \amp, Pexprand(0.1, 0.5, inf),
        // some important conversions
        // identify the buffer numbers to read
    \freq, Pfunc { |ev| ev.use(ev[\freq]) },
    \bufnum, Pfunc({ |ev| ~midinotes.indexInBetween(ev[\freq].cpsmidi) })
        .clip(0, ~midinotes.size - 1.001)
).play;
)

p.stop;
b.do(_.free); ~baseBuf.free;