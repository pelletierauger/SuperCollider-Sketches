
(
// ~nT.sched(~nT.timeToNextBeat(quant: 5), {

    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(0.5);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiPlaits.ar(2,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.0,
            trigger: trig * trigGate,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3)[1]!2 * 0.25;
    sig = LPF.ar(sig, 2400);
    }.play(fadeTime: 0).register;
// });
)