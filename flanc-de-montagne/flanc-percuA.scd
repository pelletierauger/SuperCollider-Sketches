(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
    if(~kick2.isPlaying, {~kick2.set(\gate, 0, \fadeTime, 0.1)});

    ~kick2 = {
        | trigGate = 1 |
        var trig, sig, block, decay;
        trig = Impulse.kr(~nT.tempo * 4);
        block = Demand.kr(trig, 0, Dseq([
            1, 0, 0, 0,
            1, 0, 0, 0,
            // 1, 0, 1, 0,
            // 0, 0, 1, 0
        ], inf));
        decay = Demand.kr(trig * block, 0, Dseq([
            0.2, 0.2, 0.2, 0.3//, 0.2
        ].stutter(1), inf));
        sig = MiBraids.ar(
            pitch: 72 - 24 + -2 + 2,
            timbre: decay * 3,
            color: 0.2,
            model: 34,
            trig: trig * trigGate * block,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        )!2;

        sig = LPF.ar(sig, 2400) * 0.5 * 4;
    }.play(fadeTime: 0).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block, decay, timbre;
        trig = Impulse.kr(~nT.tempo * 1.5 * 2);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 1, 0], inf));
        decay = Demand.kr(trig, 0, Dseq([0.3, 0.7].stutter(2), inf));

        sig = MiPlaits.ar(2 + 180,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: 0.0 + [0, 0.2],
            trigger: trig * block * trigGate,
            decay: decay + 0.4,
            lpg_colour: 0
        );
        sig = [sig[0][1], sig[1][1]];
        sig = LPF.ar(sig, 200);
        sig * 0.5 * 62 * 2;
    }.play(fadeTime: 0.01).register;
});
)