(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
var sw = 0.01;
// a.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.25 + (~nT.beatDur * 0), {
    a.set(\gate, 0, \fadeTime, 0.5);
    // [~noLow, z, h, ~pul2, ~pul3].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
    // ~sPA.stop;
    // ~sPC.stop;
    // u.free;
    a = {
        var beat = Impulse.ar(~nT.beatDur.reciprocal);
        var trig = Demand.ar(beat, 0, Dseq([1, 0, 0, 0, 0], inf));
        var note = Demand.ar(beat, 0, ff + 12 + Dseq([0, 5, -2].stutter(5) ++ (3!5), inf));
        var note2 = Demand.ar(beat, 0, ff + 12 + Dseq([0, 5].stutter(1), inf));
        var sig = MiPlaits.ar(note + [0, 0.1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: 0.5,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 3);
        sig = (sig * 0.15) + MiRings.ar(sig,
            trig: 0,
            pit: note,
            struct: 0.9,
            bright: 0.4 - ((note2 - ff - 12) * 0.2 * 0.5),
            damp: 0.65 + ((note2 - ff - 12) * 0.2 * 0.25),
            pos: 2,
            bypass: 0);
        sig = sig * 0.125;
    }.play(fadeTime: 0);
});
// c.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.25 + (~nT.beatDur * 0), {
    c.set(\gate, 0, \fadeTime, 0.5);
    c = {
        var trig = Impulse.ar(~nT.beatDur.reciprocal);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        var note = Demand.ar(trig, 0, 30 + 12 + Dseq([0, -5, -2].stutter(5) ++ (-7!5), inf));
        var sig = MiPlaits.ar(note + [0, 0.1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig * block,
            decay: 0.1,
            lpg_colour: 0,
            mul: 3);
        sig = (sig * 0.15) + MiRings.ar(sig,
            trig: 0,
            pit: note - 12,
            struct: 0.9,
            bright: 0.4,
            damp: 0.65,
            pos: 2,
            bypass: 0);
        sig = sig * 0.25;
    }.play(fadeTime: 0.01);
});
)