(
var samplesFolder;

~samples = ();
samplesFolder = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Samples/");
samplesFolder.entries.do({
    arg path, i;
    ~samples.put(path.fileNameWithoutExtension.asSymbol, Buffer.read(s, path.fullPath));
    path.fileName.postln;
});
~samples;
)

(
SynthDef(\samplerAbs, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.001, susT = 1, rel = 0.001, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    // sig = BufRd.ar()
    sig = LPF.ar(sig, 5000);
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | rate = 1, pan = 1, amp = 1, atk = 0.001, susT = 1, rel = 0.001, out = 0 |
    var buf, spos, imp, sig, env, env2, lfo, dem;
    buf = ~samples.at('slide-slice');
    spos = 1.49;
    t = Impulse.kr(0.5);
    env = EnvGen.kr(Env([0, 1, 0], [0.025, 0.1], [-8, -8, 'lin']), t).lag(0.1);
    env2 = EnvGen.kr(Env([0, 1, 0], [0.025, 0.9], [-8, -8, 'lin']), t).lag(0.1);
    sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: 1 * BufRateScale.ir(buf),
        trigger: t,
        startPos: spos * BufSampleRate.ir(buf)
    );
    // sig = BufRd.ar()
    dem = Demand.kr(t, 0, Dseq([0, -2].stutter(2), inf));
    sig = LPF.ar(sig, 8000)!2 * [env, env2 * 0.5];
    sig = [sig[0][0] + sig[1][0], sig[0][1] + sig[1][1]];
    sig = MiRings.ar(
        sig,
        pit: 48 + dem,
        bright: 0.5,
        damp: 0.8,
        model: 1
    );
    sig = sig * amp * 2;
    // sig = Balance2.ar(sig[0], sig[1], pan, 1);
    // Out.ar(out, sig);
    sig;
}.play;
)