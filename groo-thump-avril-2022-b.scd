~nT = TempoClock.new(1.39).permanent_(true);

~nT.tempo = 1.39 * 1.25;

(
~kickF = {
    ~nT.sched(~nT.timeToNextBeat(quant: 5), {
        if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

        ~kick = {
            | trigGate = 1 |
            var trig, sig, block;
            trig = Impulse.kr(1 / ~nT.beatDur * 4);
            block = trig * Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
            sig = MiBraids.ar(50, 0.9, 0.85, model:34, trig: trig);
            sig = VadimFilter.ar(sig, 1500, 0, 1);
            sig * 4!2;
        }.play(fadeTime: 0).register;
    });
};
~kickF.();
)


(
~snareF = {
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    if(~snare.isPlaying, {~snare.set(\gate, 0, \fadeTime, 0.1)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var dec = Demand.ar(dem * trig, 0, Dseq([6, 6, 6, 7.5, 6, 6, 7.5, 7.5] / 10, inf));
        var sig = MiPlaits.ar(
            pitch: 30,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 1 - dec,
            trigger: trig * dem * trigGate,
            decay: dec,
            lpg_colour: 0
        )[1]!2;
        sig = VadimFilter.ar(sig, 1500, 0, 1) + (sig * 0.75) + (VadimFilter.ar(sig, 2000, 0, 3) * 0.5);
        sig = sig * 3.6;
    }.play(fadeTime: 0).register;
});
};
~snareF.();
)



(
~nT.sched(~nT.timeToNextBeat(quant: 5), {

    if(~bass.isPlaying, {~bass.set(\gate, 0, \fadeTime, 0.1)});

    ~bass = {
        var f = 50 - 12;
        var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
        var trig = Impulse.ar(~nT.tempo * 4);
        var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 0.025, 20).asStream.nextN(20).reverse, inf));
        var lfo2 = SinOsc.kr(0.1, pi / 2).range(0.6, 0.6) - 0.00025;
        var dem2 = Demand.ar(trig, 0, Dseq([0.1, 0.16].stutter(1), inf));
        var alg = 1;
        var sig = MiPlaits.ar(
            pitch: 50 - 12 - 12,
            engine: 1,
            harm: lfo,
            morph: lfo,
            trigger: trig
        )[0] * 0.8;
        VadimFilter.ar(sig, 1500, 0, 1) * 12 * 1!2;
    }.play.register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    if(~snare.isPlaying, {~snare.set(\gate, 0, \fadeTime, 0.1)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var dec = Demand.ar(dem * trig, 0, Dseq([6, 6, 6, 7.5, 6, 6, 7.5, 7.5] / 10, inf));
        var sig = MiPlaits.ar(
            pitch: 30,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 1 - dec,
            trigger: trig * dem * trigGate,
            decay: dec + 0.2,
            lpg_colour: 0
        )[1]!2;
        var env = EnvGen.ar(Env([0, 1, 0], [0.01, 2], [-8, -8]), gate: trig * dem * trigGate);
        sig = sig * 0.5 + (LPG.ar(
            input: sig * 0.75,
            controlinput: (DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 0.5)).clip(0, 1),
            controloffset: 0.25,
            controlscale: 0.5,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        ) * 0.5);
        sig = VadimFilter.ar(sig, 1500, 0, 1) * 1 + (sig * 0.5) + (VadimFilter.ar(sig, 2000, 0, 3) * 0.5);
        sig = sig * 7.6;
    }.play(fadeTime: 0).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    if(~snare.isPlaying, {~snare.set(\gate, 0, \fadeTime, 0.1)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var dec = Demand.ar(dem * trig, 0, Dseq([6, 6, 6, 7.5, 6, 6, 7.5, 7.5] / 10, inf));
        var sig = MiPlaits.ar(
            pitch: 30,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 1 - dec,
            trigger: trig * dem * trigGate,
            decay: dec,
            lpg_colour: 0
        )[1]!2;
        var env = EnvGen.ar(Env([0, 1, 0], [0.01, 2], [-8, -4]), gate: trig * dem * trigGate);
        sig = (LPG.ar(
            input: sig * 0.75,
            controlinput: env.clip(0, 1),
            controloffset: 0.25,
            controlscale: 0.5,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        ) * 0.5) + (LPG.ar(
            input: sig * 0.75,
            controlinput: (DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 0.5)).clip(0, 1),
            controloffset: 0.25,
            controlscale: 0.5,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        ) * 0.75);
        sig = VadimFilter.ar(sig, 1500, 0, 1) * 1 + (sig * 0.5) + (VadimFilter.ar(sig, 2000, 0, 3) * 0.5);
        sig = sig * 7.6;
    }.play(fadeTime: 0).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    if(~snare.isPlaying, {~snare.set(\gate, 0, \fadeTime, 0.1)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var dec = Demand.ar(dem * trig, 0, Dseq([6, 6, 6, 7.5, 6, 6, 7.5, 7.5] / 10, inf));
        var sig = MiPlaits.ar(
            pitch: 30,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 1 - dec,
            trigger: trig * dem * trigGate,
            decay: dec,
            lpg_colour: 0
        )[1];
        var env = EnvGen.ar(Env([0, 1, 0], [0.01, 2], [-8, -4]), gate: trig * dem * trigGate);
        sig = [LPG.ar(
            input: sig * 0.75,
            controlinput: env.clip(0, 1),
            controloffset: 0.25,
            controlscale: 0.5,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        ) * 0.5, (LPG.ar(
            input: sig * 0.75,
            controlinput: (DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 0.5)).clip(0, 1),
            controloffset: 0.25,
            controlscale: 0.5,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        ) * 0.5)];
        sig = VadimFilter.ar(sig, 1500, 0, 1) * 1 + (sig * 0.5) + (VadimFilter.ar(sig, 2000, 0, 3) * 0.5);
        sig = sig * 7.6;
    }.play(fadeTime: 0).register;
});
)


(
~hatsF = {
    ~nT.sched(~nT.timeToNextBeat(quant: 5), {
        if(~hats.isPlaying, {~hats.set(\gate, 0, \fadeTime, 0.1)});

        ~hats = {
            | trigGate = 1 |
            var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
            var dem = Demand.ar(trig, 0, Dseq([1, 0, 1, 0], inf));
            var dec = Demand.ar(dem * trig, 0, Dseq([6, 6] / 10, inf));
            var sig = MiPlaits.ar(
                pitch: 30,
                engine: 10,
                harm: 0.95,
                timbre: 1,
                morph: 1 - dec,
                trigger: trig * dem * trigGate,
                decay: dec,
                lpg_colour: 0
            )[1]!2;
            sig = VadimFilter.ar(sig, 1500, 0, 1) + (sig * 0.75) + (VadimFilter.ar(sig, 2000, 0, 3) * 0.5);
            sig = sig * 0.8;
        }.play(fadeTime: 0).register;
    });
};
~hatsF.();
)



[~snareF, ~hatsF].do({|it| it.();});
~kickF.();
~snareF.();