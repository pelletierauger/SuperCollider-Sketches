(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~sableQuiGrince.();
    // [~lead].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});

    if(~rimw.isPlaying, {~rimw.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~rimw = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 4;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [1, 1];
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        var pat0 = [1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0].rotate(8);
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0].rotate(8);
        var pat2 = [1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0].rotate(8);
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var tuned = Demand.ar(trig, 0, Dseq([0, -1].stutter(16)));
        var dec = Demand.ar(trig, 0, Dseq(0.75!24 ++ (0.75!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-24!16 ++ (-24!16) - 12, inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: [ 48, 60, 60, 84 ] - 12 + pit + 12 + tuned,
            engine: 9,
            harm: 0.0,
            timbre: [0.5, 1, 1, 0.5].rotate(2),
            morph: 0.85 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2],
            decay: 0.2 + [0.9, 0.6, 0.6, 0.7] * dec * 0.75,
            lpg_colour: 0
        );
        var envBl = EnvGen.kr(Env([0, 0, 1], [0.5, 0.01]));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * 2 * envBl;
        sig2 = [sig[0][1] * 2 + (sig[3][1] * 2)]!2 + sig2;
        // sig = LPF.ar(sig, 4000);
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig2 = sig2 * 3.6 * 0.5 * 0.5 * XLine.ar(0.001, 1, 0.005);
        Out.ar(0, sig2);
        Out.ar(~bu, [sig[1][1], sig[2][1]] * 1.5 * 16 * envBl * 0.125);
    }.play(fadeTime: 0.01).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 4) + 0.0, {

    [~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~billes6 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 1;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.kr(tempo * [3] * 1) * trigGate;
        var block = Demand.kr(trig, 0, Dseq([0, 0, 1].rotate(1), inf));
        var trr = trig * block * Demand.kr(trig, 0, Dseq(1!12 ++ (0!12), inf));
        var tuned = Demand.kr(trr, 0, Dseq([0, -1].stutter(4), inf));
        var strumTrig = DelayN.ar(trr, 0.5,
            [0, 0.01, 0.02].stutter(2) * SinOsc.ar(0.1).range(1, 2)
        );
        var sig = MiPlaits.ar(
            pitch: 24 + [0, 0.05, 12, 12.05, 19, 19.05] + tuned,
            engine: 11,
            harm: 0.0,
            timbre: 0.85,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            // morph: [0.5, 0.7, 0.9].stutter(2),
            morph: 0,
            trigger: strumTrig,
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        ) * [1, 0.7, 0.5].stutter(2) * 0.25;
        sig = [sig[0][0] + sig[2][0] + sig[4][0], sig[1][0] + sig[3][0] + sig[5][0]];
        sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;
        sig = sig * 2 * 4 * envGate;

        // Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * SinOsc.ar(0.1).range(0, 0.125));
        Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 1);
    }.play.register;
});
)