(
z = {
    var f = 30 + 12;
    var osc = SinOsc.ar(f.midicps + [0, 0.1]);
    MiRings2.ar(osc, pit: f, model:1) * 1.25 * Line.kr(0, 1, 3)
}.play;
)


(
z = {
    var f = 30 + 12;
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    var osc = SinOsc.ar(f.midicps + [0, 0.1]) * lfo;
    MiRings.ar(osc, pit: f, model:1) * 0.25 * Line.kr(0, 1, 3)
}.play;
z = {
    var t = Impulse.ar(0.5);
    var dem = Demand.ar(t, 0, Dseq([5, 4, 2, -5], inf));
    var f = 30 + 24 + dem;
        var lfo = SinOsc.kr(0.12, [0, pi] + (pi / 8)).range(0.25, 1);
    var osc = SinOsc.ar(f.midicps + [0, 0.1]) * lfo;
    MiRings.ar(osc, pit: f, model:1) * 0.25 * Line.kr(0, 1, 3)
}.play;
z = {
    var f = 30 + 24 + 7;
        var lfo = SinOsc.kr(0.14, [0, pi] + (pi / 3)).range(0.25, 1);
    var osc = SinOsc.ar(f.midicps + [0, 0.1]) * lfo;
    MiRings.ar(osc, pit: f, model:1) * 0.25 * Line.kr(0, 1, 3)
}.play;
z = {
    var t = Impulse.ar(0.25);
    var dem = Demand.ar(t, 0, Dseq([11, 9, 9, 9], inf));
    var f = 30 + 24 + dem;
        var lfo = SinOsc.kr(0.16, [0, pi] + (pi / 2)).range(0.25, 1);
    var osc = SinOsc.ar(f.midicps + [0, 0.1]) * lfo;
    MiRings.ar(osc, pit: f, model:1) * 0.25 * Line.kr(0, 1, 3)
}.play;
)


(
var ver = 1;
var i = 8;
k.free;
k = {
    var freq = 30 - 5 + 24 + 12;
    var trig = Impulse.ar(i);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.15;
    var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 7] ++ [3, 5, 3, 10]).stutter(32), inf));
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
    LPF.ar(sig * (Line.kr(0, 1, 0.001).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01) * 4;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
)

(
x.free;
x = {
    var f = 30 + 36;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.1);
    var alg = 5, morph = 0.95;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: morph, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: morph, mul: 0.2);
    HPF.ar([sig1[0], sig2[0]] * 4 * Line.kr(0, 1, 3), 2900) * 2;
}.play;
)

x.free;