(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 10],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: 0.2 * env,
        color: [0.8, 0.95] * 1 - 0.5,
        model: 29,
        resamp: 2,
        decim: 12,
        bits: 4,
        ws: 0
    ) * 2;
    var amp = pitch.linlin(0, 60, 1, 0.25);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    // pitch.poll;
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + (1 - vel))), 0, 1) * 1;
    // sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, 0.01) * 0.4 * 4);
}).add;
)

(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 10],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: 0.2 * env,
        color: [0.8, 0.95] * 1 - 0,
        model: 29,
        resamp: 2,
        decim: 22,
        bits: 6,
        ws: 0
    ) * 2;
    var amp = pitch.linlin(0, 60, 1, 0.25);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    // pitch.poll;
    // sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 4000 + (700 * env * (0.1 + (1 - vel))), 0, 1) * 1;
    // sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env * Line.kr(0, 1, 0.01) * 0.4 * 2);
}).add;
)



(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 5],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: 0.2 * env,
        color: [0.8, 0.95] * 1 - 0.5,
        model: 29,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2;
    var amp = pitch.linlin(0, 60, 1, 0.25);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    var li = Line.kr(4000, 100, 4);
    // pitch.poll;
    // sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, li + (700 * env * (0.1 + (1 - vel))), 0, 1) * 1;
    // sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env * Line.kr(0, 1, 0.01) * 0.4 * 2);
}).add;
)



(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 5],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: 0.9 * env,
        color: [0.8, 0.95] * 1 - 0.05,
        model: 44,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2;
    var amp = pitch.linlin(0, 60, 1, 0.25);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    var li = Line.kr(1000, 100, 4);
    // pitch.poll;
    // sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, li + (700 * env * (0.1 + (1 - vel))), 0, 5) * 1;
    // sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env * Line.kr(0, 1, 0.01) * 0.4 * 2);
}).add;
)