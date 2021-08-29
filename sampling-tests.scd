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

IdentityDictionary

(
a = ()
)
(
var yar = "burps";
a = ();
a.put('yar', "sklars");

// a.at(\yurp)
)
a.at(\yar)

~samples.at(\ronron);


(
SynthDef(\samplerAbs, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.001, susT = 1, rel = 0.001, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    // sig = BufRd.ar()
    // sig = LPF.ar(sig, 5000);
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

{ BufRd.ar(2, ~samples.at(\ronron), SinOsc.ar(0.1) * BufFrames.ir(b)) }.play;
(
var buf = ~samples.at('riff');
{
    var phase = Phasor.ar(0, BufRateScale.kr(buf), 0, BufFrames.kr(buf));
    BufRd.ar(2, buf, phase) * 1;
}.play;
)
(
{var buf = ~samples.at('ronron-amp');
    // s.record;
~guitareC.stop;
~guitareC = Pbind(
    \instrument, \samplerAbs,
    \buf, buf,
    \dur, buf.duration,
    \susT, buf.duration - 0.02,
    \amp, Pseq([1.5], inf),
    \out, 0
).play();
    // buf.duration.wait;
    // s.stopRecording;
}.fork;
)

~samples.keys;

(
{var buf = ~samples.at('ronron-amp');
    s.record;
~guitareC.stop;
~guitareC = Pbind(
    \instrument, \samplerAbs,
    \buf, buf,
    \dur, buf.duration,
    \susT, buf.duration - 0.02,
    \amp, Pseq([1.5] * 1, 1),
    \out, 0
).play();
    (buf.duration + 0.025).wait;
    s.stopRecording;
}.fork;
)
