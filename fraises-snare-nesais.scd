(
~t.sched(~t.timeToNextBeat(quant: 4) + 0.1, {
    // [~billes2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~t.tempo * 4);
        var trig2 = Impulse.kr(~t.tempo * 4);
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 0, 0, 1, 0] ++ [0, 0, 0, 0, 0, 1, 0, 0];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 24, 24, 48 ] + 24 + 0,
            engine: 0,
            harm: 0.125,
            timbre: 0.5,
            morph: 0.45 - [0, 0.2, 0, 0] - 0.2,
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.7 * 4, 0.7 * 4, 0.3] * 0.1,
            lpg_colour: 0
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16) - 0, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [-8, -8]), gate: [block0, block1]).sum!2;

        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 1)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
                sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~t.beatDur * 1)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.4,
            vca: 0.2,
            resonance: 0,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        // sig = VadimFilter.ar(sig, 1500, 0, 5) * 2;
        sig = MiRings.ar(sig, pit: 12 + 5, damp: 0.9, model: 0);
        sig = VadimFilter.ar(sig, 1000, 0, 1);
        // sig = VadimFilter.ar(sig, ddd, 0.25, 1) * 2;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1 * 1 * 1 * 1;
    }.play(fadeTime: 0.01).register;
});
)



(
~t.sched(~t.timeToNextBeat(quant: 4) + 0.1, {
    // [~billes2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    if(~snare2.isPlaying, {~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~snare2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~t.tempo * 4);
        var trig2 = Impulse.kr(~t.tempo * 4);
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 0, 0, 1, 0] ++ [0, 0, 0, 0, 0, 1, 0, 0];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 24, 24, 48 + 24 + 24 ] + 0 + 0,
            engine: 9,
            harm: 0.125,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, -0.4] - 0.2,
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9 * 4, 0.7 * 4, 0.7 * 4, 0.3 * 4] * 0.2,
            lpg_colour: 0
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16) - 0, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: [block0, block1]).sum!2;

        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 1)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 1)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.2,
            vca: 0.2,
            resonance: 0,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        // sig = VadimFilter.ar(sig, 1500, 0, 5) * 2;
        // sig = MiRings.ar(sig, pit: 12 + 5, damp: 0.9, model: 0);
        // sig = VadimFilter.ar(sig, 1000, 0, 1);
        // sig = VadimFilter.ar(sig, ddd, 0.25, 1) * 2;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1 * 1 * 2 * 1;
    }.play(fadeTime: 0.01).register;
});
)
