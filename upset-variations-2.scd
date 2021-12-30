~nT = TempoClock.new(86.972 / 60 * 2 * 1.5).permanent_(true);

~nT.tempo;
~nT.tempo = 2.7074408879193;
1.39 * 2 * 1.3 * -5.midiratio;

~nT.tempo = 86.972 / 60 * 2 * 1.5;

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 1].reverse.stutter(6 * 2 * 4), inf));
          var b = Demand.kr(trig, 0, Dseq([1, 1].stutter(6 * 2 * 4), inf));

        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 1, 0, 1, 0] * 1;
        var pat1 = [0, 0, 0, 1, 0, 0] ++ [0, 1, 0, 0, 1, 0]* 1;
        var pat2 = [1, 0, 1, 0, 1, 0].wrapExtend((12 * 1)) ++ [1, 1, 1, 1, 1, 1].stutter(2);
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
            decay: [0.9, 0.9, 0.9, dec ] * dd,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 2 + (sig[3][1] * 0.35 * b);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
                sig = (sig * 0.2) + LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur)).clip(0, 1),
            controloffset: 0.4,
            controlscale: 0.9,
            vca: 0.25,
            resonance: 0,
            lowpassmode: 0,
            linearity: 1
        ) * 1;
        // sig = MiRings.ar(sig, pit: 28 - 12);
        // sig = Decimator.ar(sig, 1100, 2) * 0.5;
        // sig = VadimFilter.ar(sig, 8000, 0, 1) * 1;
        // sig = sig * 0.125;


        // sig = VadimFilter.ar(sig, 3000, 0, 1) * 2;
        // sig = VadimFilter.ar(sig, 50, 0, 5);
    }.play(fadeTime: 0.01).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 1].reverse.stutter(6 * 2 * 4), inf));
          var b = Demand.kr(trig, 0, Dseq([1, 1].stutter(6 * 2 * 4), inf));

        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 1, 0, 1, 0] * 1;
        var pat1 = [0, 0, 0, 1, 0, 0] ++ [0, 1, 0, 0, 1, 0]* 1;
        var pat2 = [1, 0, 1, 0, 1, 0].wrapExtend((12 * 3)) ++ [1, 1, 1, 1, 1, 1].stutter(2);
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
            decay: [0.9, 0.9, 0.9, dec * 1.2 ] * dd,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 2 + (sig[3][1] * 0.25 * b);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
                sig = (sig * 0.2) + LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur)).clip(0, 1),
            controloffset: 0.4,
            controlscale: 0.9,
            vca: 0.25,
            resonance: 0,
            lowpassmode: 0,
            linearity: 1
        ) * 1;
        // sig = MiRings.ar(sig, pit: 28 - 12);
        // sig = Decimator.ar(sig, 1100, 2) * 0.5;
        // sig = VadimFilter.ar(sig, 8000, 0, 1) * 1;
        // sig = sig * 0.125;


        // sig = VadimFilter.ar(sig, 3000, 0, 1) * 2;
        // sig = VadimFilter.ar(sig, 50, 0, 5);
    }.play(fadeTime: 0.01).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 1].reverse.stutter(6 * 2 * 4), inf));
          var b = Demand.kr(trig, 0, Dseq([1, 1].stutter(6 * 2 * 4), inf));

        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 1, 0, 1, 0] * 1;
        var pat1 = [0, 0, 0, 1, 0, 0] ++ [0, 1, 0, 0, 1, 0]* 1;
        var pat2 = [1, 0, 1, 0, 1, 0].wrapExtend((12 * 1)) ++ [1, 1, 1, 1, 1, 1].stutter(2);
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var dd = Demand.kr(trig, 0, Dseq([0.65, 0.75].stutter(6), inf));
        var sig = MiPlaits.ar(
            pitch: 28 + ([1, 2, 2, 6] + 3 * 12),
            engine: 8,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0.125,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec ] * dd,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 2 + (sig[3][1] * 0.35 * 2 * b);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
                sig = (sig * 0.2) + LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur)).clip(0, 1),
            controloffset: 0.4,
            controlscale: 0.9,
            vca: 0.25,
            resonance: 0,
            lowpassmode: 0,
            linearity: 1
        ) * 1;
        // sig = MiRings.ar(sig, pit: 28 - 12);
        // sig = Decimator.ar(sig, 1100, 2) * 0.5;
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 1;
        // sig = sig * 0.125;


        // sig = VadimFilter.ar(sig, 3000, 0, 1) * 2;
        // sig = VadimFilter.ar(sig, 50, 0, 5);
    }.play(fadeTime: 0.01).register;
});
)