(
~nT.sched(~nT.timeToNextBeat(quant: 8) + (~nT.beatDur * 0), {

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, safeEnv;
        safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.05]));
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo * 0.125).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: [10, 5] + 0 + 10 + 10,
            timbre: 0.25,
            color: [0.8, 0.8] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 5,
            ws: 0
        ) * [env * 0.75, 1 - env * Line.kr(0, 1, r)];
        // sig;
        sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig = sig * 0.75 * 0.5
         !2;
        // sig!2 * 0.5;
        // Amplitude.ar(sig).poll;
        sig = sig * safeEnv;
        Out.ar(0, sig * 0.1);
    }.play(fadeTime: 0.0).register;
});
)