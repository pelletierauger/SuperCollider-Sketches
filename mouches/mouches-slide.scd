(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

   [~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes6 = {
        | trigGate = 1 |
        var tempo = ~nT.tempo * 1;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * [3] * 1) * trigGate;
        var block = Demand.ar(trig, 0, Dseq([0, 0, 1], inf));
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0,
            Dseq((0!4) ++ (-2!4) ++ (-5!3) ++ (-4!1) ++ (-5!3) ++ (-5!1), inf));
        var dem2 = Demand.ar(trig * block, 0,
        Dseq([0.01, 1, 1, 1].stutter(4), inf));
        var sig = MiPlaits.ar(62 + 12 + 12 - 5 + dem.lag(dem2) + [0, 0.05],
            engine: 11,
            harm: 0.25,
            timbre: 0.125,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
    trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0], sig[1][0]];
        sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;

        sig = sig * 0.5;
        // sig;
                Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.5);
        Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 1);

    }.play.register;
});
)