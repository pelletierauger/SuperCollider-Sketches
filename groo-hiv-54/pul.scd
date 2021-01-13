~toMidi.("F#3") == 54;

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul2.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.3 + (t.beatDur * 0), {
~pul2 = {
    var trig = Impulse.ar(1 / ~nT.beatDur);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
    var sig = MiPlaits.ar(42 + 7 - 24,
        engine: 9,
        harm: 0.95,
        timbre: 0.7,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.2,
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
    sig = LPF.ar(sig, 3000);
    sig = sig * 0.5;
    sig[1]!2;
}.play(fadeTime: 0);
});
)

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul.free;
~pul = {
    var trig = Impulse.ar(1);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(1), inf));
    var sig = MiPlaits.ar(note + [0, 0.1],
        engine: 9,
        harm: SinOsc.kr(0.125).range(0.2, 0.7),
        timbre: 0.99,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.25,
        // trigger: trig,
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
    sig = sig * 0.125;
}.play;
)

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul2.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.3 + (t.beatDur * 0), {
~pul2 = {
    var trig = Impulse.ar(1 / ~nT.beatDur * 4);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var dem = Demand.ar(trig, 0, Dseq((5..1)/5, inf));
    var sig = MiPlaits.ar(42 + 7 + 36,
        engine: 9,
        harm: 0.1 + dem,
        timbre: 0.1,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.2,
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
    sig = LPF.ar(sig, 3000);
    sig = HPF.ar(sig, 1000);
    sig = sig * 1.5;
    sig[1]!2;
}.play(fadeTime: 0);
});
)