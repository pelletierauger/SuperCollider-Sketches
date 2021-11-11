(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 1.3) * trigGate;
        var pat1 = [1, 0, 1, 0, 1, 0] ++ [1, 0, 1, 0, 1, 0];
        var pat2 = [1, 0, 1, 0, 1, 0] ++ [1, 1, 1, 1, 1, 1];

        var block1 = Demand.kr(t, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(t, 0, Dseq(pat2, inf));
        var d = Demand.kr(t * block1, 0, Dseq([0.5, 0.15, 0.15].rotate(0), inf));
        var sig = MiBraids.ar(
            pitch: 45,
            timbre: 0.65,
            color: d,
            model: 34,
            trig: t * block2
        ) * 2!2;
        VadimFilter.ar(sig, 200, 0.25, 1);
    }.play(fadeTime: 0);
        ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1.3) * trigGate;
        var pat0 = [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 1, 1];
        var pat1 = [1, 0, 1, 0, 1, 0] ++ [1, 0, 1, 0, 0, 0];
        var pat2 = [0, 1, 0, 1, 0, 1] ++ [0, 1, 0, 1, 0, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var cur = [-2, -6];

        var e0 = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 3], cur), trig * block0);

        var e1 = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 3], cur), trig * block1);

        var e2 = EnvGen.kr(Env([0, 1, 0], [0.01, 1 * 3], cur), trig * block2);
        // var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiBraids.ar(
            pitch: 0,
            timbre: 0.25,
            color: [0.8, 0.95, 0.99] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 5,
            ws: 0
        );
        sig = sig * [e0 * 2, e1 * 2, e2].rotate(2);
        sig = VadimFilter.ar(sig, [4, 2, 3] * 1000 + 1000, 0.25, 5);
        // sig = sig.sum;
        sig = [sig[0] + sig[1], sig[2] + sig[1]];
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 0.75;
    }.play(fadeTime: 0.01).register;
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 1.3 / 3 * 1) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(t, 0, Dseq([200, 500].stutter(4), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
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
        VadimFilter.ar(sig, d2 + 0, 0.25, 1) * 2;
    }.play(fadeTime: 0);
});
)