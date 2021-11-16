
(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo) * trigGate;
        var pat0 = [1, 0, 1, 0, 1, 0] ++ [0, 0, 1, 0, 0, 0];
        var pat1 = [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 1, 1];
        var bl = Demand.kr(trig, 0, [Dseq(pat0, inf), Dseq(pat1, inf)]);

        var lev = Demand.kr(trig * bl[1], 0, Dseq([1, 1, 0.5, 1, 1, 1], inf)).lag(0.1);
        var cur = [8, -6];
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 3], cur), trig * bl).lag(0.1);
        var sig = MiBraids.ar(
            pitch: 12 + 12 + 5,
            timbre: 0.25,
            color: [0.99, 0.99] - 0.2,
            model: 42,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = sig * e * 2;
        sig = VadimFilter.ar(sig, [4, 3] * 100 + 500, 0.25, 1);
        // sig = VadimFilter.ar(sig, 150, 0, 5);
        sig = sig * 3 * 1 * 1;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo) * trigGate;
        var pat0 = [1, 0, 1, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0];
        var pat1 = [1, 0, 0, 0, 1, 1] ++ [1, 0, 0, 0, 1, 0];
        var bl = Demand.kr(trig, 0, [Dseq(pat0, inf), Dseq(pat1, inf)]);

        var lev = Demand.kr(trig * bl[1], 0, Dseq([1, 1, 0.5, 1, 1, 1], inf)).lag(0.1);
        var cur = [8, -6];
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 9], cur), trig * bl).lag(0.1);
        var sig = MiBraids.ar(
            pitch: [5, 7],
            timbre: 0.05,
            color: [0.99, 0.99] - 0.2,
            model: 42,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = sig * e * 2;
        sig = VadimFilter.ar(sig, [4, 3] * 100 + 1500, 0.25, 5);
        sig = VadimFilter.ar(sig, 500 + (e * 1000), 0, 1) * 2;
        sig = sig * 6 * 2;
    }.play(fadeTime: 0.01).register;
});
)
