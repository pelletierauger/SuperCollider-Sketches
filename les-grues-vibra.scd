(
~nT.sched(~nT.timeToNextBeat(quant: 12) + 0.1, {
    a.set(\trigGate, 0, \gate, 0, \fadeTime, 0.5);
    a = {
        | trigGate = 1, relGate = 0 |
        var trig0 = Impulse.kr(~nT.tempo) * trigGate;
        var trig = trig0 * Demand.kr(trig0, 0, Dseq(
            [1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0].rotate(0),
        inf));
        var note = Demand.kr(trig, 0, 64 + 12 + Dseq(
            [ -9, -2, -9, -2, -7, -2, -9, -2  ].stutter(1) + [0, 0].stutter(8)
            , inf)
        );
       var note2 = Demand.kr(trig, 0, 42 + 12 + Dseq([0, 0].stutter(1), inf));
        var se = EnvGen.kr(Env([0, 0, 1], [0.1, 0.1]));
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
            bright: 0.2 - ((note2 - 42 - 12) * 0.2 * 0.5),
            damp: 0.95 + ((note2 - 42 - 12) * 0.2 * 0.25),
            pos: 2,
            bypass: 0, poly: 2);
        sig = sig * 0.125 * 0.5 * se;
        sig = VadimFilter.ar(sig, 3000, 0, 5) * 8;
    }.play(fadeTime: 0);
});

)