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
    [sig1[0], sig2[0]];
}.play;
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
j.free;
j = {
    var i = 4;
    var freq = 31 + 12 + 12 + 0 + 7;
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
    [sig1[0], sig2[0]];
}.play;
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
k.free;
k = {
    var i = 4;
    var freq = 31 + 12 + 12 + 0 + 19;
    var trig1 = Impulse.ar(i);
    var trig2 = Impulse.ar(i);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.025;
    var dem = Demand.ar(trig1, 0, Dseq([0, -5].stutter(2).wrapExtend(8) ++ ([-3, -2].stutter(2).wrapExtend(8)), inf));
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
        mul: 0.5);
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig2,
        usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 0.5);
    [sig1[0], sig2[0]];
}.play;
)

s.record;
s.stopRecording;