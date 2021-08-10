(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.2, {
                ~stopAll.();

    [~hellStrum].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});
    // [~hats2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
    // ~granulator.set(\trigGate, 1);

    ~hellStrum = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 0.5;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.kr(tempo * [3] * 1) * trigGate;
        var block = Demand.kr(trig, 0, Dseq([0, 0, 1].rotate(1), inf));
        var trr = trig * block * Demand.kr(trig, 0, Dseq(1!12 ++ (1!12), inf));
        var tuned = Demand.kr(trr, 0, Dseq(
            // (0!4) ++ (2!3) ++ (0!1) ++ (-1!8)
            (0!4) ++ (2!3) ++ (0!1) ++ (-1!3) ++ (0!1) ++ (-1!3) ++ (-3!1)
            // [0, 2, -1, -1].stutter(4)
            , inf));
        var acc = Demand.kr(trr, 0, Dseq(
            (0!3) ++ (1!1) ++ (0!3) ++ (1.5!1) ++ (0!3) ++ (1!1) ++ (0!3) ++ (1.5!1)
            // [0, 2, -1, -1].stutter(4)
            , inf));
        var strumTrig = DelayN.ar(trr, 0.5,
            [0, 0.01, 0.02].stutter(2) * SinOsc.ar(0.1).range(1, 2) * 0.5
        );
        var sig = MiPlaits.ar(
            pitch: 24 + 12 + [0, 0.05, 12, 12.05, 19, 19.05] + tuned.lag(0.05),
            engine: 11,
            harm: 0.25,
            timbre: 0.25 + (acc.lag(0.05) * 0.1),
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            // morph: 0.4,
            trigger: strumTrig,
            decay: 0.3,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0] + sig[2][0] + sig[4][0], sig[1][0] + sig[3][0] + sig[5][0]];
        // sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;
        sig = sig * 0.4 * 1;
        sig = sig.clip(-0.005, 0.005) * 16;
        // sig = sig.clip(-0.005, 0.005);
  /*      sig = [
            MiVerb.ar(sig, time: 0.1, drywet: 1, damp: 0.4),
            MiVerb.ar(sig, time: 0.1, drywet: 1, damp: 0.4)
        ]*/
        sig = MiVerb.ar(sig, time: 0.1, drywet: 1, damp: 0.4);
        // sig.size.poll;
        // sig = [sig[0][0] + sig[1][1], sig[0][1], sig[1][0]];1
        sig = LPF.ar(sig, 2500);
/*        sig = MiRings.ar(sig,
            pit: 24 + tuned.lag(0.05),
            struct: 0.25,
            bright: 0.5,
            damp: 0.7,
            pos: 0.25,
            model: 5

        );*/
        // Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * SinOsc.ar(0.1).range(0, 0.125));
        Out.ar(0, sig * XLine.ar(0.001, 1, 0.005) * 4 * envGate);
    }.play.register;
});
)