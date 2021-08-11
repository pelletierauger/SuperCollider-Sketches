(
// {
var ff = 54 + -12;
~vibra1.set(\gate, 0, \fadeTime, 0.5);
~vibra1 = {
    | trigGate = 1 |
    var trig = Impulse.kr(1 / (~nT.beatDur * 4)) * trigGate;
    var note = Demand.kr(trig, 0, 30 + 12 + Dseq([0, -5, -2, -7].stutter(1), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.0125, 4], [2, 'lin', 'lin']), trig);

    var sig = MiPlaits.ar(note.lag(0.1) + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        // morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.1,
        lpg_colour: 0
    ) * env * 3;
    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note.lag(0.01) - 12,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        poly: 1,
        bypass: 0);
    sig = sig * 0.5;
}.play(fadeTime: 0.01).register;
    // 0.025.wait;
)
(
var ff = 54 + -12;

[~vibra0].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
~vibra0 = {
    | trigGate = 1 |
    var trig = Impulse.kr(1 / (~nT.beatDur * 4)) * trigGate;
    var note = Demand.kr(trig, 0, ff + 12 + Dseq([0, 5, -2, 3].stutter(1), inf));
    var note2 = Demand.kr(trig, 0, ff + 12 + Dseq([0, 5].stutter(1), inf));
    var sig = MiPlaits.ar(note.lag(0.05) + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        // morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.4,
        lpg_colour: 0,
        mul: 3);
    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note.lag(0.01),
        struct: 0.9,
        bright: 0.4 - ((note2.lag(0.05) - ff - 12) * 0.2 * 0.5),
        damp: 0.65 + ((note2.lag(0.05) - ff - 12) * 0.2 * 0.25),
        pos: 2,
        poly: 4,
        bypass: 0);
    sig = sig * 0.25;
}.play(fadeTime: 0).register;
// }.fork;
)

(
1.postln;
1.wait;
2.postln;
)