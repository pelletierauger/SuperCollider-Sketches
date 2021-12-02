(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block0, block1, timbre0, timbre1;
        trig = Impulse.kr(~nT.tempo);
        block0 = Demand.kr(trig, 0, Dseq([1] ++ (0!23), inf));
        block1 = Demand.kr(trig, 0, Dseq((0!12) ++ [1] ++ (0!11), inf));
        timbre0 = Demand.kr(trig * block0, 0, Dseq([0, -2].stutter(1), inf));
        timbre1 = Demand.kr(trig * block1, 0, Dseq([0, -2].stutter(1), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.05;
        n = (~nT.tempo / 24).reciprocal;
        // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        env = EnvGen.kr(Env([0, 1, 0], [r, n - r]), [block0, block1]);
        sig = MiBraids.ar(
            pitch: [12, 5] + [timbre0, timbre1] + 67 - 5,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 11,
            resamp: 2,
            decim: 2,
            bits: [4, 4],
            ws: 0.5
        ) * env * [1, 2] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig + (sig.reverse * 0.25) * 1;
    }.play(fadeTime: 0).register;
});
)
