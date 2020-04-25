
(
c = 0;
TempoClock.default.sched(0, {
    k.free;
    k = {
        var freq = 31 + 12 + 24 + -5;
        var trig = Impulse.kr(5);
        var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.05;
        var dem = Demand.kr(trig, 0, Dseq(([3, 5, 3, 7] ++ [3, 5, 3, 10]).stutter(4), inf));
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
        // sig1 = max(min(sig1, 1.0), -1.0);
        // sig2 = max(min(sig2, 1.0), -1.0);
        var sig = [sig1[0], sig2[0]];
        LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000);
        // LPF.ar(sig, 3000);
        // LPF.ar(sig, 3000);
        // sig;
    }.play;
    c = c + 1;
    c.postln;
    if (c < 3000, {0.05}, {c = 0; nil});
    // 0.1;
});
)
// isolé
