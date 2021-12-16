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
    ) * Line.kr(0, 1, 1);
    var sig = SinOsc.ar(pitch.midicps)!2 * 0.1;
    var amp = pitch.linlin(0, 60, 1, 0.25);
    var atk = pitch.linlin(0, 60, 5, 0.1);
    // pitch.poll;
    sig = sig[0] + sig[1];
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (700 * env * (0.1 + (1 - vel))), 0, 1) * 1;
    // sig = VadimFilter.ar(sig, 7000 * amp, 0, 1);
    Out.ar(0, sig * 0.1 * env!2 * Line.kr(0, 1, 0.01) * 0.4 * 4);
}).add;
)