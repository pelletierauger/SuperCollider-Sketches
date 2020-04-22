(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
i.free;
i = {
    var i = 4;
    var freq = 31 + 12 + 12 + 0;
    var trig1 = Impulse.ar(i);
    var trig2 = Impulse.ar(i);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.025;
    var dem = Demand.ar(trig1, 0, Dseq([0, -5].stutter(2), inf));
    // var dem = 0;
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig1,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig2,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var input = [sig1[0], sig2[0]];
    var f = Line.ar(0, 1, 2);
    var trig3 = Impulse.ar(i * 0.125);
    var dem2 = Demand.ar(trig3, 0, Dseq([3, 5], inf));
    var pit = 5, pos = 0.5, size = 0.5, dens = 0.95, tex = 0.25, frez = f.floor;
    var fbosc = SinOsc.ar(0.125).range(0.28, 0.48);
    var sig = MiClouds.ar(input, pit, pos, size, dens, tex,
        drywet: 1, in_gain: 2, spread: 1, rvb:0.25, fb: fbosc,
        freeze: frez, lofi: 1, mode: 1) * 1 * f;
    LPF.ar(sig, 900);
}.play;
)
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
j.free;
j = {
    var i = 4;
    var freq = 31 + 12 + 12 + 0;
    var trig1 = Impulse.ar(i);
    var trig2 = Impulse.ar(i);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.025;
    var dem = Demand.ar(trig1, 0, Dseq([0, -5].stutter(2), inf));
    // var dem = 0;
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig1,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig2,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var input = [sig1[0], sig2[0]];
    var f = Line.ar(0, 1, 2);
    var trig3 = Impulse.ar(i * 0.125);
    var dem2 = Demand.ar(trig3, 0, Dseq([3, 5], inf));
    var pit = -2, pos = 0.5, size = 0.5, dens = 0.95, tex = 0.25, frez = f.floor;
    var fbosc = SinOsc.ar(0.125).range(0.28, 0.48);
    var sig = MiClouds.ar(input, pit, pos, size, dens, tex,
        drywet: 1, in_gain: 2, spread: 1, rvb:0.25, fb: fbosc,
        freeze: frez, lofi: 1, mode: 1) * 1 * f;
    LPF.ar(sig, 1900);
}.play;
)
(
x = {
    var f = 31 - 2;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    [sig1[0], sig2[0]] * 0.5;
}.play;
)
x.free;


Pseries(0.15, 0.075, 8).asStream.nextN(8)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
m.free;
m = {
    var i = 4;
    var freq = 31 - 2 + 12 + 12 + 24;
    var trig1 = Impulse.ar(i);
    var trig2 = Impulse.ar(i);
    var trig3 = Impulse.ar(i * 1);
    var dem2 = Demand.ar(trig3, 0, Dseq([0.125, 0.25].stutter(8), inf));
    var dem3 = Demand.ar(trig3, 0, Dseq([1.5, 0.75].stutter(8), inf));
    var dem4 = Demand.ar(trig3, 0, 1 - (Dseq(Dseries(0.15, 0.09, 8), inf)));
    var engine = 2, harm = 0.65, timbre = dem2, morph = 0.15, decay = 0.05;
    var dem = Demand.ar(trig1, 0, Dseq([0, 2, -1, 2].stutter(8), inf));
    // var dem = 0;
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig1,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig2,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    [sig1[0], sig2[0]] * 0.125 * dem3 * 0.75 * dem4;
}.play;
)


(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
n.free;
n = {
    var i = 8;
    var freq = 31 - 2 + 12 + 12 + 24;
    var trig1 = Impulse.ar(i);
    var trig2 = Impulse.ar(i);
    var trig3 = Impulse.ar(i * 1);
    var dem2 = Demand.ar(trig3, 0, Dseq([0.125, 0.25].stutter(8), inf));
    var dem3 = Demand.ar(trig3, 0, Dseq([1.5, 0.75].stutter(8), inf));
    var dem4 = Demand.ar(trig3, 0, 1 - (Dseq(Dseries(0.15, 0.09, 8), inf)));
    var engine = 2, harm = 0.65, timbre = dem2, morph = 0.15, decay = 0.05;
    var dem = Demand.ar(trig1, 0, Dseq([0, 2, -1, 2].stutter(16) - 5, inf));
    // var dem = 0;
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig1,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig2,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    [sig1[0], sig2[0]] * 0.125 * dem3 * 0.75 * dem4;
}.play;
)





(
x = {
    var f = 31 - 2 + 36 + -5;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4) * 0.4;
}.play;
TempoClock.default.sched(3, {
x = {
    var f = 31 - 2 + 36 + 0;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4) * 0.4;
}.play;
});
TempoClock.default.sched(5, {
x = {
    var f = 31 - 2 + 36 + 2;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4) * 0.4;
}.play;
});
)
