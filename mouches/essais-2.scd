(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
[~rim, ~rim2, ~lead, ~billes6, ~billes32, ~billes42].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 30)});});
if(~crushedNoiseDry.isPlaying, {~crushedNoiseDry.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~billes6 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
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
        var sig = MiPlaits.ar(24 + [0, 0.05, 12, 12.05, 19, 19.05],
            engine: 11,
            harm: 0.25,
            timbre: 0.125,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            // morph: 0.4,
            trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0] + sig[2][0] + sig[4][0], sig[1][0] + sig[3][0] + sig[5][0]];
        sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;
        sig = sig * 0.5 * 4;

        Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.5);
        Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 1);
    }.play.register;
});
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes32].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes32 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo * [1] * 1) * trigGate;
        var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig, 0, Dseq([0, 0, 2, 2].stutter(8), inf));
        var sig = MiPlaits.ar(60 + 0 + 0 + dem + [0, 0.05, 12, 12.05],
            engine: 11,
            harm: 0.25,
            timbre: 0.25,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            morph: 0.4,
            trigger: trig * Demand.ar(trig, 0, Dseq(
                (1!9 ++ (0!7)), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25);
                sig = [sig[0][0] + [sig[2][0]], sig[1][0] + sig[3][0]];
        // sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;

        sig = sig * 0.5;
                sig = sig.clip(-0.001, 0.001) * 16;
            sig = LPF.ar(sig, 2000) * 4;
        // sig;
                Out.ar(0, sig * XLine.ar(0.001, 1, 0.005));
        Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005));
    }.play.register;

    [~billes42].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes42 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 1;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * [3] * 1) * trigGate;
        var block = Demand.ar(trig, 0, Dseq([1, 1, 0], inf));
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0, Dseq([0, 0, -5, -5].stutter(8), inf));
        var sig = MiPlaits.ar(60 + 0 + 0 - 5 + dem + [0, 0.05, 12, 12.05],
            engine: 11,
            harm: 0.25,
            timbre: 0.125,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            morph: 0.4,
            trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
                sig = [sig[0][0] + [sig[2][0]], sig[1][0] + sig[3][0]];
        sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;

        sig = sig * 0.5;
                sig = sig.clip(-0.001, 0.001) * 16;
            sig = LPF.ar(sig, 2000) * 4;
        // sig;
                        Out.ar(0, sig * XLine.ar(0.001, 1, 0.005));
        Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005));
    }.play.register;
});
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~rim = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1, 1, 1, 1, 0, 0, 1, 0];
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq(0.75!24 ++ (0.75!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-12!16 ++ (0!16), inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: [ 48, 60, 60, 84 ] - 12 + pit + 12,
            engine: 9,
            harm: 0.9,
            timbre: [0.5, 1, 1, 0.5].rotate(0),
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2],
            decay: 0.3 + [0.9, 0.6, 0.6, 0.7] * dec,
            lpg_colour: 0
        );
        var envBl = EnvGen.kr(Env([0, 0, 1], [0.5, 0.01]));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * envBl;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = LPF.ar(sig, 4000);
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 0.5;
        Out.ar(0, sig);
    }.play(fadeTime: 0.01).register;
});
)