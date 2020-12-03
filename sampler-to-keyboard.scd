~temp = Buffer.alloc(s, 20 * s.sampleRate, 2);

(
y.free;
y = {
    arg buf = ~guitte.bufnum, rate = 2.midiratio;
    var in, trig, tri, bufFrames, sig, sig2, start, phasor, phasor2, size, sizeDiv, amp, amp2;
    trig = Impulse.ar(1);
    // rate = rate;
    bufFrames = BufFrames.ir(buf);
    start = 0.35 * bufFrames;
    size = 9000;
    sizeDiv = size / s.sampleRate;

    phasor = EnvGen.ar(Env.circle([0, size], sizeDiv));
    amp = EnvGen.ar(Env.circle([0, 1], sizeDiv * 0.5));
    sig = BufRd.ar(2, buf, start + phasor) * amp;

    phasor2 = EnvGen.ar(Env.circle([size / 2, size, size / 2, 0], sizeDiv * 0.5));
    amp2 = EnvGen.ar(Env.circle([1, 0], sizeDiv * 0.5));
    sig2 = BufRd.ar(2, buf, start + phasor2) * amp2;

    // [phasor, phasor2].scope;
    sig = (sig + sig2);
    RecordBuf.ar(sig, ~temp);
    sig * 4;
}.play;
)


~temp.play;
~temp.numChannels
~temp.bufnum
(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0, filt, susT;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], [-8, -8, -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // sig = HPF.ar(sig, filt);
    // sig = CombL.ar(sig, 0.05, 48.midicps.reciprocal, 9) * 0.2;
    Out.ar(out, sig);
}).add;
)


Synth.new(\sampler, [buf: 1, rate: 1, \rel, 5]);


(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    Synth.new(\sampler, [buf: 1, rate: (num - 60).midiratio, \rel, 5, \amp, 20]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)