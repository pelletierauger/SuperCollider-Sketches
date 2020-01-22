(
var mu = 3;
var fo = [25, -25] * mu;
var fp = [-20, 55] * mu;
var fr = 300;
var inc = 2pi / fr;
var count = 0;
a = Signal.newClear(44100 * 10);
a.do({
    |item, i|
    var a0, a1, a2, a3, mo, opp, hyp, hei;
    mu = (0.1 + abs(sin(i * 1e-4))) * 6;
    fo = [25, -25] * 6;
    fp = [-20, 55] * 6;
    fp[0] = sin(count % 2pi) * 200;

    a0 = atan2(fo[1] - fp[1], fo[0] - fp[0]);
    a1 = (pi / 2) - a0;
    a2 = pi / 2;
    a3 = pi - a1 - a2;
    mo = [fp[0] - fo[0], fp[1] - fo[1]];
    opp = hypot(mo[0], mo[1]);
    hyp = (1 / sin(a3)) * opp;
    hei = fp[1] - hyp;
    // a[i] = sin(i/44100 * 2pi * 440 * -5.midiratio);
    a[i] = hei / 200 + 1.5;
    // i.postln;
    count = count + inc;
});
b = Buffer.loadCollection(s, a, 1, {|buf| buf.play});
// b.play;
// a.plot;
)
sin(5).abs * 12
b.play;

a.plot;


(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 0, amp = 1, rel = 8, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(1, b, rate * BufRateScale.ir(buf), startPos: spos * 176400);
    sig = sig!2 * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

Synth(\sampler, [\rate, -5.midiratio, \amp, 0.5]);