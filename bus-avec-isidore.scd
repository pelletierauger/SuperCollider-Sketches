(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~rimw.isPlaying, {~rimw.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~rimw = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [1, 1];
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        var pat0 = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0].rotate(8);
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
            harm: 0.9,
            timbre: [0.5, 1, 1, 0.5].rotate(2),
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2],
            decay: 0.2 + [0.9, 0.6, 0.6, 0.7] * dec * 0.95,
            lpg_colour: 0
        );
        var envBl = EnvGen.kr(Env([0, 0, 1], [0.5, 0.01]));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * 4 * envBl;
        sig2 = [sig[0][1] * 4 + (sig[3][1] * 4)]!2 + sig2;
        // sig = LPF.ar(sig, 4000);
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig2 = sig2 * 3.6 * 0.125 * 1 * XLine.ar(0.001, 1, 0.005);
        Out.ar(0, sig2);
        // Out.ar(~bu, [sig[1][1], sig[2][1]] * 1.5 * 16 * envBl * 0.125);
    }.play(fadeTime: 0.01).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~mudTrashDrum.isPlaying, {~mudTrashDrum.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~mudTrashDrum = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 4;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [1, 1];
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        var pat0 = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0].rotate(8);
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
            harm: 0.9,
            timbre: [0.5, 1, 1, 0.5].rotate(0),
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2],
            decay: 0.2 + [0.9, 0.6, 0.6, 0.7] * dec * 0.95,
            lpg_colour: 0
        );
        var envBl = EnvGen.kr(Env([0, 0, 1], [0.5, 0.01]));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * 4 * envBl;
        sig2 = [sig[0][1] * 4 + (sig[3][1] * 4)]!2 + sig2;
        // sig = LPF.ar(sig, 4000);
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig2 = sig2 * 3.6 * 0.25 * 1 * XLine.ar(0.001, 1, 0.005);
        Out.ar(0, sig2);
        // Out.ar(~bu, [sig[1][1], sig[2][1]] * 1.5 * 16 * envBl * 0.125);
    }.play(fadeTime: 0.01).register;
});
)


(
if(~rimw.isPlaying, {~rimw.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
if(~mudTrashDrum.isPlaying, {~mudTrashDrum.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
)