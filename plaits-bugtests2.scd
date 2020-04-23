c = 0;
(
TempoClock.default.sched(0, {
    k.free;
    k = {
        var freq = 31 + 12 + 24 + -5;
        var trig = Impulse.ar(5);
        var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.05;
        var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 7] ++ [3, 5, 3, 10]).stutter(4), inf));
        // var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
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
        // var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
        // var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
        LPF.ar(sig, 3000);
        // sig;
        // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
    }.play;
    j.free;
    j = {
        var freq = 50;
        var trig = Impulse.ar(5);
        var harmDem = Demand.ar(trig, 0, Dseq([0.65, 0.75].stutter(32), inf));
        var engine = 2, harm = harmDem, timbre = 0.25, morph = 0.45, decay = 0.025;
        var dem = Demand.ar(trig, 0, Dseq([0, -5, -2, 3].stutter(2), inf) + Dseq([0, -7].stutter(32), inf));
        // var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.1]), trig);
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
        LPF.ar(sig, 3000);
        // sig;
    }.play;
    c = c + 1;
    c.postln;
    if (c < 1000, {0.05}, {c = 0; nil});
    // 0.1;
});
)
// isolé
