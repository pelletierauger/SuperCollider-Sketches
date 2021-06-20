
(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
var synths = [~kick, ~kick2, ~kickWE];
~nT.sched(~nT.timeToNextBeat(quant: 1), {
    synths.do({|i| if(i.isPlaying,
    {i.set(\trigGate, 0, \gate, 0, \fadeTime, 4)}
)});
    [~vibra0].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
    ~vibra0 = {
        | trigGate = 1 |
        var trig = Impulse.ar(1 / (~nT.beatDur * 4)) * trigGate;
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, 5, -2, 3].stutter(1), inf));
        var note2 = Demand.ar(trig, 0, ff + 12 + Dseq([0, 5].stutter(1), inf));
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
            bright: 0.4 - ((note2 - ff - 12) * 0.2 * 0.5),
            damp: 0.65 + ((note2 - ff - 12) * 0.2 * 0.25),
            pos: 2,
            bypass: 0);
        sig = sig * 0.25;
    }.play(fadeTime: 0).register;
});

~nT.sched(~nT.timeToNextBeat(quant: 1), {
    ~vibra1.set(\gate, 0, \fadeTime, 0.5);
    ~vibra1 = {
        | trigGate = 1 |
        var trig = Impulse.ar(1 / (~nT.beatDur * 4)) * trigGate;
        var note = Demand.ar(trig, 0, 30 + 12 + Dseq([0, -5, -2, -7].stutter(1), inf));
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
        sig = sig * 0.5;
    }.play(fadeTime: 0.01).register;
});
)

t.timeToNextBeat(quant: 8)
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