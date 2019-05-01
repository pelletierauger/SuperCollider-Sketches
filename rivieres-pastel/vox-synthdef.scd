(
// ~voice = Buffer.read(s, "/Users/guillaumepelletier/Downloads/slackjaw vox.wav");
// ~voice.numFrames;
SynthDef(\vox, {
    arg buf = ~voice, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~voice, rate * BufRateScale.ir(buf), startPos: spos * 7481001);
    sig = sig + LPF.ar(((sig * 20000).clip(0, 1.0) * 0.018), 3900);
    sig = sig * env;
    sig = sig * amp;
    // sig = LPF.ar(sig, 7000);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

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