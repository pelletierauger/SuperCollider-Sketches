(
// ~voice = Buffer.read(s, "/Users/guillaumepelletier/Downloads/slackjaw vox.wav");
// ~voice.numFrames;
SynthDef(\vox, {
    arg buf = ~voice, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo, oscFreq;
    oscFreq = rrand(1, 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~voice, rate * BufRateScale.ir(buf), startPos: spos * 7481001);
    sig = sig + LPF.ar(((sig * 20000).clip(0, 1.0) * 0.028), 3900) * 0.5;
    // sig = sig * (SinOsc.kr(8) * 100.0).clip(0, 1.0);
    sig = sig * env;
    sig = sig * amp;
    // sig = MoogFF.ar(sig, Line.kr(~toFreq.("F6"), 2, mul: 1)) * 1;
    // sig = LPF.ar(sig, 7000);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

~toFreq.("F4"), ;

(
// ~voice = Buffer.read(s, "/Users/guillaumepelletier/Downloads/slackjaw vox.wav");
// ~voice.numFrames;
SynthDef(\vox2, {
    arg buf = ~voice, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~voice, rate * BufRateScale.ir(buf), startPos: spos * 7481001);
    // sig = sig + LPF.ar(((sig * 20000).clip(0, 1.0) * 0.08), 2900);
    sig = sig * env;
    sig = sig * amp;
    // sig = LPF.ar(sig, 7000);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

rrand(1, 10);





(
// ~voice = Buffer.read(s, "/Users/guillaumepelletier/Downloads/slackjaw vox.wav");
// ~voice.numFrames;
SynthDef(\vox3, {
    arg buf = ~voice, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo, oscFreq, bal, balFreq;
    oscFreq = rrand(1, 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~voice, rate * BufRateScale.ir(buf), startPos: spos * 7481001);
    sig = sig + LPF.ar(((sig * 20000).clip(0, 1.0) * 0.008), 3900) * 0.75;
    // sig = sig * (SinOsc.kr(12) * 100.0).clip(0, 1.0);
    sig = sig * env;
    sig = sig * amp;
    // sig = MoogFF.ar(sig, Line.kr(~toFreq.("F6"), 2, mul: 1)) * 1;
    // sig = LPF.ar(sig, 7000);
    // balFreq = SinOsc.kr(3).range(~toFreq.("F3"), ~toFreq.("F6"));
    balFreq = SinOsc.kr(0.5).range(0, 1.0);
    bal = SinOsc.kr(~toFreq.("F5") * 0.midiratio) * balFreq;
    sig = Balance2.ar(sig[0], sig[1], bal, 1);
    Out.ar(out, sig);
}).add;
)
~toFreq.("F6").pow(2);

(
~buildVoice4.stop;
~buildVoice4 = Pbind(
    \instrument, \vox3,
    \dur, 4,
    \spos, Pseq([0.15, 0.2].stutter(4), inf) + Pseq([0, 0.000], inf),
    \rel, 2.75,
    \atk, 0.07,
    \amp, 0.5 * Pseq([Pgeom(1, 1.1265, 8)], inf) * Pseq([1, 0.5], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t, quant: 4);
)

(
~buildVoice4.stop;
~buildVoice4 = Pbind(
    \instrument, \vox3,
    \dur, Pseq([6, 2], inf),
    \spos, Pseq([0.15, 0.16].stutter(4), inf) + Pseq([0, 0.000], inf),
    \spos, Pseq([0.163, 0.165].stutter(1), inf) + Pseq([0, 0.000], inf),
    \rel, 1.65,
    \atk, 0.07,
    \amp, 0.5 * Pseq([Pgeom(1, 1.1265, 4)], inf) * Pseq([1, 0.5], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t, quant: 4);
)