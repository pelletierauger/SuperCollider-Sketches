(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
k.free;
k = {
    var i = 8;
    var freq = 31 + 12 + 24 + -5;
    var trig = Impulse.ar(i);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.025;
    var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 7] ++ [3, 5, 3, 10]).stutter(4), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.1]), trig);
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
    LPF.ar([sig1[0], sig2[0]], 3000) * Line.kr(0, 1, 0.01);
}.play;
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
j.free;
j = {
    var i = 8;
    var freq = 31 + 12 + 12 + -5;
    var trig = Impulse.ar(i);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.025;
    var dem = Demand.ar(trig, 0, Dseq([0, -5, -2, 3].stutter(2), inf) + Dseq([0, -7].stutter(32), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.1]), trig);
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
    LPF.ar([sig1[0], sig2[0]], 3000) * Line.kr(0, 1, 0.01);
}.play;
)
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});

// ------------------------------------------------------------------------------
(
var ver = 1;
var i = 5;
TempoClock.default.sched(2, {
    TempoClock.default.sched(0.0005, {
        k.free;
        k = {
            var freq = 31 + 12 + 24 + -5;
            var trig = Impulse.ar(i);
            var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.05;
            var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 7] ++ [3, 5, 3, 10]).stutter(4), inf));
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
            var sig = [sig1[0], sig2[0]];
            // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
            // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
            var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
            var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
            LPF.ar(sig * (Line.kr(0, 1, 0.001).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01);
            // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
        }.play;
        nil;
    });

    j.free;
    j = {
        var freq = 31 + 12 + 12 + -5;
        var trig = Impulse.ar(i);
        var harmDem = Demand.ar(trig, 0, Dseq([0.65, 0.75].stutter(32), inf));
        var engine = 2, harm = harmDem, timbre = 0.25, morph = 0.45, decay = 0.025;
        var dem = Demand.ar(trig, 0, Dseq([0, -5, -2, 3].stutter(2), inf) + Dseq([0, -7].stutter(32), inf));
        var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.1]), trig);
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
        var sig = [sig1[0], sig2[0]];
        var verb = MiVerb.ar(sig * Line.kr(0, 1, 1), mul: 0.125 * 0.25 * ver);
        LPF.ar(sig * (Line.kr(0, 1, 0.001).floor), 3000) + verb * Line.kr(0, 1, 0.01);
    }.play;
    nil;
});
// y = { MiRings2.ar(PinkNoise.ar(0.1), pit: 29 + 12) * 0.25 * Line.kr(0, 1, 3)}.play;
z = { MiRings2.ar(PinkNoise.ar(0.1), pit: 29 + 0, model:3) * 8.25 * Line.kr(0, 1, 3)}.play;
)

y.free;
z.free;

(
x = {
    var f = 29;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
}.play;
)

x.free;


// -----------------------------------------------------------------------------------------

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
u.free;
u = {
    var trig = Impulse.ar(10);
    var sig = MiPlaits.ar(29 + 24 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1);
        HPF.ar(sig, 5000);
        // sig;
    }.play;
)
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
t.free;
t =
    {
    var trig = Impulse.ar(10);
    var sig = MiPlaits.ar(29 + 24 + 5 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1);
        HPF.ar(sig, 5000);
        // sig;
    }.play;
)
