~lfo = {|f,b=0,e=1,p=0|SinOsc.kr(f,p).unipolar.linlin(0,1,b,e)};

(
SynthDef(\samplerStereoEnv, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0.1, dec = 0.1, sus = 1, susT = 0.1, rel = 0.1;
    var env = EnvGen.kr(Env([0, 1, sus, sus, 0], [atk, dec, susT, rel], [0, -8, -8, -8]), doneAction: 0);
    var env2 = EnvGen.kr(Env([0, 1, sus, sus, 0], [atk, dec, susT, rel + 15], [0, -8, -8, -8]), doneAction: 2);
    var in = LocalIn.ar(2);
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp * env + in;
    var lsig = ~v.(sig * 0.95, 9000);
    LocalOut.ar(DelayC.ar(lsig, 1, ~nT.beatDur/16 * [1, 1.01]));
    // sig = sig + in;
    sig = ~v.(sig, 4000);
    sig = Balance2.ar(sig[0], sig[1], pan);
    Out.ar(out, sig);
    // Out.ar(~distBus, sig * 4);
}).add;
)


(
SynthDef(\samplerStereoEnv, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0.1, dec = 0.1, sus = 1, susT = 0.1, rel = 0.1;
    var env = EnvGen.kr(Env([0, 1, sus, sus, 0], [atk, dec, susT, rel], [0, -8, -8, -8]), doneAction: 0);
    var env2 = EnvGen.kr(Env([0, 1, sus, sus, 0], [atk, dec, susT, rel + 25], [0, -8, -8, -8]), doneAction: 2);
    var in = LocalIn.ar(2);
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp * env + (in*0.95);
    var lsig = ~v.(sig * 0.9, 9000);
    LocalOut.ar(DelayC.ar(lsig, 1, ~nT.beatDur/8 * [1, 1.01]));
    // sig = sig + in;
    sig = ~v.(sig, ~lfo.(~nT.tempo * 0.125, 400, 5000));
    sig = Balance2.ar(sig[0], sig[1], pan);
    Out.ar(out, sig);
    // Out.ar(~distBus, sig * 4);
}).add;
)


(
SynthDef(\samplerStereoEnvDel, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0.1, dec = 0.1, sus = 1, susT = 0.1, rel = 0.1;
    var env = EnvGen.kr(Env([0, 1, sus, sus, 0], [atk, dec, susT, rel], [0, -8, -8, -8]), doneAction: 0);
    var env2 = EnvGen.kr(Env([0, 1, sus, sus, 0], [atk, dec, susT, rel + 25], [0, -8, -8, -8]), doneAction: 2);
    var in = LocalIn.ar(2);
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    ) * amp * env + (in*0.95);
    var lsig = ~v.(sig * 0.9, 9000);
    LocalOut.ar(DelayC.ar(lsig, 1, ~nT.beatDur/8 * [1, 1.01]));
    // sig = sig + in;
    sig = ~v.(sig, ~lfo.(~nT.tempo * 0.125, 400, 5000, Rand(-1.0, 1.0)));
    sig = Balance2.ar(sig[0], sig[1], pan);
    Out.ar(out, sig);
    // Out.ar(~distBus, sig * 4);
}).add;
)