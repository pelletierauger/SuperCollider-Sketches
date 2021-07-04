~clock = TempoClock(3.5).permanent_(true);
~clock.beatDur
(
~clock.sched(~clock.timeToNextBeat(quant: 4), {
    y.free;
    y = {
        var imp = Impulse.ar(3.5 * 0.5).lag(0.1);
        SinOsc.ar(440 * 8) * 20!2 * imp;
    }.play;
});
)


(
~clock.sched(~clock.timeToNextBeat(quant: 4), {
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var tempo = 3.5;
    var basePulse = Impulse.kr(tempo);
    var swing = [0.8, 1.2];
    var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
    var swungPulse = Impulse.kr(swungTempo);
    //           |                   |
    var notes = [1,   1,   1,   1,   1,   1,   0,   1];
    var inter = [0,   2,   3,   6,   0,   2,        6];
    var t = swungPulse * Demand.kr(swungPulse, 0, Dseq(notes, inf));
    var harm = Demand.kr(t, 0, Dseq([Dseries(0.15, 0.01, inter.size)], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.5], [2, 'lin', 'lin']), t).lag(0.1);
    var brightness = Demand.kr(t, 0, Dseq([0.25, 0.35, 0.35, 0.5, 0.25, 0.35, 0.5], inf)).lag(0.1);
    var engine = Demand.kr(t, 0, Dseq([4, 0].stutter(14), inf));
    var note = Demand.kr(t, 0,
        60 - 24 + Dseq(inter, inf) + Dseq([0, -5].stutter(14), inf)
    );
    var sig = MiPlaits.ar(
        pitch: note,
        engine: engine,
        harm: harm,
        timbre: env * brightness,
        morph: env.pow(3)
    ) * 0.5 * env;
    sig = sig[1]!2;
    sig = MiRings.ar(
        in: sig,
        pit: (note - 24).lag(0.1),
        struct: 0.95,
        bright: env.pow(3),
        damp: 0.75,
        pos: 0.85,
        model: 2
    );
    // [bT, t].lag(0.5);
}.play;
});
)


(
~clock.sched(~clock.timeToNextBeat(quant: 4), {
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var tempo = 3.5;
    var basePulse = Impulse.kr(tempo);
    var swing = [0.8, 1.2];
    var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
    var swungPulse = Impulse.kr(swungTempo);
    //           |                   |
    var notes = [1,   1,   1,   1,   1,   1,   0,   1];
    var inter = [0,   2,   3,   6,   0,   2,        6];
    var t = swungPulse * Demand.kr(swungPulse, 0, Dseq(notes, inf));
    var harm = Demand.kr(t, 0, Dseq([Dseries(0.15, 0.01, inter.size)], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.5], [2, 'lin', 'lin']), t).lag(0.1);
    var brightness = Demand.kr(t, 0, Dseq([0.25, 0.35, 0.35, 0.5, 0.25, 0.35, 0.5], inf)).lag(0.1);
    var engine = Demand.kr(t, 0, Dseq([4, 0].stutter(14), inf));
    var note = Demand.kr(t, 0,
        60 - 24 + Dseq(inter, inf) + Dseq([0, -5].stutter(14), inf)
    );
    var sig = MiPlaits.ar(
        pitch: note,
        engine: engine,
        harm: harm,
        timbre: env * brightness,
        morph: env.pow(3)
    ) * 0.5 * env;
    sig = sig[1]!2;
    sig = MiRings.ar(
        in: sig,
        pit: (note - 24).lag(0.1),
        struct: 0.95 * (0.5 + brightness),
        bright: env.pow(3),
        damp: 0.75,
        pos: 0.85,
        model: 2
    );
    // [bT, t].lag(0.5);
}.play;
});
)


(
~clock.sched(~clock.timeToNextBeat(quant: 4), {
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var tempo = 3.5;
    var basePulse = Impulse.kr(tempo);
    var swing = [0.8, 1.2];
    var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
    var swungPulse = Impulse.kr(swungTempo);
    //           |                   |
    var notes = [1,   1,   1,   1,   1,   1,   0,   1];
    var inter = [0,   2,   3,   6,   0,   2,        6];
    var t = swungPulse * Demand.kr(swungPulse, 0, Dseq(notes, inf));
    var harm = Demand.kr(t, 0, Dseq([Dseries(0.15, 0.01, inter.size)], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.5], [2, 'lin', 'lin']), t).lag(0.1);
    var brightness = Demand.kr(t, 0, Dseq([0.25, 0.35, 0.35, 0.5, 0.25, 0.35, 0.5], inf)).lag(0.1);
    var engine = Demand.kr(t, 0, Dseq([4, 0].stutter(14), inf));
    var note = Demand.kr(t, 0,
        60 - 24 + Dseq(inter, inf) + Dseq([0, -5].stutter(14), inf)
    );
    var sig = MiPlaits.ar(
        pitch: note,
        engine: engine,
        harm: harm,
        timbre: env * brightness,
        morph: env.pow(3)
    ) * 0.5 * env;
    sig = sig[1]!2;
    sig = MiRings.ar(
        in: sig,
        pit: (note - 24).lag(0.1),
        struct: 0.95 * (0.5 + brightness),
        bright: env.pow(3),
        damp: 0.75,
        pos: 0.85,
        model: 2
    );
    // [bT, t].lag(0.5);
}.play;
});
)