(
var f = 220 * 9.midiratio;
var ff = 54 + -12 - 12;
w.free;
t.sched(t.timeToNextBeat(quant: 8) + 0.1, {
w = {
    var trig = Impulse.ar(122 / 60 * 0.125 * 16 * 2);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, -5, -2, -7].stutter(32), inf));
    var mod = Demand.ar(trig, 0, Dseq(((1..8)/10).stutter(2), inf));
    var sig = MiPlaits.ar(note + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);
    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.4,
        bright: mod,
        damp: 1 - mod,
        pos: 2,
        bypass: 0);
    sig = sig * 0.25;
}.play(fadeTime: 0.1);
});
)

(1..8)/10