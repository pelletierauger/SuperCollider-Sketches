s.boot;
(
var sr = 44100;
a = Signal.newClear(sr * 16);
a.do({
    |item, i|
//     var y = sin(i / sr);
    var samp = 0;
    var t = i;
    var xx = 0;
    var yy = 0;
    10.do({
        |item, i|
        var ti = t.linlin(0, sr * 16, 0, 0.002);
        var x = cos(t * 1e-2 * cos(i * ti) + (xx * 1000 * ti)) * i;
        var y = sin(t * 1e-2 * sin(i * ti) + (yy * 1000 * ti)) * i;
        var angle = atan2(x, y);
        var di = ~dist.(0, 0, x, y);
        xx = sin(x);
        yy = sin(y);
        samp = samp + (sin(angle + di) * 1e-3);
    });
    a[i] = samp * 100;
    }
);
a.plot;
)
b = Buffer.loadCollection(s, a, 1);
b.play;

b.numFrames

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
//     sig = HPF.ar(sig, 2000);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
Synth(\sampler, [\rate, 0.midiratio, \amp, 2, \atk, 1, \rel, 8]);

1.linlin(0, 1, 0, 10)

(
10.do({
    |i|
    i.postln;
});
)



(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \sampler,
    \dur, Pseq([2], inf),
    \rate, Pseq([-12].midiratio, inf),
    \amp, 1,
    \atk, 1,
    \rel, 2,
    \spos, 0.5
).play;
)
(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \sampler,
    \dur, Pseq([0.25], inf),
    \rate, Pseq([0].midiratio, inf) * [0].midiratio,
    \amp, 0.25,
    \atk, 0.5,
    \rel, 4,
    \spos, 0.5 + Pwhite(-0, 0.4, inf)
).play;
)