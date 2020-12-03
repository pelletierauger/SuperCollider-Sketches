(
y.free;
y = {
    arg buf = ~guitte.bufnum, rate = 2.midiratio;
    var in, trig, tri, bufFrames, sig, sig2, start, phasor, phasor2, size, sizeDiv, amp, amp2;
    trig = Impulse.ar(1);
    // rate = rate;
    bufFrames = BufFrames.ir(buf);
    start = (0.4 + SinOsc.ar(550).range(0, 0.001)) * bufFrames;
    size = 209000;
    sizeDiv = size / s.sampleRate;

    phasor = EnvGen.ar(Env.circle([0, size], sizeDiv));
    amp = EnvGen.ar(Env.circle([0, 1], sizeDiv * 0.5));
    sig = BufRd.ar(2, buf, start + phasor) * amp;

    phasor2 = EnvGen.ar(Env.circle([size / 2, size, size / 2, 0], sizeDiv * 0.5));
    amp2 = EnvGen.ar(Env.circle([1, 0], sizeDiv * 0.5));
    sig2 = BufRd.ar(2, buf, start + phasor2) * amp2;

    // [phasor, phasor2].scope;
    LPF.ar(sig + sig2, 3000) * 2;
    // (sig + sig2) * 1;
}.play;
)

(
y.free;
y = {
    arg buf = ~guitte.bufnum, rate = 2.midiratio;
    var in, trig, tri, bufFrames, sig, sig2, start, phasor, phasor2, size, sizeDiv, amp, amp2;
    trig = Impulse.ar(1);
    // rate = rate;
    bufFrames = BufFrames.ir(buf);
    start = (0.4 + SinOsc.ar(0.1).range(0, 0.02)) * bufFrames;
    size = 9;
    sizeDiv = size / s.sampleRate;

    phasor = EnvGen.ar(Env.circle([0, size], sizeDiv));
    amp = EnvGen.ar(Env.circle([0, 1], sizeDiv * 0.5));
    sig = BufRd.ar(2, buf, start + phasor) * amp;

    phasor2 = EnvGen.ar(Env.circle([size / 2, size, size / 2, 0], sizeDiv * 0.5));
    amp2 = EnvGen.ar(Env.circle([1, 0], sizeDiv * 0.5));
    sig2 = BufRd.ar(2, buf, start + phasor2) * amp2;

    // [phasor, phasor2].scope;
    LPF.ar(sig + sig2, 3000) * 4;
    // (sig + sig2) * 1;
}.play;
)

(
// lancinement
y.free;
y = {
    arg buf = ~guitte.bufnum, rate = 2.midiratio;
    var in, trig, tri, bufFrames, sig, sig2, start, phasor, phasor2, size, sizeDiv, amp, amp2;
    trig = Impulse.ar(1);
    // rate = rate;
    bufFrames = BufFrames.ir(buf);
    start = (0.4 + SinOsc.ar(0.1).range(0, 0.01)) * bufFrames;
    size = 2400;
    sizeDiv = size / s.sampleRate;

    phasor = EnvGen.ar(Env.circle([0, size], sizeDiv));
    amp = EnvGen.ar(Env.circle([0, 1], sizeDiv * 0.5));
    sig = BufRd.ar(2, buf, start + phasor) * amp;

    phasor2 = EnvGen.ar(Env.circle([size / 2, size, size / 2, 0], sizeDiv * 0.5));
    amp2 = EnvGen.ar(Env.circle([1, 0], sizeDiv * 0.5));
    sig2 = BufRd.ar(2, buf, start + phasor2) * amp2;

    // [phasor, phasor2].scope;
    LPF.ar(sig + sig2, 3000) * 4;
    // (sig + sig2) * 1;
}.play;
)


(
y.free;
y = {
    arg buf = ~guitte.bufnum, rate = 2.midiratio;
    var in, trig, tri, bufFrames, sig, sig2, start, phasor, phasor2, size, sizeDiv, amp, amp2;
    trig = Impulse.ar(1);
    // rate = rate;
    bufFrames = BufFrames.ir(buf);
    start = (0.8 + SinOsc.ar(0.01).range(0, 0.001)) * bufFrames;
    size = 150;
    sizeDiv = size / s.sampleRate;

    phasor = EnvGen.ar(Env.circle([0, size], sizeDiv));
    amp = EnvGen.ar(Env.circle([0, 1], sizeDiv * 0.5));
    sig = BufRd.ar(2, buf, start + phasor) * amp;

    phasor2 = EnvGen.ar(Env.circle([size / 2, size, size / 2, 0], sizeDiv * 0.5));
    amp2 = EnvGen.ar(Env.circle([1, 0], sizeDiv * 0.5));
    sig2 = BufRd.ar(2, buf, start + phasor2) * amp2;

    // [phasor, phasor2].scope;
    LPF.ar(sig + sig2, 3000) * 16;
    // (sig + sig2) * 1;
}.play;
)


(
y.free;
y = {
    arg buf = ~guitte.bufnum, rate = 2.midiratio;
    var in, trig, tri, bufFrames, sig, sig2, start, phasor, phasor2, size, sizeDiv, amp, amp2;
    trig = Impulse.ar(1);
    // rate = rate;
    bufFrames = BufFrames.ir(buf);
    start = (0.6 + SinOsc.ar(550).range(0, 0.001)) * bufFrames;
    size = 9000;
    sizeDiv = size / s.sampleRate;

    phasor = EnvGen.ar(Env.circle([0, size], sizeDiv));
    amp = EnvGen.ar(Env.circle([0, 1], sizeDiv * 0.5));
    sig = BufRd.ar(2, buf, start + phasor) * amp;

    phasor2 = EnvGen.ar(Env.circle([size / 2, size, size / 2, 0], sizeDiv * 0.5));
    amp2 = EnvGen.ar(Env.circle([1, 0], sizeDiv * 0.5));
    sig2 = BufRd.ar(2, buf, start + phasor2) * amp2;

    // [phasor, phasor2].scope;
    LPF.ar(sig + sig2, 3000) * 2;
    // (sig + sig2) * 1;
}.play;
)