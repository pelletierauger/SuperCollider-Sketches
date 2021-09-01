(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0), {

    if(~crushedNoiseAw.isPlaying, {~crushedNoiseAw.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoiseAw = {
        | trigGate = 1 |
        var trig, sig, env, block, decay, timbre, delrd, note, r, n;
        trig = Impulse.kr(~nT.tempo * 0.5);
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo * 0.25).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: 12 + Demand.kr(trig, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 1,
            color: [0.8, 0.95],
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * [env, 1 - env];
        // sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
           sig = VadimFilter.ar(
        input: sig,
        type: 5,
        freq: 2700 + SinOsc.ar(0.1).range(0, 7000),
            // resonance: 2 + (SinOsc.kr(8 + [0, 0.5]).range(0, 1))
        );
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
        // ) * 0.125 * 0.25 * envGate;
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig = sig[0] + sig[1];
        sig!2 * 0.125 * 6 * 4;
    }.play(fadeTime: 0.05).register;
});
)