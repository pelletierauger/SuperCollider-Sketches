~nT = TempoClock.new(1.29).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
    if(~kick2.isPlaying, {~kick2.set(\gate, 0, \fadeTime, 0.1)});

    ~kick2 = {
        | trigGate = 1 |
        var trig, sig, block, decay;
        trig = Impulse.kr(1 / ~nT.beatDur * 3);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 1, 0, 0], inf));
        decay = Demand.kr(trig * block, 0, Dseq([0.6, 0.8].stutter(1), inf));
        sig = MiPlaits.ar(2 + 180,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: 0.0 + [0, 0.1],
            trigger: trig * block * trigGate,
            decay: decay + 0.1,
            lpg_colour: 0
        );
        sig = [sig[0][1], sig[1][1]];
        sig = LPF.ar(sig, 2400) * 0.5 * 3;
    }.play(fadeTime: 0).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block, decay;
        trig = Impulse.kr(~nT.tempo * 1.5 * 2);
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));

        sig = MiBraids.ar(
            pitch: 72 - 24 + -2 + 2,
            timbre: 0.9,
            color: 0.7,
            model: 34,
            trig: trig * trigGate * block,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        );
        sig = LPF.ar(sig, 200);
        sig!2 * 0.25 * 4;
    }.play(fadeTime: 0.01).register;
});
)



(
// ~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(~kickW.isPlaying, {~kickW.set(\gate, 0, \fadeTime, 0.1)});

    ~kickW = {
        | trigGate = 1 |
        var trig, sig, block, decay;
        var t = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 16], [2, -8, 'lin']), t);

        block = Demand.kr(t, 0, Dseq([1, 0, 1, 0, 1, 0], inf));
        sig = MiBraids.ar(
            pitch: 72 - 12 - 12,
            timbre: 0.9,
            color: 0.7,
            model: 43,
            trig: t * trigGate * block,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 200);
        sig!2 * 0.25 * 4;
    }.play(fadeTime: 0.01).register;
// });
)

(
// ~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(~kickV.isPlaying, {~kickV.set(\gate, 0, \fadeTime, 0.1)});

    ~kickV = {
        | trigGate = 1 |
        var trig, sig, block, decay, env;
        trig = Impulse.kr(~nT.tempo * 3);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 1, 0, 0], inf));
        env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 16], [2, -8, 'lin']), trig);

    // block = Demand.kr(t, 0, Dseq([1, 0, 0], inf));
        sig = MiBraids.ar(
            pitch: 72 - 12 - 12 + 7,
            timbre: 0.9,
            color: 0.7,
            model: 43,
            trig: trig * block,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 400);
        sig!2 * 0.25 * 4;
    }.play(fadeTime: 0.01).register;
// });
)