(
// ~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.025, {

    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(0.5);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiPlaits.ar(2,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.0,
            trigger: trig * trigGate,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3)[1]!2 * 1.25 * 0.1;
    sig = LPF.ar(sig, 2400);
    }.play(fadeTime: 0.01).register;

// });

)



(
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.025, {
    [~hat0, ~hat1].do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 0.1)});});

    ~hat0 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.beatDur.reciprocal * 4) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 72 + 140,
            timbre: 0.7,
            color: 0.1 + [0, 0.01],
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
    sig = LPF.ar(sig, 6000);
        sig * 0.125 * 2;
    }.play(fadeTime: 0).register;

    ~hat1 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.beatDur.reciprocal * 4 * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 8], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 72 + 140 - 24,
            timbre: 0.7,
            color: 0.1 + [0, 0.01],
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
    sig = LPF.ar(sig, 6000);
        sig * 0.125 * 0.125 * 16;
    }.play(fadeTime: 0).register;
});
)