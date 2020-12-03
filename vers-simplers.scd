~buf = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/piano-loop-2-quiet-2-48kh.aiff")
~guitte = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0001 7-Audio.aif");


~guitte.bufnum
~buf.bufnum
~guitte.plot


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
    (sig + sig2) * 4;
}.play;
)



(
y.free;
y = {
    arg buf = ~guitte.bufnum, rate = 1;
    var in, trig, tri, bufFrames, sig, sig2, start, phasor, phasor2, size, amp, amp2;
    trig = Impulse.ar(1);
    rate = rate * BufRateScale.ir(buf);
    bufFrames = BufFrames.ir(buf);
    start = 0.432 * bufFrames;
    size = 45000;
    phasor = Phasor.ar(
        trig: 0,
        rate: rate,
        start: 0,
        end: size,
        resetPos: 0);
    // phasor = LFTri.ar(0.25).range(0, 80000);
    phasor = EnvGen.ar(Env.circle([0, size * 0.5], size / s.sampleRate));
    amp = EnvGen.ar(Env.circle([0, 1], size / s.sampleRate));
    phasor2 = EnvGen.ar(Env.circle([size, 0], size / s.sampleRate));
    amp2 = EnvGen.ar(Env.circle([1, 0], size / s.sampleRate));
    sig = BufRd.ar(2, buf, start + phasor);
    sig2 = BufRd.ar(2, buf, start + phasor2) * amp2;
    [(phasor / size), (phasor2 / size)].scope;
    (sig) * 1;
}.play;
)


{EnvGen.ar(Env.circle([0, 10000], 10000 / s.sampleRate * 2!2, [-32, 32]))}.plot(1);
{var size = 441e2; EnvGen.ar(Env.circle([0, size], size / s.sampleRate * 1))}.plot(2)
{var size = 441e2; EnvGen.ar(Env.circle([size, 0], size / s.sampleRate * 1, 0))}.plot(2)

Env.circle([0, 10000], 10000 / s.sampleRate * 2!2).plot(2);
Env.circle([[0, 10000], [0, 5000]], 10000 / s.sampleRate * 2!2).plot

80000 / s.sampleRate


(
// y.free;
y = {
    arg buf = ~guitte.bufnum, rate = 1;
    var in, trig, tri, bufFrames, sig, sig2, start, phasor, phasor2, size, amp, amp2;
    trig = Impulse.ar(1);
    rate = rate * BufRateScale.ir(buf);
    bufFrames = BufFrames.ir(buf);
    start = 0.420 * bufFrames;
    size = 15000;
    phasor = Phasor.ar(
        trig: 0,
        rate: rate,
        start: 0,
        end: size,
        resetPos: 0);
    // phasor = LFTri.ar(0.25).range(0, 80000);
    phasor = EnvGen.ar(Env.circle([0, size], [size / s.sampleRate, 0]));
    amp = EnvGen.ar(Env.circle([0, 1], size / s.sampleRate * 0.5));
    phasor2 = EnvGen.ar(Env.circle([size, 0], size / s.sampleRate));
    amp2 = EnvGen.ar(Env.circle([1, 0], size / s.sampleRate));
    sig = BufRd.ar(2, buf, start + phasor) * amp;
    sig2 = BufRd.ar(2, buf, start + phasor2) * amp2;
    // [(phasor / size), (phasor2 / size)].scope;
    (sig) * 2;
}.play;
)