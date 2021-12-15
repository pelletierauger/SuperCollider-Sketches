~toMidi.("C5")
~toMidi.("G5")

(
~leadSqueak = {
~nT.sched(~nT.timeToNextBeat(quant: 4), {

        // if(~rimz.isPlaying, {~rimz.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
        // ~drums.stop;
        if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    [~lead].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~lead = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 1;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * [3] * 1) * trigGate;
        var block = Demand.ar(trig, 0, Dseq([0, 0, 1].rotate(0), inf));
                var amp = EnvGen.ar(
                envelope: Env(
                    [0, 0, 1],
                    [0, 0.005],
                    ['lin', 'lin'],
                    releaseNode: 1,
                    loopNode: nil
                ),
        gate: trig * block,
        doneAction: 0
    );
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0,
            Dseq(
                (0!4) ++ (-1!4) ++ (-3!3) ++ (-1!1) ++ (-4!3) ++ (-4!1) ++
                (0!3) ++ ( 4!1) ++ ( 2!4) ++ (-3!3) ++ (-1!1) ++ (-1!3) ++ (-1!1)
                , inf));
        var dem2 = Demand.ar(trig * block, 0,
            Dseq(
                    [0.01, 1].stutter(4)
                    // (0.01!1) ++ (1!7)
                    , inf));
        var sig = MiPlaits.ar(12 + 24 + 24 + 7 + dem.lag(dem2) + [0, 0.05] - 0,
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.2,
            trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0], sig[1][0]];
            // sig = LPF.ar(sig, 2500) * 0.8 * 0.25 * 1;
            // sig = sig * 1 * 0.25;
        // sig = sig.clip(-0.001, 0.001) * 16;
            sig = VadimFilter.ar(sig, 2000, 0, 1);
            // sig = LPF.ar(sig, 2000) * 1;
            // Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.75);
            Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 0.2);
    }.play.register;
});
};
~leadSqueak.();
)



// ------------------------------------------------------------
// leadSqueak un peu différent
// ------------------------------------------------------------

(
~leadSqueak = {
~nT.sched(~nT.timeToNextBeat(quant: 4), {

        // if(~rimz.isPlaying, {~rimz.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
        // ~drums.stop;
        if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    [~lead].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~lead = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 1;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * [3] * 1) * trigGate;
        var block = Demand.ar(trig, 0, Dseq([0, 0, 1].rotate(0), inf));
                var amp = EnvGen.ar(
                envelope: Env(
                    [0, 0, 1],
                    [0, 0.005],
                    ['lin', 'lin'],
                    releaseNode: 1,
                    loopNode: nil
                ),
        gate: trig * block,
        doneAction: 0
    );
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0,
            Dseq(
                (0!4) ++ (-1!4) ++ (-3!3) ++ (-1!1) ++ (-4!3) ++ (-4!1) ++
                (0!3) ++ ( 4!1) ++ ( 2!4) ++ (-3!3) ++ (-1!1) ++ (-1!3) ++ (-1!1)
                , inf));
        var dem2 = Demand.ar(trig * block, 0,
            Dseq(
                    [0.01, 1].stutter(4)
                    // (0.01!1) ++ (1!7)
                    , inf));
        var sig = MiPlaits.ar(24 + 24 + 24 + 7 + dem.lag(dem2) + [0, 0.05] - 0,
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.15,
            trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0], sig[1][0]];
        sig = LPF.ar(sig, 2500) * 0.8 * 0.25 * 1;
        sig = sig * 1 * 0.25;
        // sig = sig.clip(-0.001, 0.001) * 16;
            sig = LPF.ar(sig, 2000) * 2;
            // Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.25);
            Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 2);
    }.play.register;
});
};
// ~leadSqueak.();
)
