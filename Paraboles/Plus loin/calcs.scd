s.boot;
s.quit;

(
// Two points in space.
var fo = [25, -25];
var fp = [-20, 55];
var fpori = [-20, 55];
var count = 0;
var fr = 44100 / 440;
var inc = 2pi / fr;
var travel = ~dist.(fp[0], fp[1], fo[0], fp[1]) * 2;
inc = travel / fr;
a = Signal.newClear(44100 * 20);
a.do({
    |item, i|
    var a0, a1, a2, a3, d, opp, hyp, hei;

    count = count + inc;
    if (count >= travel, {count = 0});

    fp[0] = fpori[0] + count;

    // The three angles of our triangle.
    a0 = atan2(fo[1] - fp[1], fo[0] - fp[0]);
    a1 = (pi / 2) - abs(a0);
    a2 = pi / 2;
    a3 = pi - a1 - a2;

    // The distance between fo and fp.
    d = ~dist.(fp[0], fp[1], fo[0], fo[1]);
    opp = d * 0.5;
    hyp = (1 / sin(a3)) * opp;
    hei = fp[1] - hyp;

    a[i] = hei - 2.5 / 12.5 - 0.5 * 2 * 0.1;
});
a.plot;
// b = Buffer.loadCollection(s, a, 1, {|buf| buf.play});
b = Buffer.loadCollection(s, a, 1);
)

p = [\x, 25, \y, -25].asDict;
p[\x]

();
(
// The distance between two points.
~dist = {
|x1, y1, x2, y2|
sqrt((x1 - x2).pow(2) + (y1 - y2).pow(2));
};
)


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
s.record;
s.stopRecording;
{LFTri.ar(440 * [1, 1.001] * -12.midiratio) * Env.new([0, 1, 0], [1, 8]).kr * 0.2}.play;

{SinOsc.ar(440 * [1, 1.001] * -12.midiratio) * Env.new([0, 1, 0], [1, 8]).kr * 0.2}.play;
{Pulse.ar(440 * [1, 1.001] * -12.midiratio) * Env.new([0, 1, 0], [1, 8]).kr * 0.2}.play;


Synth(\sampler, [\rate, 9.midiratio, \amp, 1, \atk, 0.001, \rel, 0.05]);
(
Synth(\sampler, [\rate, -6.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -22.midiratio, \amp, 4, \atk, 1]);
Synth(\sampler, [\rate, 4.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\sampler, [\rate, -5.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -24.midiratio, \amp, 4, \atk, 1]);
Synth(\sampler, [\rate, 2.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\sampler, [\rate, -19.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, (-19 - 12).midiratio, \amp, 8, \atk, 1]);
Synth(\sampler, [\rate, 0.midiratio, \amp, 1, \atk, 1]);
)


(
Synth(\sampler, [\rate, -7.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -13.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -22.midiratio, \amp, 4, \atk, 1]);
Synth(\sampler, [\rate, 4.midiratio, \amp, 1, \atk, 1]);
)

// bonheur
(
Synth(\sampler, [\rate, -8.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -20.midiratio, \amp, 4, \atk, 1]);
Synth(\sampler, [\rate, 1.midiratio, \amp, 1, \atk, 1]);
)

(
Synth(\sampler, [\rate, -10.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -22.midiratio, \amp, 4, \atk, 1]);
Synth(\sampler, [\rate, -1.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\sampler, [\rate, -11.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -27.midiratio, \amp, 8, \atk, 1]);
Synth(\sampler, [\rate, -3.midiratio, \amp, 1, \atk, 1]);
)
// autre
(
Synth(\sampler, [\rate, -11.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2, \atk, 1]);
// Synth(\sampler, [\rate, -27.midiratio, \amp, 8, \atk, 1]);
Synth(\sampler, [\rate, -8.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\sampler, [\rate, -10.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -8.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\sampler, [\rate, -10.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -17.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -6.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\sampler, [\rate, -8.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -17.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -5.midiratio, \amp, 1, \atk, 1]);
)
// ailleurs
(
Synth(\sampler, [\rate, -8.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -12.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -3.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\sampler, [\rate, -8.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -13.midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, -5.midiratio, \amp, 1, \atk, 1]);
)
(
Synth(\sampler, [\rate, (-11 - 2).midiratio, \amp, 2, \atk, 1]);
Synth(\sampler, [\rate, (-27 - 2).midiratio, \amp, 4, \atk, 1]);
Synth(\sampler, [\rate, (-3 - 2).midiratio, \amp, 1, \atk, 1]);
Synth(\sampler, [\rate, (-8 - 2).midiratio, \amp, 1, \atk, 1]);
)

Synth(\sampler, [\rate, 6.midiratio, \amp, 1, \atk, 0.001, \rel, 0.05]);