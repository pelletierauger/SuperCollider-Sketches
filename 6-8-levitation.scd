~nT = TempoClock.new(1.49).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(~drum.isPlaying, {~drum.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~drum = {
        | trigGate = 1 |
        var t, sig, pat0, pat1, block0, block1, note;
        t = Impulse.kr(~nT.tempo * 6) * trigGate;
        pat0 = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
        pat1 = [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0];
        // pat1 = [0, 1, 1];
        block0 = Demand.kr(t, 0, Dseq(pat0, inf));
        block1 = Demand.kr(t, 0, Dseq(pat1, inf));
        note = Demand.kr(t * block1, 0, Dseq((1..12)/12, inf));
        sig = MiPlaits.ar(
            pitch: [30 - 24, 18 + 24 + 24] + 24,
            engine: [13, 12],
            harm: [0.8, 0.5] - 0.1,
            timbre: [0.25, 1],
            morph: [0.8, 0.1],
            trigger: t * [block0, block1],
            decay: 0.0,
            lpg_colour: 0
        );
        sig = sig[0][1] * 1 + (sig[1][1] * 0.1);
        // sig =
        // sig = MiVerb.ar(sig, time: 0.2, drywet: 0.5, damp: 0.2);
        sig = sig + MiRings.ar(
            sig,
            pit: 22,
            struct: 0.25,
            bright: 0.75,
            model: 3,
           pos: note
        );
        sig * 0.4!2;
        // sig = LPF.ar(sig, 2400) * 0.5;
    }.play(fadeTime: 0).register;
});
)