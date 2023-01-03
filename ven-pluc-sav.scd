(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
~nT.sched(~nT.timeToNextBeat(quant: 4), {
q.free;
q = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd * Demand.kr(tr[1]*dd,0, Dseq([0, 0, 1, 0] ++(0!4),inf));
    // var trig = Impulse.ar(0.5);
    var d = Demand.kr(t, 0, Dseq([3, -5, 2, -2].stutter(1), inf));
    var sig = MiPlaits.ar(31 + 24 + d + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.85,
        trigger: t,
        decay: 0.9,
        lpg_colour: 0.5,
            // fm_mod:0.25,
        timb_mod:-0.5,
        // morph_mod:-0.95
    );
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];
        ~v.(sig, 2000, 0, 1)*1;
        // sig;
    }.play(fadeTime:0);
});
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
~nT.sched(~nT.timeToNextBeat(quant: 4), {
r.free;
r = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0] * dd;
        // var trig = t;
    var sig = MiPlaits.ar(31 + 24 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.65,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.85,
        trigger: t,
        decay: 0.9,
        lpg_colour: 0.5,
            // fm_mod:0.125,
        timb_mod:-0.5,
        // morph_mod:-0.95
    );
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];
        ~v.(sig, 2000, 0, 5)*2;
        // sig;
    }.play(fadeTime:0);
});
)


(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});

~nT.sched(~nT.timeToNextBeat(quant: 4), {
g.free;
g = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0] * dd * Demand.kr(tr[0]*dd,0,Dseq([1,0,0,0], inf));
        // var trig = t;
    var d = Demand.kr(t, 0, Dseq([7, 8, 7, 5].stutter(4), inf));
    var sig = MiPlaits.ar(31 + 24 + d + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.75,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.75,
            // trigger: (DelayN.kr(t, 1, (0..20)/(125/2))*((20..1)/20)).sum,
            trigger: (DelayN.kr(t, 1,
                Pgeom(0.01,1.2).asStream.nextN(45).reverse)).sum,
        decay: 0.9,
        lpg_colour: 0,
            // fm_mod:0.125,
            // timb_mod:0.5,
            // morph_mod:0.95
    );
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];
        ~v.(sig, 3000, 0, 5)*0.25;
        // sig;
    }.play;
});
)