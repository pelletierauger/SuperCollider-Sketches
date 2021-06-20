(
        if(~kick2.isPlaying, {~kick2.set(\gate, 0, \fadeTime, 0.1)});

    ~kick2 = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 2);
        block = Demand.kr(trig, 0, Dseq([1, 1, 0, 0] ++ [0, 0, 1, 0], inf));
        sig = MiBraids.ar(
            pitch: 72 - 24,
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
        sig!2 * 0.25 * 2;
    }.play(fadeTime: 0).register;
)


(
   if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0], inf));
        sig = MiPlaits.ar(2,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.0,
            trigger: trig * trigGate * block,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3)[1]!2 * 1.5;
    sig = LPF.ar(sig, 2400);
    }.play(fadeTime: 0).register;
)


(
    [~hat0, ~hat1].do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 0.1)});});

 /*   ~hat0 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.beatDur.reciprocal * 2) * trigGate;
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

        sig * 0.125 * 0.5 * 4;
    }.play(fadeTime: 0).register;*/

    ~hat1 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.beatDur.reciprocal * 1 * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 16], [2, -8, 'lin']), t);
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

        sig * 0.125 * 0.125 * 4 * 1.5 * 0.5;
    }.play(fadeTime: 0).register;
)


(
// [~hat2].do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 0.1)});});

    ~hat2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.beatDur.reciprocal * 1 * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.125 * 8], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 72 + -4 - 5 - 24 + [0.1, 0],
            timbre: 0.9,
            color: 0.8,
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
    ).reverse;
        sig = RLPF.ar(sig, 100 + (400 * env) + SinOsc.kr(1).range(0, 100));

        sig * 0.125 * 0.125 * 4 * 1.5 * 4;
    }.play(fadeTime: 0).register;
)