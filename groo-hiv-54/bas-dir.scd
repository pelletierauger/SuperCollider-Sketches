(
u.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2, {
u = {
    var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
    var note = Demand.ar(trig, 0, 42 + Dseq([-2, -7, -9, -7, -7].stutter(4), inf));
    var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0], inf));
    var mod = Demand.ar(trig, 0, Dseq(((1..8)/10).stutter(1), inf));
    var sig = MiPlaits.ar(note - 12,
        engine: 3,
        harm: 0.125,
        timbre: 0.75,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig * block,
        decay: 0.4,
        lpg_colour: 0,
        mul: 3);
    sig = sig[0]!2 * 1;
    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note - 12,
        struct: 0.9,
        bright: mod,
        damp: 1 - mod,
        pos: 0,
        bypass: 0,
            model: 4
        );
    sig = sig * 0.25;
        sig = Decimator.ar(sig, rate: 20000, bits: 6) * 0.5;
    }.play(fadeTime: 0);
});
)

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul3.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.18 + (t.beatDur * 0), {
    ~pul3 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0] ++ [0].stutter(20), inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3);
        /*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
        // sig = LPF.ar(sig, 6000);
        sig = HPF.ar(sig, 200);
        sig = sig * 2;
        sig[1]!2;
    }.play(fadeTime: 0);
});
)

// Pour aider le premier snare eraser

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul3.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.18 + (t.beatDur * 0), {
    ~pul3 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0] ++ [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3);
        /*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
        // sig = LPF.ar(sig, 6000);
        sig = HPF.ar(sig, 200);
        sig = sig * 2;
        sig[1]!2;
    }.play(fadeTime: 0);
});
)

// Pour aider le plus intense

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul3.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.18 + (t.beatDur * 0), {
    ~pul3 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3);
        /*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
        // sig = LPF.ar(sig, 6000);
        sig = HPF.ar(sig, 200);
        sig = sig * 2;
        sig[1]!2;
    }.play(fadeTime: 0);
});
)