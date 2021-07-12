(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(2 * 1.5 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12,
        timbre: 1,
        color: [0.8, 0.95],
        model: 37,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = ;
    sig = (sig * 0.1) + MiRings.ar((sig[0] + sig[1])!2,
        pit: 12 + note.lag(0.1) + 24,
        struct: 0.9,
        bright: 0.4,
        damp: 0.7,
        pos: 0.25,
        model: 1
    );
    sig = HPF.ar(sig, 100);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 0.25 * 4;
}.play(fadeTime: 0.1).register;
)




(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise = {
    | trigGate = 1, relGate = 0  |
    var amp, trig, sig, env, block, decay, timbre, delrd, note, r, n;
    amp = EnvGen.ar(
        envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
        gate: Trig.kr(relGate),
        doneAction: 0
    );
    trig = Impulse.kr(2 * 1.5 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12,
        timbre: 1,
        color: [0.8, 0.95],
        model: 2,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000)) * amp;
    // sig = ;
    sig = (sig * 0.1) + MiRings.ar((sig[0] + sig[1])!2,
        pit: 12 + note.lag(0.1) + 24,
        struct: 0.9,
        bright: 0.4 + (relGate * 0.5),
        damp: 0.7 - (relGate.lag(1) * 0.0),
        pos: 0.25,
        model: 1
    );
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 0.25 * 4;
}.play(fadeTime: 0.1).register;
)

~crushedNoise.set(\relGate, 1, \gate, 0, \fadeTime, 15);

(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise = {
    | trigGate = 1, relGate = 0 |
    var amp, trig, sig, env, block, decay, timbre, delrd, note, r, n;
    amp = EnvGen.ar(
        envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
        gate: Trig.kr(relGate),
        doneAction: 0
    );
    trig = Impulse.kr(2 * 1.5 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12 + 12 + 5 + 12,
        timbre: 1,
        color: [0.8, 0.95],
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000)) * amp;
    // sig = ;
    sig = (sig * 0.1) + MiRings.ar((sig[0] + sig[1])!2,
        pit: 12 + note.lag(0.1) + 24,
        struct: 0.9,
        bright: 0.4 + (relGate.lag(4) * 0.5),
        damp: 0.7,
        pos: 0.25,
        model: 1
    );
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 0.25 * 4;
}.play(fadeTime: 0.1).register;
)

~crushedNoise.set(\relGate, 1, \gate, 0, \fadeTime, 15);