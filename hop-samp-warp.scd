(
SynthDef(\sampler, {
    arg buf, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.001, susT = 1, rel = 0.01, out = 0;
    var sig, sig2, sig3, env, lfo, scr, scr2;
    scr = Rand(0.00, 1.00);
    scr2 = Rand(0.00, 1.00);
    // env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(
        2, buf,
        rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    );
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.75, algo: 3, timb: 0.7)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.75, algo: 3, timb: 0.7)[0]);
    sig3 = [sig2, sig3] * 2;
    sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
    sig = sig + sig3;

    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)