MiElements




(   // some bowing
~nT.sched(~nT.timeToNextBeat(quant: 8), {
{
    | trigGate = 1, relGate = 0 |
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
    var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));

    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, 0]), t).lag(0.95);

    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + d.lag(0.95),
        contour: 0.5,
        bow_level: e,
        bow_timb: 0.5,
        geom: 0.5,
        bright: 0.5,
        damp: 0.2,
        pos: 0.2,
        space: 0.3,
        model: 2
    );
    sig = sig * 8;
    sig;
}.play;
});
)



(   // some bowing
~nT.sched(~nT.timeToNextBeat(quant: 8), {
{
    | trigGate = 1, relGate = 0 |
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
    var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));

    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, 0]), t).lag(0.95);

    var sig = MiElements.ar(
        gate: 1,
        pit: 28 + 12 + d.lag(0.95),
        contour: 0.5,
        bow_level: e,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.75,
        damp: 0.2,
        pos: 0.4,
        space: 0.3,
        model: 2
    );
    sig = sig * 8;
    sig;
}.play;
});
)



(   // some bowing
~nT.sched(~nT.timeToNextBeat(quant: 8), {
{
    | trigGate = 1, relGate = 0 |
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
    var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));

    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, 0]), t).lag(0.95);

    var sig = MiElements.ar(
        gate: 1,
        pit: 28 + 24 + d.lag(0.95),
        contour: 0.5,
        bow_level: e,
        bow_timb: 0.5,
        geom: 0.25,
            geom: Demand.kr(t, 0, Dseq([0.25, 0.35].reverse, inf)),
        bright: 0.75,
        damp: 0.2,
        pos: 0.4,
        space: 0.3,
        model: 2
    );
        sig = VadimFilter.ar(sig, 100, 0, 5);
    sig = sig * 8;
    sig;
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    // if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drumssz.isPlaying, {~drumssz.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drumssz = {
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
            pitch: 28 + ([0, 1, 1, 6] + 2 * 12),
            engine: 10,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9 * 2, 0.9, 0.9, dec * 4] * 0.25,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.85);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        env = CombC.kr(env, 1, ~nT.beatDur * 0.125 * 0.125, ~nT.beatDur * 0.5);
        env = DelayN.kr(env, 1, ~nT.beatDur);
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: env.pow(7).clip(0, 1),
            controloffset: 0,
            controlscale: 1,
            vca: 0.25,
            resonance: 1,
            lowpassmode: 1,
            linearity: 1
        ) * 0.25;
        // sig = VadimFilter.ar(sig, 7000, 0, 1) * 1;
    }.play(fadeTime: 0.01).register;
});
)





(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    // if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drumss.isPlaying, {~drumss.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drumss = {
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
            pitch: 28 + ([0, 1, 1, 6] + 2 * 12),
            engine: 10,
            harm: 0.25,
            timbre: 0.7,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9 * 2, 0.9, 0.9, dec * 4] * 0.25,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.85);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        env = CombC.kr(env, 1, ~nT.beatDur * 0.125 * 0.125, ~nT.beatDur * 0.5);
        env = DelayN.kr(env, 1, ~nT.beatDur);
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: env.pow(7).clip(0, 1),
            controloffset: 0,
            controlscale: 1,
            vca: 0.25,
            resonance: 1,
            lowpassmode: 1,
            linearity: 1
        ) * 0.5;
        // sig = MiRings.ar(sig, pit: 28, struct: 0.25, model: 4) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 1;
    }.play(fadeTime: 0.01).register;
});
)






(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    // if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drumssz.isPlaying, {~drumssz.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drumssz = {
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
            pitch: 28 + ([0, 1, 1, 6] + 2 * 12),
            engine: 10,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9 * 2, 0.9, 0.9, dec * 4] * 0.25,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.85);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        env = CombC.kr(env, 1, ~nT.beatDur * 0.125 * 0.125, ~nT.beatDur * 0.5);
        env = DelayN.kr(env, 1, ~nT.beatDur);
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = sig * LPG.ar(
            input: sig,
            controlinput: env.pow(7).clip(0, 1),
            controloffset: 0,
            controlscale: 1,
            vca: 0.25,
            resonance: 1,
            lowpassmode: 1,
            linearity: 1
        ) * 0.25 * 0.5;
        // sig = VadimFilter.ar(sig, 7000, 0, 1) * 1;
    }.play(fadeTime: 0.01).register;
});
)

