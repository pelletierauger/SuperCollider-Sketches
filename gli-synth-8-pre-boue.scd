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
        timbre: 0,
        color: [0.8, 0.95] - 0.2,
        model: 11,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.001]));
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (2200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 2 * safeEnv);
}).add;
)


// glotte maussade

(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 12],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var oct = Select.kr(pitch > 40, [-24, 0]);
    var sig = MiBraids.ar(
        pitch: pitch + oct,
        timbre: 0.5,
        color: [0.8, 0.95] - 0.2 * (0.9 + (env * 0.01)),
        model: 21,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.01]));
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    // (10 < 3).poll;
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (2200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 1 * safeEnv);
}).add;
)

~folder = thisProcess.platform.recordingsDir;
s.record(~folder +/+ "glotte-maussade-tests.aiff");
thisProcess.platform.recordingsDir +/+ "le-tigre"
s.stopRecording;
thisProcess.platform.recordingsDir.openOS;


(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 12],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var oct = Select.kr(pitch > 40, [-24, 0]);
    var sig = MiBraids.ar(
        pitch: pitch + oct,
        timbre: 0.5,
        color: [0.8, 0.95] - 0.2 * (0.9 + (env * 0.01)),
        model: 21,
        resamp: [0, 2],
        decim: 32,
        bits: 6,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.01]));
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    // (10 < 3).poll;
    sig = sig[0] * sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (2200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 1 * safeEnv);
}).add;
)


// La procession lente d'intro-album

(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 12],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var oct = Select.kr(pitch > 40, [-24, 0]);
    var oct2 = Select.kr(pitch > 40, [0, 1]);
    var sig = MiBraids.ar(
        pitch: pitch + oct,
        timbre: 0.5 + (SinOsc.kr(6).range(0.1, 0.15) * (oct2)),
        color: [0.8, 0.95] - 0.2 * (0.9 + (env * 0.01)),
        model: 22,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.01]));
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    // (10 < 3).poll;
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = ( Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (2200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 3) * 1 * 1 * safeEnv);
}).add;
)



(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.1, 12],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var oct = Select.kr(pitch > 40, [-24, 0]);
    var sig = MiBraids.ar(
        pitch: pitch + oct,
        timbre: 0.5,
        color: [0.8, 0.95] - 0.2 * (0.9 + (env * 0.01)),
        model: 21,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // pitch.poll;
    var amp = pitch.linlin(0, 60, 1, 0.05);
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.01]));
      var amp2 = pitch.linexp(0, 90, 0.001, 1);
    // (10 < 3).poll;
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 2100 + (2200 * env * (0.3 + (vel * 1))), 0, 1) * 1;
    sig = VadimFilter.ar(sig, 7000 * 1, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * env * Line.kr(0, 1, 0.1) * 1 * 1 * safeEnv);
}).add;
)