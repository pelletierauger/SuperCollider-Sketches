(
// ~drummy = {
    // | snareF = 12, hatF = 7 |
    SynthDef.new(\wtDrums, {
        | trigGate = 1 |
         var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var d5 = Demand.kr(trig, 0, Dseq(Dseries(0, 1/64, 32), inf)).lag(0);
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8] + 0.1, inf));
        var dec2 = Demand.kr(trig, 0, Dseq([0, -2].stutter(32), inf));
        var lin = EnvGen.kr(Env.circle([0.4, 0.3], [~nT.beatDur * 16, 0]));
        var note = Demand.kr(trig, 0, Dseq([0, -4].stutter(16 * 2), inf));
    var hatF = Demand.kr(trig, 0, Dseq([7, 12, 14, 15].stutter(1), inf));
    var snareF = Demand.kr(trig, 0 , Dseq([24 + 7, 24 + 7 + 4].stutter(16 * 2) + 12, inf));
        var sig = MiPlaits.ar(
            pitch: 28 + [0, snareF + 24, snareF + 24, 0 + hatF] + 0 + note,
            engine: [5, 9, 9, 5],
            harm: [0.25, 0.25, 0.25, 0.5] + 0.5,
            timbre: [1, 1, 1, 1] - 0,
            morph: 0.45 - [0, -0.4, -0.4, -0.5] - 0.4,
            trigger: [block0, block1, block1, block2],
            decay: [1.3, 0.8, 0.8, dec * 1] * 0.75,
            lpg_colour: [0, 0.75, 0.75, 0],
            // morph_mod: d5 * -1
        );
        var kickhat = sig[0][1] * 4 + (sig[3][1] * 1.5);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 1 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.5 * 1;
    Out.ar(~rev, sig);
}).add;
 ~rattleTask.stop;

~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // if(~rattleDrum.isPlaying, {~rattleDrum.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    // if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});

    if(~wtDrums.isPlaying, {~wtDrums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~wtDrums = Synth(\wtDrums).register;
});
)


(
// ~drummy = {
    // | snareF = 12, hatF = 7 |
 ~rattleTask.stop;

~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~rattleDrum.isPlaying, {~rattleDrum.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});

    if(~wtDrums.isPlaying, {~wtDrums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~wtDrums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var d5 = Demand.kr(trig, 0, Dseq(Dseries(0, 1/64, 32), inf)).lag(0);
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8] + 0.1, inf));
        var dec2 = Demand.kr(trig, 0, Dseq([0, -2].stutter(32), inf));
        var lin = EnvGen.kr(Env.circle([0.4, 0.3], [~nT.beatDur * 16, 0]));
        var note = Demand.kr(trig, 0, Dseq([0, -4].stutter(16 * 2), inf));
    var hatF = Demand.kr(trig, 0, Dseq([7, 7 + 4].stutter(16 * 2), inf));
    var snareF = Demand.kr(trig, 0 , Dseq([24 + 7, 24 + 7 + 4].stutter(16 * 2) + 12, inf));
        var sig = MiPlaits.ar(
            pitch: 28 + [0, snareF + 24, snareF + 24, 24 + hatF] + 0 + note,
            engine: [5, 9, 9, 5],
            harm: [0.25, 0.25, 0.25, 0.5]- 0,
            timbre: [1, 1, 1, 1] - 0,
            morph: 0.45 - [0, -0.4, -0.4, 0.4] - 0.4,
            trigger: [block0, block1, block1, block2],
            decay: [1.1, 0.8, 0.8, dec] * 0.75,
            lpg_colour: [0, 0.75, 0.75, 0],
            // morph_mod: d5 * -1
        );
        var kickhat = sig[0][1] * 4 + (sig[3][1] * 0.5);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 1 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.5 * 1;
    }.play(fadeTime: 0.01).register;
});
)





(
// ~drummy = {
    // | snareF = 12, hatF = 7 |
    SynthDef.new(\wtDrums, {
        | trigGate = 1 |
         var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 0, 1, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var d5 = Demand.kr(trig, 0, Dseq(Dseries(0, 1/64, 32), inf)).lag(0);
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8] + 0.1, inf));
        var dec2 = Demand.kr(trig, 0, Dseq([0, -2].stutter(32), inf));
        var lin = EnvGen.kr(Env.circle([0.4, 0.3], [~nT.beatDur * 16, 0]));
        var note = Demand.kr(trig, 0, Dseq([0, -4].stutter(16 * 2), inf));
    var hatF = Demand.kr(trig, 0, Dseq([7, 7 + 4].stutter(16 * 2), inf));
    var snareF = Demand.kr(trig, 0 , Dseq([24 + 7, 24 + 7 + 4].stutter(16 * 2) + 12, inf));
        var sig = MiPlaits.ar(
            pitch: 28 - 0 + [0, snareF + 24, snareF + 24, 24 + hatF] + 0 + note,
            engine: [5, 9, 9, 5],
            harm: [0.25, 0.25, 0.25, 0.5]- 0,
            timbre: [1, 1, 1, 1] - 0,
            morph: 0.45 - [0, -0.4, -0.4, 0.4] - 0.2,
            trigger: [block0, block1, block1, block2],
            decay: [2.1, 0.8, 0.8, dec] * 0.75,
            lpg_colour: [0, 0.75, 0.75, 0],
            // morph_mod: d5 * -1
        );
        var kickhat = sig[0][1] * 4 + (sig[3][1] * 0);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 0 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25 * 1;
    Out.ar(0, sig);
}).add;
 ~rattleTask.stop;

~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~rattleDrum.isPlaying, {~rattleDrum.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});

    if(~wtDrums.isPlaying, {~wtDrums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~wtDrums = Synth(\wtDrums).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, a, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, a, a] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 28 + ([1, 2, 2, 6] * 12),
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.75,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 0.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: env.clip(0, 1),
            controloffset: 0,
            controlscale: 1,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
    }.play(fadeTime: 0.01).register;
});
)