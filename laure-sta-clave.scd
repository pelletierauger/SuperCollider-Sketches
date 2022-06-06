(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1) * trigGate;
    block = trig * Demand.kr(trig, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.05, 3.5], [2, -8, 'lin']), block);

    sig = MiBraids.ar(
        pitch: 12 + 12,
        timbre: 1 - env,
        color: [0.8] - 0.3,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    sig = VadimFilter.ar(sig, 4700 + SinOsc.ar(0.1).range(0, 2000), 0, 1);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 1;
}.play(fadeTime: 0.1).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, note2, r, n;
    trig = Impulse.kr(~nT.tempo * 1) * trigGate;
    block = trig * Demand.kr(trig, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    timbre = Demand.kr(block, 0, Dseq([0.2, 0.2, 0.1].stutter(1), inf));
    note = Demand.kr(block, 0, Dseq([0, 0, 12], inf));
    note2 = Demand.kr(block, 0, Dseq([3.5, 3.5, 3.5], inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.05, note2], [2, -8, 'lin']), block);

    sig = MiBraids.ar(
        pitch: 12 + 12 + note,
        timbre: 1 - env,
        color: [0.8] - timbre - 0.2,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 3,
        ws: 0
    ) * env * 0.25;
        // sig = VadimFilter.ar(sig, 8700 - (note.lag(2) * 200), 0, 1);
        // sig = (sig) + ((CombN.ar(sig, 0.2, 0.1 + [0, 0.01], 3) * 0.125 * 0.5));
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 1.4!2;
}.play(fadeTime: 0.1).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, note2, r, n;
    trig = Impulse.kr(~nT.tempo * 1) * trigGate;
    block = trig * Demand.kr(trig, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    timbre = Demand.kr(block, 0, Dseq([0.2, 0.2, 0.1].stutter(1), inf));
    note = Demand.kr(block, 0, Dseq([0, 0, 12], inf));
    note2 = Demand.kr(block, 0, Dseq([3.5, 3.5, 1.5], inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.05, note2], [2, -8, 'lin']), block);

    sig = MiBraids.ar(
        pitch: 12 + 12 + note + 12,
        timbre: 1 - env,
        color: [0.8] - timbre - 0.4,
        model: 27,
        resamp: 2,
        decim: 32,
        bits: 3,
        ws: 0
    ) * env;
    sig = VadimFilter.ar(sig, 6700 - (note.lag(2) * 200), 0, 1);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.4;
}.play(fadeTime: 0.1).register;
});
)