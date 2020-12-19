Pseries(0.125, -0.0125 * 0.53, 16).asStream.nextN(16)[15]

(
var att = 0.125;
var atts = Pseries(0.125, -0.0125 * 0.53, 16).asStream.nextN(16).mirror2;
x.free;
x = {
    var pulse = 7.5 * 0.75 * 0.5;
    // var atk = att;
    var trig = Impulse.kr(pulse);
    var freqShift = Demand.kr(trig, 0, Dseq([5, 0], inf));
    // var freq = 50 + 12 - 9 - 5 + 12 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 4, 7, 11, 14, 16, 19, 26, 28].reverse.stutter(2), inf));
    var freq = 50 + 12 - 9 - 5 + 12 - 3 + Demand.kr(trig, 0, Dseq([7, 12, 14, 16].stutter(2) - 5, inf));
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var harmDem = Demand.kr(trig, 0, Dseq([0.25, 0.5].stutter(16), inf));
    var engine = 2, harm = harmDem, timbre = 0.5, morph = 0.95, decay = 0.45;
    var dem = Demand.kr(trig, 0, Dseq([0.1, -0.1], inf));
    // var att = Demand.kr(trig, 0, Dseq([9, 12, 14, 16].reverse.stutter(2), inf));
    var atk = Demand.kr(trig, 0, Dseq(atts.stutter(4), inf));
    var amp = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [atk, 1 / pulse - atk], [7, 2]), trig);
    var sig1 = MiPlaits2.ar(freq,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + dem,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var pre = [sig1[0], sig2[0]] * amp * 0.25;

/*    var lfo2 = SinOsc.kr(0.1).range(0.75, 0.75);
    var risig = MiRings.ar(sig[0],
            0,
            pit: freq,
            struct: 0.15,
            bright: 0.2,
            damp: lfo2,
            pos: 0.8,
            bypass: 0);
    var risig2 = MiRings.ar(sig[1],
            0,
            pit: freq,
            struct: 0.15,
            bright: 0.2,
            damp: lfo2,
            pos: 0.8,
            bypass: 0);
    var pre = [risig[0], risig2[1]] * 0.1 + sig * 0.5;*/
    var del = CombC.ar(in: pre,
    maxdelaytime: 0.6,
    delaytime: [0.5, 0.5],
    decaytime: 10,
    mul: 1, add: 0);
    // pre = pre + LPF.ar(del * 0.5, 2900);
    // MiVerb.ar(pre, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75;
    pre * 0.75;
}.play;
)

(
var att = 0.05;
w.free;
w = {
    var pulse = 1.39 * 2;
    var atk = att;
    var trig = Impulse.kr(pulse);
    var freqShift = Demand.kr(trig, 0, Dseq([5, 0], inf));
    // var freq = 50 + 12 - 9 - 5 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 4, 7, 11, 14, 16, 19, 26, 28], inf));
    var freq = 50 + 12 - 9 - 8 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 7], inf));
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var harmDem = Demand.kr(trig, 0, Dseq([0.25, 0.5, 0.75].stutter(10), inf));
    var engine = 2, harm = harmDem, timbre = 0.25, morph = 0.5, decay = 0.5;
    var dem = Demand.kr(trig, 0, Dseq([0.1, -0.1], inf));
    var amp = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [atk, 1 / pulse - atk], [7, 2]), trig);
    var sig1 = MiPlaits.ar(freq,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + dem,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * amp * 0.25;
    sig;
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9);
}.play;
)

(
var ver = 1;
var i = 0.5;
q.free;
q = {
    var freq = 31 + 24 - 0;
    var trig = Impulse.ar(i);
    var engine = 2, harm = 0.75, timbre = 0.125, morph = 0.5, decay = 0.95;
    var dem = Demand.ar(trig, 0, Dseq([0, 2, 4, -5], inf));
    // var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    // var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig1 = MiPlaits2.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        // trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        // trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]];
    // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
    // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
    sig * 0.25;
    // var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
    // var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    // var filSig = LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) + verb * Line.kr(0, 1, 0.01) * 0.225 * 2;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
    // filSig;
}.play;
)

(
x.free;
x = {
    var f = 31 + 0;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    [sig1[0], sig2[0]] * 0.5 * Line.kr(0, 1, 3);
}.play;
)

x.free;


// --------------------

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
w =     {
    var trig = Impulse.ar(0.1);
    var env = EnvGen.kr(Env.new([1, 0], [6]), doneAction: 2);
    var sig = MiPlaits.ar(40 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.01,
        lpg_colour: 0,
        mul: 6);
        // sig * SinOsc.kr([3, 3.1]);
    HPF.ar(sig * env, 440) * 0.125;
    }.play;
)
w.free;

// --------------------------------------------------------------------------------
// En Mi Majeur

                                     A         B
--------0--------0------0------0--------0---------0-------------------------------
------12-------10------9------7--------2---------4----------------------------------
----11--------9-------8------6--------2---------4-----------------------------------
--12--------11-------9------7--------4---------6------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------


// Très doucement
-------0----------0-----------------------------------------------------------
------2----------0------------------------------------------------------------
-----2----------2-------------------------------------------------------------
----2----------4--------------------------------------------------------------
---2----------4---------------------------------------------------------------
--0----------0----------------------------------------------------------------