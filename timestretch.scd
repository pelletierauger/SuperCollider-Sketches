Quarks.install("TimeStretch")


}

TimeStretch


TimeStretch.stretchChan("/Users/guillaumepelletier/Music/SuperCollider Recordings/SC_210814_210355.aiff", 4, 0, 9);
TimeStretch.stretchChan("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Samples/slide-slice.wav", 10, 1, 9);



BandSplitter


(
n = {
        var sig = PinkNoise.ar() * Decay.ar(Impulse.ar(1), 0.5);
        var a, b, c, d;
        #a, b, c, d = BandSplitter4.ar(sig, 200, 600, 1000);
        SelectX.ar(MouseX.kr(0, 3), [a, b, c, d])!2;
}.play;
)

n.free;

(
n = {
        var sig = PinkNoise.ar() * Decay.ar(Impulse.ar(0.25), 0.5);
        var bands;
        bands = BandSplitter4.ar(sig, 400, 900, 2000);
        bands = bands + CombC.ar(bands, 2, [0.5, 0.333, 1.02, 0.5], 4);
        sig = Splay.ar(bands);
        sig = Rotate2.ar(sig[0], sig[1], SinOsc.kr(0.01));
}.play;
)

n.free;

(
n = {
        var trig, sig;
        var bands, freqs;
        trig = Impulse.ar(0.25);
        sig = PinkNoise.ar() * Decay.ar(trig, 0.5);
        freqs = Demand.kr(
                Impulse.kr(0.25),
                0,
                Dseq([50, 55, 55, 48, 44, 40], inf)
        );
        freqs = ([4, 7, 10, 0] + freqs).midicps;

        bands = BandSplitter4.ar(sig, 200, 700, 1000);
        bands = bands + Streson.ar(bands, freqs.reciprocal, 0.99);
        bands = bands + CombC.ar(bands, 2, [0.5, 0.333, 3.02, 0.5], 8);
        sig = Splay.ar(bands);
        sig = Rotate2.ar(sig[0], sig[1], SinOsc.kr(0.01));
}.play;
)

n.free;

{ Streson.ar(LFSaw.ar([220, 180], 0, mul:EnvGen.kr(Env.asr(0.5, 1, 0.02), 1.0) * 0.2), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 280, 377).reciprocal, 0.9, 0.3) }.play




// load things
(
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Samples/riff-mono-8sec.wav");
c = Bus.new('control', 0, 13);
d = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Samples/slide-cut-mono-8sec.wav");
~fftbufc = Buffer.alloc(s, 2048);
~fftbufm = Buffer.alloc(s, 2048);
~cepbufc = Buffer.alloc(s, 1024);
~cepbufm = Buffer.alloc(s, 1024);
~envc = Buffer.alloc(s, 2048);
~envm = Buffer.alloc(s, 2048);
)
b.bufnum
d.bufnum

(
SynthDef("morphintime", {
    |out = 0, bufnum = 0, bufnum2 = 1|
    var in, in2, chain, chain2, chain3, cepsch, cepsch2, fftsize;
    fftsize = 2048;
    bufnum = b.bufnum;
    bufnum2 = d.bufnum;
    // 1. STFT of signal
    // 2. smooth spectral envelope
    // get cepstrum of modulating signal
    in = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), 1, 0, 1);
    chain = FFT(~fftbufm, in);
    cepsch = Cepstrum(~cepbufm, chain);
    // get cepstrum of carrier signal
    in2 = PlayBuf.ar(1, bufnum2, BufRateScale.kr(bufnum2), 1, 0, 1);
    chain2 = FFT(~fftbufc, in2);
    cepsch2 = Cepstrum(~cepbufc, chain2);

    // PV_BrickWall can act as a low-pass filter, or here, as a wol-pass lifter...
    // ...in practical terms, produces a smoothed version of the spectrum
    // get smooth version of modulator
    cepsch = PV_BrickWall(cepsch, -0.95);
    ICepstrum(cepsch, ~envm);
    // get smoothed version of carrier
    cepsch2 = PV_BrickWall(cepsch2, -0.95);
    ICepstrum(cepsch2, ~envc);
    // 3. divide spectrum of each carrier frame by
    // smooth spectral envelope (to flatten)
    chain2 = chain2.pvcalc2(~envc, fftsize, {|mags, phases, mags2, phases2|
        [mags / mags2, phases - phases2]
    }, frombin: 0, tobin: 125, zeroothers: 0);
    // 4. multiply flattened spectral carrier frame with smooth spectral envelope
    // of modulator
    chain2 = chain2.pvcalc2(~envm, fftsize, {|mags, phases, mags2, phases2|
        [mags * mags2, phases + phases2]
    }, frombin: 0, tobin: 125, zeroothers: 0);
    Out.ar( out, Pan2.ar(IFFT(chain2)) );
}).send(s);
)

x = Synth.new("morphintime");