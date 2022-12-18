
g = Buffer.read(s, "/Users/guillaumepelletier/Desktop/hop-ri003.aiff");
h = Buffer.read(s, "/Users/guillaumepelletier/Desktop/hop-ri004.aiff");
g.duration
g.duration
(
SynthDef(\samplerE, {
    arg buf, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.001, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(
        1, buf,
        rate * BufRateScale.ir(buf),
        startPos: spos * BufSampleRate.ir(buf),
        doneAction: 2
    );
    sig = VadimFilter.ar(sig, 12000, 0, 1) * 0.5;
    sig = sig * amp * env;
    Out.ar(out, sig ! 2);
}).add;
)
~samples[3].play
s.unmute;
(
var samp = ~samples[3];
var step = samp.duration / 16;
~guitOld.stop;
~guitOld = Pbind(
    \instrument, \samplerE,
    \buf, samp,
    \spos, step * Pseq((0..15), inf),
    // \spos, floor(g.numFrames/16) * 1,
    // \spos, 0.5,
    \dur, 0.25,
    \susT, samp.duration/16 - 0.001 - 0.01,
    \amp, 0.4
).play(~nT, quant: 4);
)

(
var samp = ~samples[4];
var step = samp.duration / 16;
~guitOldB.stop;
~guitOldB = Pbind(
    \instrument, \samplerE,
    \buf, samp,
    \spos, step * Pseq((0..15), inf),
    // \spos, floor(g.numFrames/16) * 1,
    // \spos, 0.5,
    \dur, 0.25,
    \susT, samp.duration/16 - 0.001 - 0.01,
    \amp, 0.4
).play(~nT, quant: 4);
)


(
var samp = ~samples[3];
var step = samp.duration / 16;
~guitOldW.stop;
~guitOldW = Pbind(
    \instrument, \samplerE,
    \buf, samp,
    \spos, step * Pseq((0..15), inf),
    // \spos, floor(g.numFrames/16) * 1,
    // \spos, 0.5,
    \dur, 0.5,
    \rate, 0.5,
    \susT, samp.duration/16 * 2 - 0.001 - 0.01,
    \amp, 0.8  * 1.5 * 1
).play(~nT, quant: 4);
)