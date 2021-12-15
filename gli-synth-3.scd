(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 5],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env,
        color: [0.8, 0.95] - 0.2,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 5) * 1 * env!2;
    sig = VadimFilter.ar(sig, 7000, 0, 1);
    Out.ar(0, sig * 0.1);
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
        timbre: env,
        color: [0.8, 0.95] - 0.2,
        model: 38,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 5) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, 0.1) * amp);
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
        timbre: env,
        color: [0.8, 0.95] - 0.8,
        model: 38,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 5) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, 0.1) * amp);
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
        timbre: 0.2,
        color: [0.8, 0.95] - 0.8,
        model: 39,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 5) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, atk) * 0.4);
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
        timbre: 0.2,
        color: [0.8, 0.95] - 0.8,
        model: 39,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, atk) * 0.4);
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
        timbre: 0.7,
        color: [0.8, 0.95] - 0.8,
        model: 40,
        resamp: 2,
        decim: 12,
        bits: 4,
        ws: 0
    ) * 2!2;
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.25);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, atk) * 0.4);
}).add;
)




(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 3],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: 0.7,
        color: [0.8, 0.95] - 0.8,
        model: 41,
        resamp: 2,
        decim: 12,
        bits: 4,
        ws: 0
    ) * 2!2;
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.25);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 5) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, atk) * 0.4);
}).add;
)



(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 3],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: 0.7,
        color: [0.8, 0.95] - 0.8,
        model: 2,
        resamp: 0,
        decim: 12,
        bits: 4,
        ws: 0
    ) * 2!2;
    var amp = pitch.linlin(0, 60, 1, 0.25);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    // pitch.poll;
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + (1 - vel))), 0, 5) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, 0.01) * 0.4);
}).add;
)