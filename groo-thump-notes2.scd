(

        if(~snare2.isPlaying, {~snare2.set(\gate, 0, \fadeTime, 0.1)});

~snare2 = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        var note = Demand.ar(trig, 0, 42 + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(2,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.0,
            trigger: trig * dem * trigGate,
            decay: 0.5,
            lpg_colour: 0,
            mul: 3);
    sig = LPF.ar(sig, 2400);
        sig = sig * 1.5 * 2;
        sig[1]!2;
    }.play(fadeTime: 0).register;
)