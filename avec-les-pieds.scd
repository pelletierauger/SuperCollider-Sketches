(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
a.free;
a = {
    var trig = Impulse.ar(1.39 * 0.2);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, -5].stutter(1), inf));
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
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);
    sig = sig * 0.25;
}.play;
)


(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
b.free;
b = {
    var trig = Impulse.ar(1.39 * 0.2);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, -5].stutter(1), inf));
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
        pit: note - 12,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);
    sig = sig * 0.25;
}.play;
)


(
q.free;
q = {
    var trig = Impulse.ar(8);
    var sig = MiPlaits.ar(31 + 23 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
        // morph: 0.5,
        trigger: trig,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1.25);
    HPF.ar(sig, 5000);
    // sig;
}.play;
)

(
t.free;
t = {
    var trig = Impulse.ar(8);
    var sig = MiPlaits.ar(31 + 23 + 5 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
        // morph: 0.5,
        trigger: trig,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1.25);
    HPF.ar(sig, 5000);
    // sig;
}.play;
)

(
[a, b, q, t].do({|i| i.set(\gate, 0, \fadeTime, 10)});
)