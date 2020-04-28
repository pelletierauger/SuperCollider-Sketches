(
d.free;
d = {
    // var f = 34;

    var trig = Impulse.kr(8);
    var f = Demand.kr(trig, 0, Dseq(32 + [6, 11, 13, 11] + 24, inf));
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
    sig * 0.1;
}.play;
)
(
e.free;
e = {
    // var f = 34;

    var trig = Impulse.kr(8);
    var f = Demand.kr(trig, 0, Dseq(32 + [6, 11, 13, 11] + 12, inf));
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
    sig * 0.1;
}.play;
)
(
f.free;
f = {
    // var f = 34;

    var trig = Impulse.kr(8);
    var f = Demand.kr(trig, 0, Dseq(32 + [6, 11, 13, 11] + 0, inf));
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
    sig * 0.2;
}.play;
)

(
var ver = 1;
var i = 8;
n.free;
n = {
    var freq = 31 + 12 + 24 + -5;
    var trig = Impulse.ar(i, 0.1);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.45;
    var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 8] ++ [3, 5, 8, 10]).stutter(16), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig1 = MiPlaits2.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * dem2;
    // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
    // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.225 * 0.5;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
)

// -----------------------
(
t = TempoClock.new;
t.tempo_(50/60);
~guitare = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/0001\ 7-Audio.aif");
SynthDef(\guitare, {
    arg buf = ~guitare, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~guitare, rate * BufRateScale.ir(buf), startPos: spos * 7144448);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare,
    \dur, 1 / 16,
    \spos, Pseq([0.579, 0.2545].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * 1.midiratio,
    \amp, 1.5,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)