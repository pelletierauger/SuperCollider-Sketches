
(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);
    ~drumTask.stop;
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [0, 0, 0, a, 0, 0, 1, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, a, a];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 28 + ([0, 1, 1, 6] + -2 * 12),
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9 * 2, 0.9, 0.9, dec * 2] * 0.25,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 12 * 2 + (sig[3][1] * 0.25);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * 4 * snareFix;
        env = CombC.kr(env.pow(7), 1, ~nT.beatDur * 0.125 * 0.125 * 0.125, ~nT.beatDur * 0.5);
        env = DelayN.kr(env, 1, ~nT.beatDur);
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        sig = VadimFilter.ar(sig, 50, 0, 5) * 1;
        sig = LPG.ar(
            input: sig * 0.75,
            controlinput: env.clip(0, 1),
            controloffset: 0.25,
            controlscale: 0.5,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        ) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.5;
    }.play(fadeTime: 0.01).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
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
            pitch: 28 + ([1, 2, 2, 6] - 1 * 12),
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
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
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
            pitch: 28 + ([1, 2, 2, 6] - 1 * 12),
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.25,
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
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
    }.play(fadeTime: 0.01).register;
});
)


(
if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
~basse.set(\relGate, 3, \trigGate, 0);
)



//   1       2       3       4       1       2       3       4
//   |.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.
// E ----------------------------------------------------------------
// B ----------------------------------------------------------------
// G ----------------------------------------------------------------
// D ----------------------------------------------------------------
// A ----------------------------------------------------------------
// D 2---2---2---2---3---3---3---3---2---2---2---2---0---0---0---0---


//   1       2       3       4       1       2       3       4
//   |.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.
// E ----------------------------------------------------------------
// B ----------------------------------------------------------------
// G ----------------------------------------------------------------
// D ----------------------------------------------------------------
// A ----------------------------------------------------------------
// D 9---9---9---9---7---7---7---7---10--10--10--10--12--12--12--12--


//   1       2       3       4       1       2       3       4
//   |.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.
// E ----0-------0-------0-------0-------0-------0-------0-------0---
// B 5-------5-------6-------6-------8-------8-------3-------3-------
// G ----------------------------------------------------------------
// D ----------------------------------------------------------------
// A ----------------------------------------------------------------
// D ----------------------------------------------------------------


//   1       2       3       4       1       2       3       4
//   |.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.
// E ----------------------------------------------------------------
// B ----0-------0-------0-------0-------0-------0-------0-------0---
// G 7-------7-------5-------5-------9-------9-------9-------9-------
// D ----------------------------------------------------------------
// A ----------------------------------------------------------------
// D ----------------------------------------------------------------