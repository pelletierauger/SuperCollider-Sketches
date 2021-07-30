(
~nT.sched(~nT.timeToNextBeat(quant: 4) + 0.05, {

    [~hats2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});

    ~hats2 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 1;
        // var basePulse = Impulse.ar(tempo) * trigGate;
        // var swing = [2, 4] / 3;
        // var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * 4) * trigGate;
        // var block = Demand.ar(trig, 0, Dseq([1, 1, 1], inf));
        var b0 = [1, 0];
        var b1 = [1, 0];
        var block = Demand.ar(trig, 0, Dseq(b0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(b1, inf));
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0,
            Dseq((0!3) ++ (0!1) ++ (-2!4) ++ (-5!3) ++ (-4!1) ++ (-5!3) ++ (-5!1), inf)
        + Dseq([0, 0].stutter(16), inf)
        );
        var dem2 = Demand.ar(trig * block, 0,
            Dseq([0.01, 1, 1, 1].stutter(4), inf));
        var sig = MiPlaits.ar(
            pitch: 62 + 12 + 12 - 5 + [0, 0.05],
            engine: 15,
            harm: 0.25,
            timbre: Demand.ar(trig * block, 0, Dseq([0.5, 0.2], inf)),
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            morph: 1 *
            Demand.ar(trig * block, 0,
                Dseq(Pseries(0, 1/8, 8).asStream.nextN(8).mirror2, inf)
            ),
            trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (1!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0], sig[1][0]];
        // sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3 * 0.0625;
        sig = sig * 0.125 * 0.5 * envGate;

        // Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.5);
        Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 1);
    }.play(fadeTime: 0).register;
});
)