(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    ~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~snare2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo) * trigGate;
        var pat0 = [1, 0, 1, 0, 1, 0] ++ [0, 0, 1, 0, 0, 0];
        var pat1 = [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 1, 1];
        var bl = Demand.kr(trig, 0, [Dseq(pat0, inf), Dseq(pat1, inf)]);

        var lev = Demand.kr(trig * bl[1], 0, Dseq([1, 1, 0.5, 1, 1, 1], inf)).lag(0.1);
        var cur = [8, -6];
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 11], cur), trig * bl).lag(0.1);
        var sig = MiBraids.ar(
            pitch: [10, 0],
            timbre: 0.25,
            color: [0.95, 0.95] - 0.3,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: [4, 3],
            ws: 0
        ) * [0.5, 1];
        sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = sig * e * 2;
        sig = VadimFilter.ar(sig, 1000 + (2500 * e.pow(11)), 0, 1);
        // sig = VadimFilter.ar(sig, [4, 3] * 100 + 100, 0.25, 1);
        // sig = VadimFilter.ar(sig, 50, 0, 5);
        sig = sig.reverse * 8.75;
    }.play(fadeTime: 0.01).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block, timbre;
        trig = Impulse.kr(~nT.tempo * 4);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        timbre = Demand.kr(trig * block, 0, Dseq([0, -2].stutter(4), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo * 4 / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [10, 5] + timbre + 10 + 20,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: [4, 4],
            ws: 0
        ) * [env * 0.5, 1 - env] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig = sig + (sig.reverse * 0.5) * 0.25;
        sig = MiRings.ar(sig, pit: 48 - 12, damp: 0.8, model: 2) * 0.7;
    }.play(fadeTime: 0).register;
});
)

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
