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
    var filSig = LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.225 * 0.5;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);

    var lfo0 = SinOsc.kr(0.5).range(0.25, 0.75);
    var lfo1 = SinOsc.kr(0.6).range(0.25, 0.05);
    var lfo2 = SinOsc.kr(0.7).range(0.25, 0.01);
    var lfo3 = SinOsc.kr(0.8).range(0.05, 0.35);
    var lfo4 = SinOsc.kr(0.9).range(0.25, 0.75);
    Biquad.ar(filSig, lfo0, lfo1, lfo2, lfo3, lfo4);
}.play;
)

2pi.rand
f = (0..4) + 1 / 10;
f[2]
k.free;
(
var f = (0..4) + 1 * 0.2;
k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 7,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.5,
        geom: 0.25,
        space: 0.9,
        model: 1
    );
    var lfo0 = SinOsc.kr(f[0], 2pi.rand).range(0.05, 0.5);
    var lfo1 = SinOsc.kr(f[1], 2pi.rand).range(0.05, 0.25);
    var lfo2 = SinOsc.kr(f[2], 2pi.rand).range(0.05, 0.25);
    var lfo3 = SinOsc.kr(f[3], 2pi.rand ).range(0.05, 0.5);
    var lfo4 = SinOsc.kr(f[4], 2pi.rand).range(0.05, 0.5);
    Biquad.ar(sig, lfo0, lfo1, lfo2, lfo3, lfo4) * 2;
}.play;
)

(
var f = (0..4) + 1 * 0.2;
k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 7,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.5,
        geom: 0.25,
        space: 0.9,
        model: 1
    );
    var lfo0 = SinOsc.kr(f[0], 2pi.rand).range(0.05, 0.5);
    var lfo1 = SinOsc.kr(f[1], 2pi.rand).range(0.05, 0.25);
    var lfo2 = SinOsc.kr(f[2], 2pi.rand).range(0.05, 0.25);
    var lfo3 = SinOsc.kr(f[3], 2pi.rand ).range(0.05, 0.5);
    var lfo4 = SinOsc.kr(f[4], 2pi.rand).range(0.05, 0.5);
    Biquad.ar(sig, 0.1, 0.1, 0.1, 0.1, 0.1) * 2;
    // sig;
}.play;
)