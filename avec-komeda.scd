
~komeda = Buffer.read(s, "/Users/guillaumepelletier/Downloads/krzysztof komeda - the complete recordings of krzysztof komeda (1998)/06 - smarkula vi.wav");
~komeda.numFrames;
1;
~komeda;
(
SynthDef(\ko, {
    arg buf = ~komeda, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~komeda, rate * BufRateScale.ir(buf), startPos: spos * 3290175);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~shimmer.stop;
~shimmer = Pbind(
    \instrument, \ko,
    \dur, 1 / 16,
    \spos, 0.86 + Pwhite(-0.001, 0.001, inf),
    \rel, 0.7,
    \atk, 0.7,
    \amp, 0.75,
    \rate, [0.5, 0.75, 1] * 5.midiratio,
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(t);
)