(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
            pitch: 28 + ([1, 2, 2, 6] + 1 * 12),
            engine: 10,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.25,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        var mm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        mm = Demand.kr(trig, 0, Dwhite(0, 0.3, inf)).lag(0.1);
        sig = (sig * mm) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 2;
        sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.1) * 4;

        // sig = sig * 0.5 + (MiRings.ar(
            // sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;

    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
            pitch: 28 + ([1, 2, 2, 6] + 1 * 12),
            engine: 10,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.5,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        var mm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        mm = Demand.kr(trig, 0, Dwhite(0, 0.3, inf)).lag(0.1);
        sig = (sig * mm) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 2;
        sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.1) * 4;

        // sig = sig * 0.5 + (MiRings.ar(
            // sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;

    }.play(fadeTime: 0.01).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
            pitch: 28 + ([1, 2, 2, 6] + 1 * 12),
            engine: 10,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.75,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        var mm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        mm = Demand.kr(trig, 0, Dwhite(0, 0.3, inf)).lag(0.1);
        sig = (sig * mm) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 2;
        sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.1) * 4;

        // sig = sig * 0.5 + (MiRings.ar(
            // sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;

    }.play(fadeTime: 0.01).register;
});
)





(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums23.isPlaying, {~drums23.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums23 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
            pitch: 28 + ([1, 2, 2, 6] + 1 * 12),
            engine: 10,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.75,
            timb_mod: -0.35,
            morph_mod: 0.85,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        var mm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        mm = Demand.kr(trig, 0, Dwhite(0, 0.3, inf)).lag(0.1);
        sig = (sig * mm) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 2;
        sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.1) * 1;

        // sig = sig * 0.5 + (MiRings.ar(
            // sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;

    }.play(fadeTime: 0.01).register;
});
)






(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
            pitch: 28 + ([1, 2, 2, 6] + 1 * 12),
            engine: 10,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.75,
            timb_mod: -0.35,
            morph_mod: 0.85,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        var mm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        mm = Demand.kr(trig, 0, Dwhite(0, 0.3, inf)).lag(0.1);
        sig = (sig * mm) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 2;
        sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.1) * 4;

        sig = sig * 0 + (MiRings.ar(
            sig, pit: 30 + 12, struct: x, damp: 0.2, bright: 0.5, pos: y, model: 4) * 2) * 0.5;

    }.play(fadeTime: 0.01).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
            pitch: 28 + ([1, 2, 2, 5] + -1 * 12),
            engine: [13, 14, 14, 15],
            harm: 0.5,
            timbre: 0.5,
            morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.5,
            timb_mod: -0.35,
            morph_mod: 0.85,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: [block0, block1]).sum!2;
        var hat = (sig[3][1] * 1);
        var kickhat = sig[0][1] * 6 + hat;
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        var mm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5 + (hat * 0);
        mm = Demand.kr(trig, 0, Dwhite(0, 0.3, inf)).lag(0.1);
        sig = (sig * mm) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 2;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.3) * 1;
        // sig = VadimFilter.ar(sig, 3000, 0, 1);
        // sig = sig * 0.5 + (MiRings.ar(
            // sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;

    }.play(fadeTime: 0.01).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
        var sig = MiBraids.ar(
            pitch: 28 + ([1, 2, 2, 5] + 0 * 12),
            model: [34, 36, 36, 36],
            color: 0.75,
            timbre: 0.75,
            // morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trig: [block0, block1, block1, block2],
            resamp: 0,
            decim: 14,
            bits: 2,
            ws: 0.75
            // decay: [0.9, 0.9, 0.9, dec] * 0.5,
            // timb_mod: -0.35,
            // morph_mod: 0.85,
            // lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block1]).sum!2;
        var hat = (sig[3] * 1);
        var kickhat = sig[0] * 6 + hat;
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1], sig[2]] * 3 * snareFix;
        var mm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5 + (hat * 0);
        mm = Demand.kr(trig, 0, Dwhite(0, 0.3, inf)).lag(0.1);
        sig = (sig * (0.3 + mm)) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 2;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.3) * 1;
        // sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = sig * 0.5 + (MiRings.ar(
            // sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;

    }.play(fadeTime: 0.0).register;
});
)
