(
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(~kickWE.isPlaying, {~kickWE.set(\gate, 0, \fadeTime, 0.1)});

    ~kickWE = {
        | trigGate = 1 |
        var trig, sig, block, decay, timbre;
        trig = Impulse.kr(~nT.tempo * 1.5 * 2);
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 0], inf));
        decay = Demand.kr(trig, 0, Dseq([0.4, 0.4, 0.7].stutter(2), inf));

        sig = MiPlaits.ar(2 + 180,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: 0.0,
            trigger: trig * block * trigGate,
            decay: decay + 0.4,
            lpg_colour: 0
        )[1];
        // sig = [sig[0][1], sig[1][1]];
        sig = LPF.ar(sig, 400);
        sig!2 * 0.25 * 64 * 4;
    }.play(fadeTime: 0.01).register;
});
)

(
var synths = [~kick, ~kick2, ~kickWE];
synths.do({|i| if(i.isPlaying,
    {i.set(\trigGate, 0, \gate, 0, \fadeTime, 4)}
)});
)