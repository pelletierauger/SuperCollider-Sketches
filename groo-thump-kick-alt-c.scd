(
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    if(~kick2.isPlaying, {~kick2.set(\gate, 0, \fadeTime, 0.1)});

    ~kick2 = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiBraids.ar(
            pitch: 72 - 24,
            timbre: 0.7,
            color: 0.5,
            model: 34,
            trig: trig,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        );
        sig = LPF.ar(sig, 200);
        sig!2 * 0.25 * 8;
    }.play(fadeTime: 0).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 5), {

    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiPlaits.ar(2,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.0,
            trigger: trig * trigGate,
            decay: 0.75,
            lpg_colour: 0,
            mul: 3)[1]!2 * 1;
    sig = LPF.ar(sig, 2400);
    }.play(fadeTime: 0).register;
});
)