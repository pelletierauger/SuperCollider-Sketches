(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1 * 0.25) * trigGate;
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5], [2, -8, 'lin']), trig);

    sig = MiBraids.ar(
        pitch: 12 + 12,
        timbre: 1 - env,
        color: [0.8] - 0.4,
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
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise2 = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1 * 2) * trigGate;
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5], [2, -8, 'lin']), trig);

    sig = MiBraids.ar(
        pitch: 12 + 12 + 12,
        timbre: 1 - env,
        color: [0.8] - 0.1,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    sig = VadimFilter.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 2000), 0, 5)  * 4;
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.5;
}.play(fadeTime: 0.1).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise2 = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1 * 2) * trigGate;
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5], [2, -8, 'lin']), trig);

    sig = MiBraids.ar(
        pitch: 12 + 12 + 12,
        timbre: 1 - env,
        color: [0.8] - 0,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    sig = VadimFilter.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 2000), 0, 5) * 4;
        sig = VadimFilter.ar(sig, 5000, 0, 1) * 4;
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 3.5;
}.play(fadeTime: 0.1).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise2 = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1 * 2) * trigGate;
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5], [2, -8, 'lin']), trig);

    sig = MiBraids.ar(
        pitch: 12 + 0 + 0,
        timbre: 1 - env,
        color: [0.8] - 0.1,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 3,
        ws: 0
    );
    sig = VadimFilter.ar(sig, 700 + SinOsc.ar(0.1).range(0, 1000), 0, 5) * 4;
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.5;
}.play(fadeTime: 0.1).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise2 = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n, lfo;
    trig = Impulse.kr(~nT.tempo * 1 * 2) * trigGate;
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5], [2, -8, 'lin']), trig);
        lfo = SinOsc.kr(3).unipolar * 0.06;
    sig = MiBraids.ar(
        pitch: 12 + -5 + 0,
        timbre: 1 - env,
        color: [0.8] - 0.2,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 3,
        ws: 0
    );
        // sig = VadimFilter.ar(sig, 700 + SinOsc.ar(0.1).range(0, 1000), 0, 5) * 4;
    sig = VadimFilter.ar(sig, 700 + SinOsc.ar(0.1).range(0, 1000), 0, [1, 5]) * 1;
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
        sig = sig[0] + (sig[1] * 4);
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 8;
}.play(fadeTime: 0.1).register;
});
)