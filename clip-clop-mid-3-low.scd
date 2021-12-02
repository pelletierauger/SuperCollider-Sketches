(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 4)});
    ~snare = {

        | trigGate = 1 |
                var tempo = ~nT.tempo;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [0.75, 1.25];
        // var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var swungPulse = Impulse.kr(swungTempo) * trigGate;

        // var swungPulse = Impulse.kr(~nT.tempo * 1);
        var pat0 = [1, 0, 0, 1, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 1, 0, 0];
        var pat2 = [1];
        var block0 = Demand.kr(swungPulse, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(swungPulse, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(swungPulse, 0, Dseq(pat2, inf));
        var dm = Demand.kr(swungPulse * block2, 0, Dseq([0.7, 0.6], inf));
                var dd = Demand.kr(swungPulse, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(swungPulse, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + -2,
            engine: 9,

            harm: 0.75,
            timbre: [0.5, 0.5, 0.5, 0.25]  + 0.5,
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: swungPulse * [block0, block1, block1, block2].rotate(0) * trigGate,
            decay: [0.9, 0.85, 0.85, 0.7] * 0.5 * -2.midiratio.reciprocal,
            lpg_colour: 0.25,
            // fm_mod: -0.75,
            morph_mod: 0.25,
            timb_mod: dd * [-0.5, -0.5, -0.5, 0]
        );

        var sig2 = DelayN.ar([sig[1][1], sig[2][1]], 0.1, 0.01 * -2.midiratio.reciprocal) * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.125)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1.44;
        // Amplitude.ar(sig).poll;
        // sig * Line.kr(0.7, 1, 1);
    }.play(fadeTime: 0.005).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare2.isPlaying, {~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 4)});
    ~snare2 = {

        | trigGate = 1 |
                var tempo = ~nT.tempo;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [0.75, 1.25];
        // var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var swungPulse = Impulse.kr(swungTempo) * trigGate;

        // var swungPulse = Impulse.kr(~nT.tempo * 1);
        var pat0 = [1, 0, 0, 1, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 1, 0, 0];
        var pat2 = [1];
        var block0 = Demand.kr(swungPulse, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(swungPulse, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(swungPulse, 0, Dseq(pat2, inf));
        var dm = Demand.kr(swungPulse * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + 12 - 2,
            engine: 9,

            harm: 0.75,
            timbre: [0.5, 0.5, 0.5, 0.25]  + 0.5,
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: swungPulse * [block0, block1, block1, block2].rotate(0) * trigGate,
            decay: [0.9, 0.85, 0.85, 0.7] * 0.5 * -2.midiratio.reciprocal,
            lpg_colour: 0.25
        );
        var dd = Demand.kr(swungPulse, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(swungPulse, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = DelayN.ar([sig[1][1], sig[2][1]], 0.1, 0.01 * -2.midiratio.reciprocal) * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.125)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1;
        // Amplitude.ar(sig).poll;
        // sig * Line.kr(0.7, 1, 1);
    }.play(fadeTime: 0.005).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 4)});
    ~snare = {

        | trigGate = 1 |
                var tempo = ~nT.tempo;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [0.75, 1.25];
        // var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var swungPulse = Impulse.kr(swungTempo) * trigGate;

        // var swungPulse = Impulse.kr(~nT.tempo * 1);
        var pat0 = [1, 0, 0, 1, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 1, 0, 0];
        var pat2 = [1];
        var block0 = Demand.kr(swungPulse, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(swungPulse, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(swungPulse, 0, Dseq(pat2, inf));
        var dm = Demand.kr(swungPulse * block2, 0, Dseq([0.7, 0.6], inf));
                var dd = Demand.kr(swungPulse, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(swungPulse, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + -4,
            engine: 9,

            harm: 0.75,
            timbre: [0.5, 0.5, 0.5, 0.25]  + 0.3,
            morph: 0.5 - [0, 0.2, 0, 0],
            trigger: swungPulse * [block0, block1, block1, block2].rotate(0) * trigGate,
            decay: [0.9, 0.85, 0.85, 0.7] * 0.5 * -2.midiratio.reciprocal,
            lpg_colour: 0.25,
            // fm_mod: -0.75,
            morph_mod: 0.25,
            timb_mod: dd * [-0.5, -0.5, -0.5, 0]
        );

        var sig2 = DelayN.ar([sig[1][1], sig[2][1]], 0.1, 0.01 * -2.midiratio.reciprocal) * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.125)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1.44;
        // Amplitude.ar(sig).poll;
        // sig * Line.kr(0.7, 1, 1);
    }.play(fadeTime: 0.005).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare2.isPlaying, {~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 4)});
    ~snare2 = {

        | trigGate = 1 |
                var tempo = ~nT.tempo;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [0.75, 1.25];
        // var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var swungPulse = Impulse.kr(swungTempo) * trigGate;

        // var swungPulse = Impulse.kr(~nT.tempo * 1);
        var pat0 = [1, 0, 0, 1, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 1, 0, 0];
        var pat2 = [1];
        var block0 = Demand.kr(swungPulse, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(swungPulse, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(swungPulse, 0, Dseq(pat2, inf));
        var dm = Demand.kr(swungPulse * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + 12 - 4,
            engine: 9,

            harm: 0.75,
            timbre: [0.5, 0.5, 0.5, 0.25]  + 0.3,
            morph: 0.5 - [0, 0.2, 0, 0],
            trigger: swungPulse * [block0, block1, block1, block2].rotate(0) * trigGate,
            decay: [0.9, 0.85, 0.85, 0.7] * 0.5 * -2.midiratio.reciprocal,
            lpg_colour: 0.25
        );
        var dd = Demand.kr(swungPulse, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(swungPulse, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = DelayN.ar([sig[1][1], sig[2][1]], 0.1, 0.01 * -2.midiratio.reciprocal) * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.125)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1;
        // Amplitude.ar(sig).poll;
        // sig * Line.kr(0.7, 1, 1);
    }.play(fadeTime: 0.005).register;
});
)



(
var pause = 8;
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 4)});
    ~snare = {

        | trigGate = 1 |
                var tempo = ~nT.tempo;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [0.75, 1.25];
        // var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var swungPulse = Impulse.kr(swungTempo) * trigGate;

        // var swungPulse = Impulse.kr(~nT.tempo * 1);
        var pat0 = ([1, 0, 0, 1, 0, 1, 0, 0] ++ (0!pause)).rotate(8);
        var pat1 = ([0, 0, 1, 0, 0, 1, 0, 0] ++ (0!pause)).rotate(8);
        var pat2 = [1];
        var block0 = Demand.kr(swungPulse, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(swungPulse, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(swungPulse, 0, Dseq(pat2, inf));
        var dm = Demand.kr(swungPulse * block2, 0, Dseq([0.7, 0.6], inf));
                var dd = Demand.kr(swungPulse, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(swungPulse, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + -4,
            engine: 9,

            harm: 0.75,
            timbre: [0.5, 0.5, 0.5, 0.25]  + 0.3,
            morph: 0.5 - [0, 0.2, 0, 0],
            trigger: swungPulse * [block0, block1, block1, block2].rotate(0) * trigGate,
            decay: [0.9, 0.85, 0.85, 0.7] * 0.5 * -2.midiratio.reciprocal,
            lpg_colour: 0.25,
            // fm_mod: -0.75,
            morph_mod: 0.25,
            timb_mod: dd * [-0.5, -0.5, -0.5, 0]
        );

        var sig2 = DelayN.ar([sig[1][1], sig[2][1]], 0.1, 0.01 * -2.midiratio.reciprocal) * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.125)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1.44;
        // Amplitude.ar(sig).poll;
        // sig * Line.kr(0.7, 1, 1);
    }.play(fadeTime: 0.005).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare2.isPlaying, {~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 4)});
    ~snare2 = {

        | trigGate = 1 |
                var tempo = ~nT.tempo;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [0.75, 1.25];
        // var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var swungPulse = Impulse.kr(swungTempo) * trigGate;

        // var swungPulse = Impulse.kr(~nT.tempo * 1);
        var pat0 = ([1, 0, 0, 1, 0, 1, 0, 0] ++ (0!pause)).rotate(8);
        var pat1 = ([0, 0, 1, 0, 0, 1, 0, 0] ++ (0!pause)).rotate(8);
        var pat2 = [1];
        var block0 = Demand.kr(swungPulse, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(swungPulse, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(swungPulse, 0, Dseq(pat2, inf));
        var dm = Demand.kr(swungPulse * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + 12 - 4,
            engine: 9,

            harm: 0.75,
            timbre: [0.5, 0.5, 0.5, 0.25]  + 0.3,
            morph: 0.5 - [0, 0.2, 0, 0],
            trigger: swungPulse * [block0, block1, block1, block2].rotate(0) * trigGate,
            decay: [0.9, 0.85, 0.85, 0.7] * 0.5 * -2.midiratio.reciprocal,
            lpg_colour: 0.25
        );
        var dd = Demand.kr(swungPulse, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(swungPulse, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = DelayN.ar([sig[1][1], sig[2][1]], 0.1, 0.01 * -2.midiratio.reciprocal) * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.125)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1;
        // Amplitude.ar(sig).poll;
        // sig * Line.kr(0.7, 1, 1);
    }.play(fadeTime: 0.005).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block0, block1, timbre0, timbre1;
        trig = Impulse.kr(~nT.tempo);
        block0 = Demand.kr(trig, 0, Dseq([1] ++ (0!31), inf));
        block1 = Demand.kr(trig, 0, Dseq((0!16) ++ [1] ++ (0!15), inf));
        timbre0 = Demand.kr(trig * block0, 0, Dseq([0, -2].stutter(1), inf));
        timbre1 = Demand.kr(trig * block1, 0, Dseq([0, -2].stutter(1), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.05;
        n = (~nT.tempo / 32).reciprocal;
        // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        env = EnvGen.kr(Env([0, 1, 0], [r, n - r]), [block0, block1]);
        sig = MiBraids.ar(
            pitch: [12, 5] + [timbre0, timbre1] + 67 - 5,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 11,
            resamp: 2,
            decim: 2,
            bits: [4, 4],
            ws: 0.5
        ) * env * [1, 2] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 1000, 0, 1) * 4;
        sig + (sig.reverse * 0.25) * 1.75;
    }.play(fadeTime: 0).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8) + (~nT.beatDur * 0), {

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n;
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 16).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: [10, 0],
            timbre: 0.25,
            color: [0.95, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: [4, 3],
            ws: 0
        ) * [env * 0.5, 1 - env];
        sig = VadimFilter.ar(sig, 3700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 5000, 0, 1) * 4;
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig!2 * 1 * 1;
    }.play(fadeTime: 0.01).register;
});
)