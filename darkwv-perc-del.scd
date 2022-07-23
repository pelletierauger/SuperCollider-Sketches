(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.5, {
    if(~kick.isPlaying, {~kick.set(\trigGate, 0, \gate, 0, \fadeTime, 1)});
    // if(~bass.isPlaying, {~bass.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    // v.set(\gate, 0, \fadeTime, 0.1);
    ~kick = {
        | trigGate = 1 |
        var trig, amp, sig, dem, dem2, dem3, dem4, dam;
        // trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        trig = DelayN.kr(Impulse.kr(~nT.tempo * 1) * trigGate, 1, 0.5);
        dem = Demand.kr(trig, 0 , Dseq([0.25, 0.05, 0.05, 0.05], inf));
        dem2 = Demand.kr(trig, 0 , Dseq(Pseries(0, 0.15, 4).asStream.nextN(4), inf));
        dem3 = Demand.kr(trig, 0, Dseq([1, 0, 0, 0].stutter(1), inf));
        dem4 = Demand.kr(trig, 0, Dseq([0, 2].stutter(8), inf));
        amp = EnvGen.kr(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
        sig = MiPlaits.ar(25 + 12 - 2,
            engine: 13,
            harm: 0.25 + (dem3 * 0.3),
            timbre: 0.29,
            morph: 0.4,
            trigger: trig,
            decay: 0.2,
            lpg_colour: 0
        )[0] * 0.5;
        // dam = (sig[0] * Decimator.ar(sig[0], 4100, 1)) * 2;
        // dam = dam * 0.5 + DelayN.ar(dam, 1, ~nT.beatDur * 0.5);
        // sig = dam * 0 + sig[0];
        // sig = MiBraids.ar(
        //     pitch: 35 + 12, timbre: 0.24 + (dem2),
        //     color: 0.2 + (dem * 0.2), model: 34, trig: trig,
        //     resamp: 0, decim: dem3, bit: 6, ws: 0
        // );
        sig = VAKorg35.ar(sig, freq: 1200, res: 0, overdrive: 0.05);
        sig =  Compander.ar(sig, sig,
        thresh: MouseX.kr(0.01, 1),
        slopeBelow: 1,
        slopeAbove: 0.5,
        clampTime:  0.01,
        relaxTime:  0.01
    );
        // sig = VadimFilter.ar(sig, 6000, 0, 1);
        sig!2 * 1.5 * 1;
    }.play(fadeTime: 0).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.02, {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    // v.set(\gate, 0, \fadeTime, 0.1);
    ~snare = {
        var trig, amp, sig, dem, dem2, dem3, dem4, env;
        trig = Impulse.kr(~nT.tempo * 1);
        trig = trig * Demand.kr(trig, 0, Dseq([0, 1], inf));
        dem = Demand.kr(trig, 0 , Dseq([0.25, 0.05, 0.05, 0.05], inf));
        dem2 = Demand.kr(trig, 0 , Dseq(Pseries(0, 0.15, 4).asStream.nextN(4), inf));
        dem3 = Demand.kr(trig, 0, Dseq([2, 22].stutter(4), inf));
        dem4 = Demand.kr(trig, 0, Dseq([0, 2].stutter(8), inf));
        amp = EnvGen.kr(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
        sig = MiPlaits.ar(25 + 12 + 12,
            engine: 14,
            harm: 0.75,
            timbre: 0.3,
            morph: 0.6,
            trigger: trig,
            decay: 0.4,
            lpg_colour: 0,
            mul: 2) * 0.25;
        env = EnvGen.kr(Env([0, 1, 1, 0], [0.001, ~nT.beatDur * 0.125, 0.001], [-8, -8, -8]), gate: trig);
        // env = CombC.kr(env.pow(7), 1, ~nT.beatDur * 0.125 * 0.125 * 0.125, ~nT.beatDur * 0.5);
        // env = DelayN.kr(env, 1, ~nT.beatDur);
        sig = sig * env;
        sig = sig[0] * 4;

        // sig = MiBraids.ar(
        //     pitch: 35 + 12, timbre: 0.24 + (dem2),
        //     color: 0.2 + (dem * 0.2), model: 34, trig: trig,
        //     resamp: 0, decim: dem3, bit: 6, ws: 0
        // );
        // sig = sig!2 + (CombC.ar(sig, 1, 0.025 + [0, 0.01], 1) * 0.1);
        sig = VAKorg35.ar(sig, freq: 1200, res: 0, overdrive: 0.05) * 0.25;
        sig * 1!2;
    }.play(fadeTime: 0).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~hats.isPlaying, {~hats.set(\trigGate, 0, \gate, 0, \fadeTime, 1)});
    // if(~bass.isPlaying, {~bass.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    // v.set(\gate, 0, \fadeTime, 0.1);
    ~hats = {
        | trigGate = 1 |
        var trig, amp, sig, dem, dem2, dem3, dem4, dam;
        trig = Impulse.kr(~nT.tempo * 4) * trigGate;
        dem = Demand.kr(trig, 0 , Dseq([0.25, 0.05, 0.05, 0.05], inf));
        dem2 = Demand.kr(trig, 0 , Dseq(Pseries(0, 0.15, 4).asStream.nextN(4), inf));
        dem3 = Demand.kr(trig, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0].stutter(1), inf));
        dem4 = Demand.kr(trig, 0, Dseq([0, 2].stutter(8), inf));
        amp = EnvGen.kr(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
        sig = MiPlaits.ar(25 + 48 - 2,
            engine: 15,
            harm: 0.5,
            timbre: 0.5 + (dem3 * 0.3),
            morph: 0.4 + (dem3 * 0.3) - 0.2,
            trigger: trig,
            decay: 0.2,
            lpg_colour: 0.5
        ) * 0.5;
        dam = (sig[0] * Decimator.ar(sig[0], 4100, 1)) * 2;
        dam = dam * 0.5 + DelayN.ar(dam, 1, ~nT.beatDur * 0.25);
        sig = dam * 0.25 + sig[0];
        // sig = MiBraids.ar(
        //     pitch: 35 + 12, timbre: 0.24 + (dem2),
        //     color: 0.2 + (dem * 0.2), model: 34, trig: trig,
        //     resamp: 0, decim: dem3, bit: 6, ws: 0
        // );
        // sig = sig!2 + VadimFilter.ar(CombC.ar(sig, 1, ~nT.beatDur * [0.125 * 1.25, 0.25 * 1.5], 1) * 8, 1000, 0, 1);

        sig = VAKorg35.ar(sig, freq: 2200, res: 0, overdrive: 0.05);
        sig = VadimFilter.ar(sig, 3000, 0, 5) * 2;
        sig * 0.5!2 * 4;
    }.play(fadeTime: 0).register;
});
)



// Drum toxique, fumant.


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    // if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drumss.isPlaying, {~drumss.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drumss = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 4) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 8) * trigGate;
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
            pitch: 28 + ([1, 2, 2, 6] + 0 * 12),
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec * 4] * 0.25,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 8], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 1.85);
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
            vca: 1,
            resonance: 1,
            lowpassmode: 1,
            linearity: 1
        ) * 0.25 * 4;
        sig = VadimFilter.ar(sig, 1000, 0, 5) * 1;
    }.play(fadeTime: 0.01).register;
});
)


// Drum toxique, fumant.


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.25, {
    // y.set(\gate, 0, \fadeTime, 0.1);
    // ~drumTask.stop;
    // if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drumss.isPlaying, {~drumss.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drumss = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 8) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 16) * trigGate;
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
            decay: [0.9, 0.9, 0.9, dec * 4] * 0.125,
            lpg_colour: 0.5
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 6 + (sig[3][1] * 0.5);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
/*        sig = LPG.ar(
            input: sig,
            controlinput: env.clip(0, 1),
            controloffset: 0,
            controlscale: 1,
            vca: 1,
            resonance: 1,
            lowpassmode: 1,
            linearity: 1
        ) * 0.25 * 4;*/
        // sig = VadimFilter.ar(sig, 5000, 0, 1) * 4;
        sig = VadimFilter.ar(sig, 2000, 0, 5) * 1.5 * 0.75;
    }.play(fadeTime: 0.01).register;
});
)


