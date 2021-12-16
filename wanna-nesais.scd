(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback
    n.set(\gate, 0, \fadeTime, 0.1);
    n = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2].stutter(8), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, dddd]), t).lag(0.1);
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(0.5);
        var sig = MiOmi.ar(pit: 76 - 12 - 12 + d - 12, fm1: e * 0.125 * d5, xfb: min(e * dd * 0.25, 1)) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
        sig = VadimFilter.ar(sig, 8400, 0, 1) * 0.5;
        Out.ar(0, sig);
    }.play;   // cross feedback
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var trigs = trig * [block0, block1, block1, block2];
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8] + 0.1, inf));
        var sig = MiBraids.ar(
            pitch: 30 + [0, 12, 12, 36 + 7] + 12,
            model: 44,
            color: 0.125,
            timbre: 0.5 - [0, 0.2, 0.1, 0.2] + 0.0
        );
        var e = EnvGen.kr(
            Env([0, 1, 0], [0.01, [1.85, 1.85, 1.85, 0.65]], [-8, -8]),
            trigs).lag(0.05);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1], sig[2]] * 3 * snareFix;
        var kickhat = VadimFilter.ar(sig[0], 10 + (1e4 * e[0]), 0, 1) * 4;
        kickhat = kickhat + VadimFilter.ar(sig[3] * 0.25, 10 + (1e4 * e[3]), 0, 1);
        snare = VadimFilter.ar(snare, 10 + (10000 * [e[1], e[2]]), 0, 1);
        // sig = snare;
        sig = kickhat!2 * 0.2 + (snare * 0.2);
        // sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = sig * 0.45;
        // sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.35;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var trigs = trig * [block0, block1, block1, block2];
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8] + 0.1, inf));
        var sig = MiBraids.ar(
            pitch: 0 + [12, 12, 12, 36 + 7] + 12,
            model: 37,
            color: 0.95 - [0, 0, 0.1, 0],
            timbre: 0.95 - [0, 0.2, 0.1, 0.2] + 0.0,
            resamp: 2,
            decim: 12,
            bits: 5,
            ws: 0
        );
        var e = EnvGen.kr(
            Env([0, 1, 0], [0.01, [1.85, 1.85, 1.85, 0.65]], [-8, -8]),
            trigs).lag(0.05);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1], sig[2]] * 3 * snareFix;
        var kickhat = VadimFilter.ar(sig[0], 10 + (5e3 * e[0].lag(0.3)), 0, 1) * 4;
        kickhat = kickhat + VadimFilter.ar(sig[3] * 0.25, 10 + (1e4 * e[3]), 0, 1);
        snare = VadimFilter.ar(snare, 10 + (10000 * [e[1], e[2]]), 0, 1);
        // sig = snare;
        sig = kickhat!2 * 0.2 + (snare * 0.2);
        // sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = sig * 0.5;
        // sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.35;
    }.play(fadeTime: 0.01).register;
});
)