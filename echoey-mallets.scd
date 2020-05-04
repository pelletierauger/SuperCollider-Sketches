
Server.local.options.sampleRate = 48000;

(
var ver = 1;
var i = 4;
m.free;
m = {
    var freq = 31 + 12 + 24 + -5 + -5;
    var trig = Impulse.ar(i, 0.1);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.25;
    var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 6] ++ [3, 5, 8, 10]).stutter(16), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/10, 16).asStream.nextN(16).reverse, inf));
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
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), amount: 0.125, diff: 0.95, damp: 0.75, mul: 0.125 * ver);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 2000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.125;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
)

(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3");
f = 62 + 3 - 7;
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2, pi).range(0.025, 0.85);
    var sig = MiBraids.ar(f - 12 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f + 12 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    sig = LPF.ar(sig, 1000);
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)
~drone.free;

Pseries(0.125, 1/64, 48).asStream.nextN(48)[47]
(
var ver = 1;
var i = 8;
o.free;
o = {
    var freq = 31 + 12 + 24 + -5 + -5;
    var trig = Impulse.ar(i, 0.1);
    var dec = Demand.ar(trig, 0, Dseq(Pseries(0.125, 1/64, 48).asStream.nextN(48).mirror2, inf));
    var engine = 2, harm = 0.65, timbre = 0.5, morph = 0.45, decay = dec;
    var dem = Demand.ar(trig, 0, Dseq(([8, 10, 12, 10]).stutter(48), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/10, 48).asStream.nextN(48).reverse.mirror2, inf));
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
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), amount: 0.125, diff: 0.95, damp: 0.75, mul: 0.125 * ver);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 9000) * Line.kr(0, 1, 0.01) * 0.125 * 0.125;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
)