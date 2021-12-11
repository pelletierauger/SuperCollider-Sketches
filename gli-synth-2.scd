(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 2],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.ar(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env,
        color: [0.8, 0.95] - 0.75,
        model: 15,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 1) * 1 * env!2;
    Out.ar(0, sig * 0.05 * 1);
    Out.ar(~reverb, sig * 0.05);
}).add;
)