(
    z.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq(
            [0, 0, 1, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0] ++
            [0, 0, 1, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0]// ++
            // ([0, 0, 1, 0, 0, 1]).wrapExtend(6 * 4)
            , inf));
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([500, 1000].stutter(4), inf));
        var d3 = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0.5] * 8, inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * d3], [0, 6]), b);
        var se = EnvGen.kr(Env([0, 0, 1], [0.1, 0.1]));
        var sig = MiBraids.ar(
            pitch: 0,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 4) * 0.4);
        sig = VadimFilter.ar(sig, 30, 0, 5);
        sig = sig * VadimFilter.ar(sig, 1700, 0.25, 1) * 3 * 1 * se;
    sig = VadimFilter.ar(sig, 2000, 0, 1);
    sig = MiVerb.ar(sig, time: 0.7, drywet: 1);
    sig = VadimFilter.ar(sig, 3000, 0, 1) * 4 * Line.kr(0, 1, 10);
    }.play(fadeTime: 0);
)

(
    a.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    a = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq(
            [0, 0, 1, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0] ++
            [0, 0, 1, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0]// ++
            // ([0, 0, 1, 0, 0, 1]).wrapExtend(6 * 4)
            , inf));
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([500, 1000].stutter(4), inf));
        var d3 = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0.5] * 8, inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * d3], [0, 6]), b);
        var se = EnvGen.kr(Env([0, 0, 1], [0.1, 0.1]));
        var sig = MiBraids.ar(
            pitch: 10,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 2) * 0.4);
        sig = VadimFilter.ar(sig, 30, 0, 5);
        sig * VadimFilter.ar(sig, 1700, 0.25, 1) * 2 * 0.5 * se;
    }.play(fadeTime: 0);
)