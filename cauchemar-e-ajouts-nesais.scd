(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
        [~billesA].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 2.1)});});

    ~billesA = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * [2, 4]) * trigGate;
        var d = Demand.kr(trig[1], 0, Dseq(
            // ([3, 3, 8, 7] ++ [3, 3, 8, 10]).stutter(16), inf));
        ([3, 3, 8 + 1, 7 + 1] ++ [3, 3, 8 + 1, 10]).stutter(16), inf));
        var sig = MiPlaits.ar(
            pitch: [59, 59].stutter(2) + [d, 0].stutter(2) - 14 + [0, 0.1].wrapExtend(4),
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95) - 0.5,
            trigger: trig.stutter(2),
            decay: 1,
            lpg_colour: 1
        );
        sig = [sig[0][0] + sig[2][0], sig[1][0] + sig[3][0]];
        // sig = sig * Decimator.ar(sig, 2000, 8) * 4;
        sig = VadimFilter.ar(sig, 1500, 0.25, 1) * 1.6 * 2;
        sig = VAKorg35.ar(sig * 0.2, freq: 50 + 1000, res: 0.4, overdrive: 0.95) * 0.25;
        sig = VadimFilter.ar(sig, 1500, 0, 1) * Line.kr(0, 1, 10);
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
        [~billesA].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 2.1)});});
        [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~billes = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * [4, 4]) * trigGate;
 var d = Demand.kr(trig[1], 0, Dseq([10, 8 + 1, 15, 14].stutter(16), inf));
 var dd = Demand.kr(trig[1], 0, Dseq([0.2, 0.1].stutter(1), inf));
        var sig = MiPlaits.ar(
            pitch: [59, 59].stutter(2) + [d, d].stutter(2) - 36 - 2 + [0, 0.1].wrapExtend(4),
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95) - dd - 0.2,
            trigger: trig.stutter(2),
            decay: 1,
            lpg_colour: 1
        );
        sig = [sig[0][0] + sig[2][0], sig[1][0] + sig[3][0]];
        VadimFilter.ar(sig, 2500, 0.25, 1) * 1.6 * 0.75;
    }.play.register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
        [~basse].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~basse = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * [2, 4]) * trigGate;
        var d = Demand.kr(trig, 0, Dseq([3, 5, 8, 7].stutter(16), inf));
        var sig = MiPlaits.ar(
            pitch: 59 + [d, 0].stutter(2) - 12 + [0, 0.1].wrapExtend(4),
            engine: 11,
            harm: 0.125,
            timbre: 1,
            morph: 0.3,
            trigger: trig.stutter(2),
            decay: 1,
            lpg_colour: 0,
            timb_mod: 0.75,
            morph_mod: 0.5
        );
        sig = [sig[0][0] + sig[2][0], sig[1][0] + sig[3][0]];
        sig = VadimFilter.ar(sig, 1000, 0, 1) * 0.6 * 0.5;
        // VAKorg35.ar(sig * 0.25, 1500, 0.5, 2);
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
        [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});});

    ~billes = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * [2, 4]) * trigGate;
        var d = Demand.kr(trig[1], 0, Dseq([3, 5, 8, 7].stutter(16), inf));
        var sig = MiBraids.ar(
            pitch: 59 + [d, 0].stutter(2) - 12 + [0, 0.1].wrapExtend(4),
            model: 28,
            color: 0.95,
            timbre: 0.35,
            // morph: 0.3,
            trig: trig.stutter(2),
            resamp: 2,
            decim: 2,
            bits: 5,
            ws: 0
            // decay: 1,
            // lpg_colour: 0,
            // timb_mod: 0.75,
            // morph_mod: 0.5
        );
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 0.6 * 0.25;
        // VAKorg35.ar(sig * 0.25, 1500, 0.5, 2);
    }.play(fadeTime: 0).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
        [~billesZ].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~billesZ = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * [2, 4]) * trigGate;
        var d = Demand.kr(trig[1], 0, Dseq([10, 8, 15, 14].stutter(16), inf));
        var sig = MiBraids.ar(
            pitch: 59 + [d, 0].stutter(2) - 12 + [0, 0.1].wrapExtend(4),
            model: 28,
            color: 0.95,
            timbre: 0.95,
            // morph: 0.3,
            trig: trig.stutter(2),
            resamp: 2,
            decim: 2,
            bits: 6,
            ws: 0
            // decay: 1,
            // lpg_colour: 0,
            // timb_mod: 0.75,
            // morph_mod: 0.5
        );
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 0.6 * 0.125;
        // VAKorg35.ar(sig * 0.25, 1500, 0.5, 2);
    }.play(fadeTime: 0).register;
});
)






(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
        [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~billes = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * [2, 4]) * trigGate;
        var d = Demand.kr(trig[1], 0, Dseq([10, 8, 15, 14].stutter(16), inf));
        var sig = MiBraids.ar(
            pitch: 59 + [d, 0].stutter(2) - 12 + [0, 0.1].wrapExtend(4),
            model: 28,
            color: 0.95,
            timbre: 0.95,
            // morph: 0.3,
            trig: trig.stutter(2),
            resamp: 2,
            decim: 5,
            bits: 6,
            ws: 0
            // decay: 1,
            // lpg_colour: 0,
            // timb_mod: 0.75,
            // morph_mod: 0.5
        );
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 0.6 * 0.125;
        VAKorg35.ar(sig * 0.25, 1500, 0.5, 2);
    }.play(fadeTime: 0).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
        [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~billes = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * [2, 4]) * trigGate;
        var d = Demand.kr(trig[1], 0, Dseq([3, 5, 8, 7].stutter(16), inf));
        var sig = MiBraids.ar(
            pitch: 59 + [d, 0].stutter(2) - 12 + [0, 0.1].wrapExtend(4),
            model: 28,
            color: 1,
            timbre: 0.15,
            // morph: 0.3,
            trig: trig.stutter(2),
            resamp: 2,
            decim: 12,
            bits: 4,
            ws: 1
            // decay: 1,
            // lpg_colour: 0,
            // timb_mod: 0.75,
            // morph_mod: 0.5
        );
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        sig = VadimFilter.ar(sig, 1000, 0, 1) * 0.6 * 0.25;
        // VAKorg35.ar(sig * 0.25, 1500, 0.5, 2);
    }.play.register;
});
)