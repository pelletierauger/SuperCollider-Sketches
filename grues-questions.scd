~nT = TempoClock.new(1.39 * 2 * 1.3).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block, timbre;
        trig = Impulse.kr(~nT.tempo);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        timbre = Demand.kr(trig * block, 0, Dseq([0, -2].stutter(4), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.1;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [10, 5] + timbre + 23,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 40,
            resamp: 2,
            decim: 32,
            bits: [4, 4],
            ws: 0
        ) * [env * 0.5, 1 - env] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig + (sig.reverse * 0.5) * 1;
    }.play(fadeTime: 0).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block, timbre;
        trig = Impulse.kr(~nT.tempo);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        timbre = Demand.kr(trig * block, 0, Dseq([0, -2].stutter(4), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.1;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [10, 5] + timbre + 23,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 47,
            resamp: 0,
            decim: 32,
            bits: [4, 4],
            ws: 0
        ) * [env * 0.5, 1 - env] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig + (sig.reverse * 0.5) * 1;
    }.play(fadeTime: 0).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block, timbre;
        trig = Impulse.kr(~nT.tempo);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        timbre = Demand.kr(trig * block, 0, Dseq([0, -2].stutter(4), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [10, 5] + timbre + 23 + 12 ,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 26,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0
        ) * [env * 0.5, 1 - env] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 100, 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig + (sig.reverse * 0.5) * 1;
    }.play(fadeTime: 0).register;
});
)