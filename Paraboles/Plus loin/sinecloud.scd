s.boot;
(
var sr = 44100;
a = Signal.newClear(sr * 4);
a.do({
    |item, i|
//     var y = sin(i / sr);
    var samp = 0;
    var t = i;
    100.do({
        |item, i|
        var x = cos(i + t + sin(i * 100)) * cos(i * 1e-4) * i * 100;
        var y = sin(i + t + sin(i * 100)) * cos(i * 1e-4) * i * 100;
        var angle = atan2(x, y);
        samp = samp + (sin(angle) * 1e-3);
    });
    a[i] = samp * 100;
    }
);
a.plot;
)
b = Buffer.loadCollection(s, a, 1);
b.play;



(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 0, amp = 1, rel = 8, atk = 0.1, out = 0;
    var sig, env, lfo, lft, rgt;
    lft = Rand.new(0.9995, 1.0005);
    rgt = Rand.new(0.9995, 1.0005);
    lfo = SinOsc.kr(6).range(0.75, 1);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(1, b, rate * BufRateScale.ir(buf) * [lft, rgt], startPos: spos * 176400);
    sig = sig * env;
    sig = sig * amp;
//     sig = LPF.ar(sig, 3200);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
Synth(\sampler, [\rate, -29.midiratio, \amp, 5, \atk, 1]);


(
10.do({
    |i|
    i.postln;
});
)