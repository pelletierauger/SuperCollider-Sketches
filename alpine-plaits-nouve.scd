(
x.free;
x = {
    var f = 33;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
    (MiVerb.ar(sig) * 0.5);
}.play;
)
y = { MiRings.ar(PinkNoise.ar(0.1), pit: 33) * 0.5 * Line.kr(0, 1, 3)}.play;
y.free;
z = { MiRings2.ar(PinkNoise.ar(0.1), pit: 34, model:3) * 8.25 * Line.kr(0, 1, 3)}.play;


x.free;
(
y = {
    var f = 31 + 27 - 24 + 7;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
    (MiVerb.ar(sig) * 0.75);
}.play;
)
y.free;
(
var ver = 1;
var i = 7.5;
n.free;
n = {
    var freq = 31 + 12 + 24 + -5 - 1;
    var trig = Impulse.ar(i, 0.1);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.25;
    var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 7] ++ [3, 5, 8, 10]).stutter(16), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
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
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.125;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
m.free;
m = {
    var freq = 31 + 12 + 24 + -5 - 12 - 1;
    var trig = Impulse.ar(i);
    var engine = 3, harm = 0.65, timbre = 0.25, morph = 0.25, decay = 0.5;
    var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 7] ++ [3, 5, 8, 10]).rotate(3).stutter(16), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var amp2 = EnvGen.ar(Env.new([0, 1, 0], [0.0125 * 0.5, 0.09]), trig);
    // var dem = 0;
    var sig1 = MiPlaits.ar(freq + dem,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * dem2 * amp2;
    // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
    // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 19000) + verb * Line.kr(0, 1, 0.01) * 0.5;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
)

// En Fa mineur harmonique
// capo frette 1
// i        V       IV
// Fmin     C       A# ?          Tricotage
// ---------1--------1-------1------1-----1-----1----------------------------------------------
// --------1--------1-------1------1-----1-----1-----------------------------------------------
// -------8--------3-------6------8----10----12------------------------------------------------
// ------6--------3-------5--------------------------------------------------------------------
// -----8--------4-------6---------------------------------------------------------------------
// ----1------- 4-------6----------------------------------------------------------------------