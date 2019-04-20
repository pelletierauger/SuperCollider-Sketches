(
{
    var src = SoundIn.ar(0)!2; // stereo input
    var rev = JPverb.ar(
        src,
        \t60.kr(10,           0.05),
        \damp.kr(0,          0.05),
        \size.kr(1,          0.05),
        \earlydiff.kr(0.707, 0.05),
        \mdepth.kr(5,        0.05),
        \mfreq.kr(2,         0.05),
        \lowx.kr(1,          0.05),
        \midx.kr(1,          0.05),
        \highx.kr(1,         0.05),
        \lowband.kr(500,     0.05),
        \highband.kr(2000,   0.05)
    );

    Mix([src, rev]) * 0.1;
}.play
)


~accords = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/accords.wav");
~guitare.numFrames;
~guitare.numChannels;
7144448/14400/2/60;
(
SynthDef(\accords, {
    arg buf = ~accords, rate = 1, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0, gate = 1;
    var sig, env, lfo, rev;
//     env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    sig = PlayBuf.ar(2, ~accords, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);


    rev = JPverb.ar(
        sig,
        \t60.kr(5,           0.05),
        \damp.kr(0,          0.05),
        \size.kr(0.1,          0.05),
        \earlydiff.kr(0.707, 0.05),
        \mdepth.kr(5,        0.05),
        \mfreq.kr(2,         0.05),
        \lowx.kr(1,          0.05),
        \midx.kr(1,          0.05),
        \highx.kr(1,         0.05),
        \lowband.kr(500,     0.05),
        \highband.kr(2000,   0.05)
    );
    Out.ar(out, Mix([sig, rev]));
}).add;
)

~accordsfinaux = Synth.new(\accords, [\out, 0, \amp, 2]);
~accordsfinaux.set(\gate, 0);
~accordsfinaux.set(\earlydiff, 0.95);
~accordsfinaux.set(\size, 0.96);
~accordsfinaux.set(\mdepth, 5);
~accordsfinaux.set(\mfreq, 0.1);
~accordsfinaux.set(\highx, 0.5);
