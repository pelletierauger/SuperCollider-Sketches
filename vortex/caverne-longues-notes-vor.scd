s.record;
(
var ver = 1;
var i = 0.5;

o.free;
o = {
    var freq = 31 + 12 + 24 + -5 - 12 + 0;
    var trig = Impulse.ar(i);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.5, decay = 0.95;
    var dem = Demand.ar(trig, 0, Dseq([3 + 7, 3 + 5, 3 + 7, 3 + 5, 3 + 7, 3 + 9, 3 + 10, 3 + 9] - 24, inf));
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
    var sig = [sig1[0], sig2[0]] * dem2 * SinOsc.kr(6).range(0.25, 1);
    // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
    // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
    // var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
    var verb = sig * amp * Line.kr(0, 1, 0.1);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    var filSig = LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.225 * 2;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
    filSig;
}.play;
)