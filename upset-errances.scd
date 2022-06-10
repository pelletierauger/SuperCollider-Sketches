(
~t.sched(~t.timeToNextBeat(quant: 4), {
    y.set(\gate, 0, \fadeTime, 0.1);
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~t.tempo * 1 * 2) * trigGate;
        var trig2 = Impulse.kr(~t.tempo * 2 * 2) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 1].reverse.stutter(6 * 2 * 4), inf));
        var b = Demand.kr(trig, 0, Dseq([1, 1].stutter(6 * 2 * 4), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 1, 0, 1, 0] ++ [1, 0, 1, 0, 0, 0] * 1;
        var pat1 = [0, 0, 0, 1, 0, 0] ++ [0, 1, 0, 0, 1, 0] * 1;
        var pat2 = [1, 0, 1, 0, 1, 0].wrapExtend(12) ++ [1, 1, 1, 1, 1, 1].stutter(2);
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var dd = Demand.kr(trig, 0, Dseq([0.65, 0.75].stutter(6), inf));
        var sig = MiPlaits.ar(
            pitch: 28 + ([1, 2, 2, 6] - 2 * 12),
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0.125,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec ] * dd * 1,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.25], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 2 + (sig[3][1] * 0.35 * b * 1);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 1.5)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.2,
            vca: 0.25,
            resonance: 0,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        // sig = VadimFilter.ar(sig, 1000, 0, 5);
    }.play(fadeTime: 0.01).register;
});
)