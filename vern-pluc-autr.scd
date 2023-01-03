(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});

~nT.sched(~nT.timeToNextBeat(quant: 4), {
h.free;
h = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0] * dd * Demand.kr(tr[0]*dd,0,Dseq([1]++(0!7), inf));
        // var trig = t;
    var d = Demand.kr(t, 0, Dseq([12,15].stutter(4), inf));
    var sig = MiPlaits.ar(31 + 24 + d + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.75,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.75,
            // trigger: (DelayN.kr(t, 1, (0..20)/(125/2))*((20..1)/20)).sum,
            trigger: (DelayN.kr(t, 2,
                2-(Pgeom(0.01,1.2).asStream.nextN(45).mirror*4))).sum,
        decay: 0.9,
        lpg_colour: 0,
            // fm_mod:0.125,
            // timb_mod:0.5,
            // morph_mod:0.95
    );
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];
        ~v.(sig, 3000, 0, 5)*0.5;
        // sig;
    }.play;
});
)