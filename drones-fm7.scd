
~drone.free;
(
~drone4.set(\gate, 0);
~drone4 = {
    arg gate = 1, atk = 4, rel = 16;
    var env, ctls, mods, chans, freq, sig, ramp, wo;
    ramp = Env([0, 0.5, 1], [1, 1] * 4, [3, -3]).kr;
    env = EnvGen.ar(Env.new(
        [0, 1.0, 0.00001],
        [atk, rel],
        [\linear, \exponential], 1), gate, doneAction: 2);
    freq = 440 * (-24 + 14).midiratio;
    wo = SinOsc.ar(12).range(0.1, 1);
    ctls = [
        // freq, phase, amp
        [freq * 1, 0, 1],
        [freq * 1.001, 0, 1],
        [freq * 1.001 * 0.5, 0, wo],
        [freq * 1 * 0.5, 0, wo],
        [freq * 0.25, 0, SinOsc.kr(0.1).range(1, 4)],
        [freq * 0.25, 0, SinOsc.kr(0.1).range(1, 4)]
    ];
    mods = [
        // amount of phase modulation in radians
        [0.0, 0.0, 0.0, 0.0, 1.5, 0.0], // phase input of osc 0
        [0.0, 0.0, 0.0, 0.0, 0.0, 1.5], // phase input of osc 1
        [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], // phase input of osc 2
        [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], // phase input of osc 3
        [0.0, 0.0, 0.5, 0.0, 0.0, 0.0], // phase input of osc 4
        [0.0, 0.0, 0.0, 0.5, 0.0, 0.0]  // phase input of osc 5
    ];
    chans = [0, 1];
    // using "slice" to select specific channels
    sig = FM7.ar(ctls, mods).slice(chans) * -12.dbamp * 0.4;
    sig = sig * env;
    Out.ar(0, sig);
}.play;
)

2pi

Env([0, 0.5, 1], [1, 1], [3, -3]).plot;