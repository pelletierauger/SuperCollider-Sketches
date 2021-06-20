(
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 2);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiPlaits.ar(26,
            engine: 13,
            harm: 0.8,
            timbre: 0.6,
            morph: 0.7,
            trigger: trig,
            decay: 0.1
        )[0]!2 * 4;
    }.play(fadeTime: 0).register;
});
)