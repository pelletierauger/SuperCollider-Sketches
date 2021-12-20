~nT = TempoClock.new(2.7074408879193).permanent_(true);

~nT.tempo = 86.972 / 60 * 2 * 1.5;
~nT.tempo = 86.972 / 60 * 2 * 1.25;

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~drums2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq(((0!3) ++ (1!1)).stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, a, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, a, a] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var ddd = Demand.kr(trig2, 0, Dseq(2!1 ++ (1!27) ++ (1.5!4), inf));
        var sig = MiPlaits.ar(
            pitch: 28 + [0, 12, 12, 36 + -12 + 12] + 12,
            engine: [9, 9, 9, 9],
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.3] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec * ddd * 0.75] * 0.75,
            lpg_colour: 0
        );
        var kickhat = sig[0][1] * 4 + (sig[3][1] * 0.45);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 1 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 2) * 0.5;
        sig = VadimFilter.ar(sig, 6000, 0, 1) * 0.25;
    }.play(fadeTime: 0.01).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var ddd = Demand.kr(trig2, 0, Dseq(2!1 ++ (1!27) ++ (1.5!4), inf));
        var sig = MiPlaits.ar(
            pitch: 28 + [-36, 0, 0.1, 36 + -12 + 12] + 12,
            engine: [9, 9, 9, 10] - 3,
            harm: 0.125,
            timbre: 0.75,
            morph: 0.45 - [0, 0.2, 0.1, 0.3] + 0.5,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec * ddd * 0.75] * 0.75,
            lpg_colour: 0
        );
        var kickhat = sig[0][1] * 1 + (sig[3][1] * 0.75);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 1 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 1 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 2) * 0.5;
        sig = VadimFilter.ar(sig, 12000, 0, 1) * 0.125;
    }.play(fadeTime: 0.01).register;
});
)





(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    y.set(\gate, 0, \fadeTime, 0.1);
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var ddd = Demand.kr(trig2, 0, Dseq(2!1 ++ (1!27) ++ (1.5!4), inf));
        var sig = MiPlaits.ar(
            pitch: 28 + [-36, 0 - 24, 0.1 - 24, 36 + -12 + 12] + -12 + 24,
            engine: [9, 9, 9, 10] - 3,
            harm: 0.5,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.3] + 0.5,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec * ddd * 0.75] * 0.75,
            lpg_colour: 0
        );
        var kickhat = sig[0][1] * 1 + (sig[3][1] * 0.75);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 1 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 0.4 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 2) * 0.5;
        sig = VadimFilter.ar(sig, 12000, 0, 1) * 0.125;
    }.play(fadeTime: 0.01).register;
});
)
