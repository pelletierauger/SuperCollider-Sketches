(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    y.set(\gate, 0, \fadeTime, 0.1);
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
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
            pitch: 41 - 12 + ([1, 2, 2, 6] - 2 * 12),
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0.125,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec ] * dd * 1.4,
            lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [-8, -8]), gate: [block0, block1]).sum!2;
        var kickhat = sig[0][1] * 2 + (sig[3][1] * 0.35 * b * 1);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 1.5)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.4,
            vca: 1,
            resonance: 0,
            lowpassmode: 0,
            linearity: 1
        );
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 2;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    ~nour.free;
    ~nour = {
        var t = Impulse.kr(~nT.tempo);
        var b = t * Demand.kr(t, 0, Dseq([1, 0, 0], inf));
        var d = Demand.kr(b, 0, Dseq([0, -2].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * 8 - 0.01], [8, -8]), b);
        var sig = MiBraids.ar(24 + d + 7, e, e, model: 0);
        sig = sig * e!2;
        // sig = CombC.ar(sig, 1, 0.001, 0.1);
        // sig = VadimFilter.ar(sig, 2200 + (e * 4500), 0, 1);
        sig = MiRings.ar(
            sig!2, b,
            struct: 0.75,
            bright: 0.4, pit: 12 + d.lag(0.1), damp: 0.5, poly: 4,
            model: 0) * 0.5;
        sig = VadimFilter.ar(sig, 2200 + (e * 4500), 0, 1);
    }.play;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    ~nour.free;
    ~nour = {
        var t = Impulse.kr(~nT.tempo);
        var b = t * Demand.kr(t, 0, Dseq([1, 0, 1, 0, 1, 0], inf));
        var d = Demand.kr(b, 0, Dseq([0, -2].stutter(6), inf));
        var dd = Demand.kr(b, 0, Dseq([0, -1].stutter(6), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.05, ~nT.beatDur * 8 - 0.01], [8, -2]), b);
        var sig = MiBraids.ar(41 + [-12, 3 + 36 + dd, 7 + 24 + d, 0 + 24], e, e * e, model: 0);
        // sig = Splay.ar(sig);
        sig = sig * e ! 2;

        sig = VadimFilter.ar(sig, 2200 + (e * 3500), 0, 1) * 0.125;
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    ~nour2.free;
    ~nour2 = {
        var t = Impulse.kr(~nT.tempo);
        var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0], inf));
        var d = Demand.kr(b, 0, Dseq([0, -2].stutter(4), inf));
        var dd = Demand.kr(b, 0, Dseq([0, -1].stutter(4), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.05, ~nT.beatDur * 8 - 0.01], [8, -2]), b);
        var sig = MiBraids.ar(41 + [-12, 3 + 36 + dd, 7 + 24 + d, 0 + 24] + 0, e, e * e, model: 0);
        // sig = Splay.ar(sig);
        sig = sig * e ! 2;

        sig = VadimFilter.ar(sig, 200 + (e * 3500), 0, 5) * 0.25;
    }.play;
});
)
