(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 0.1],
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
            times: [0.1, 0.1],
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
        model: 0,
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
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, 0.1) * 1);
}).add;
)


(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 0.1],
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
        model: 0,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 5) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, 0.1) * amp2 * 16 * 2);
}).add;
)




(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 0.2],
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
        model: 3,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, 0.1) * amp2 * 16 * 1);
}).add;
)




// le tigre

(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 2],
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
        model: 4,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * amp2 * 16 * 1);
}).add;
)

s.options.memSize
s.options.memSize = 2.pow(16)
2.pow(16)

~folder = thisProcess.platform.recordingsDir;
s.record(~folder +/+ "le-tigre.aiff");
thisProcess.platform.recordingsDir +/+ "le-tigre"
s.stopRecording;
thisProcess.platform.recordingsDir.openOS;



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
    var choice = TChoose.kr(Impulse.kr(0),(1..10) / 10);
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env * 0.1 + 0.0,
        // color: [0.8, 0.95] - 0.1,
        color: choice + [0, 0],
        model: 40,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 4 * 1);
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
    var choice = TChoose.kr(Impulse.kr(0),(1..10) / 10);
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env * 0.1 + 0.0,
        // color: [0.8, 0.95] - 0.1,
        color: 0.0 + [0, 0],
        model: 38,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 1 * 1);
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
    var choice = TChoose.kr(Impulse.kr(0),(1..10) / 10);
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env * 0.1 + 0.0,
        // color: [0.8, 0.95] - 0.1,
        color: Line.kr(0, 0.1, 5) + [0, 0],
        model: 38,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 1 * 1);
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
    var choice = TChoose.kr(Impulse.kr(0),(1..10) / 10);
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env * 0.1 + 0.0,
        // color: [0.8, 0.95] - 0.1,
        color: Line.kr(0, 0.1, 5) + 0.0 + [0, 0],
        model: 39,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 1 * 1);
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
    var choice = TChoose.kr(Impulse.kr(0),(1..10) / 10);
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env * 0.1 + 0.5,
        // color: [0.8, 0.95] - 0.1,
        color: Line.kr(0, 0.1, 5) + 0.0 + [0, 0],
        model: 39,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 1 * 1);
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
    var choice = TChoose.kr(Impulse.kr(0),(1..10) / 10);
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env * 0 + 0.005,
        // color: [0.8, 0.95] - 0.1,
        color: Line.kr(0, 0.1, 5) + 0.0 + [0, 0],
        model: 39,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (4200 * (1 - env) * (0.3 + (vel * 1))), 0, 5) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 1 * 1);
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
    var choice = TChoose.kr(Impulse.kr(0),(1..10) / 10);
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env * 0 + 0.005,
        // color: [0.8, 0.95] - 0.1,
        color: Line.kr(0, 0.1, 5) + 0.0 + [0, 0.01],
        model: 10,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    // sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (4200 * (1 - env) * (0.3 + (vel * 1))), 0, 5) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env * env * Line.kr(0, 1, 0.1) * 1 * 1 * 1);
}).add;
)