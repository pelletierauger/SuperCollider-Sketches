(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 1, 0] ++ [0, 0, a, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 1, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var env2 = EnvGen.kr(Env.circle([0.5, 1], [~nT.beatDur * 8 - 0.2, 0.2])).lag(0.1);

        var sig = MiPlaits.ar(
            pitch: 28 + ([1, 2, 2, 6] * 12),
            engine: 9,
            harm: 0.25,
            timbre: 0.5,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] + 0.5,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec * 1] * 0.5 * env2,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 3 + (sig[3][1] * 0.5);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        // sig = sig * MiRings.ar(sig, pit: 76 - (4 * 12), model: 0);
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        // env2.poll;
        sig = VadimFilter.ar(sig, 50, 0, 5);
        sig = LPG.ar(
            input: sig * 1,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 1.5)).clip(0, 1),
            controloffset: 0.3 * env2,
            controlscale: env2,
            vca: 0.75,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5 * 2;
    }.play(fadeTime: 0.01).register;
});
)
