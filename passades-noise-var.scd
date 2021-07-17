(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, note2, r, n;
    trig = Impulse.kr(2 * 1.5 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    note2 = Demand.kr(trig * block, 0, Dseq([0.4, 0.8], inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12 + -10,
        timbre: 1,
        color: [0.8, 0.95],
        model: 9,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = ;
    sig = (sig * 0.1) + MiRings.ar((sig[0] + sig[1])!2,
        pit: 12 + note.lag(0.1) + 12 + 12,
        struct: 0.9,
        bright: note2,
        damp: 0.9,
        pos: 0.25,
        model: 4
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
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise2 = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, note2, r, n;
    trig = Impulse.kr(~nT.tempo);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    note2 = Demand.kr(trig * block, 0, Dseq([0.4, 0.8], inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12 + 0,
        timbre: 1,
        color: [0.8, 0.95],
        model: 17,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = ;
    sig = (sig * 0.1) + MiRings.ar((sig[0] + sig[1])!2,
        pit: 12 + note.lag(0.1) + 12 + 0,
        struct: 0.9,
        bright: note2,
        damp: 0.9,
        pos: 0.25,
        model: 2
    );
    sig = LPF.ar(sig, 2000);
    sig = HPF.ar(sig, 100);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 0.25 * 4 * 16;
}.play(fadeTime: 0.1).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise2 = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, note2, r, n;
    trig = Impulse.kr(~nT.tempo);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    note2 = Demand.kr(trig * block, 0, Dseq([0.4, 0.8], inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12 + 0,
        timbre: 1,
        color: [0.8, 0.95],
        model: 17,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = ;
    sig = (sig * 0.1) + MiRings.ar((sig[0] + sig[1])!2,
        pit: 12 + note.lag(0.1) + 12 + 0,
        struct: 0.9,
        bright: note2,
        damp: 0.2,
        pos: 0.25,
        model: 2
    );
    sig = LPF.ar(sig, 2000);
    sig = HPF.ar(sig, 100);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 0.25 * 4 * 16;
}.play(fadeTime: 0.1).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise2 = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, note2, note3, r, n;
    trig = Impulse.kr(~nT.tempo);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    note2 = Demand.kr(trig * block, 0, Dseq([0.4, 0.8], inf));
    note3 = Demand.kr(trig * block, 0, Dseq([0, 7, 9, 12], inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12 + 0,
        timbre: 1,
        color: [0.8, 0.95],
        model: 17,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = ;
    sig = (sig * 0.1) + MiRings.ar((sig[0] + sig[1])!2,
        pit: 12 + note.lag(0.1) + 12 + note3,
        struct: 0.9,
        bright: note2,
        damp: 0.2,
        pos: 0.25,
        model: 2
    );
        sig = LPF.ar(sig, 2000);
        sig = HPF.ar(sig, 100);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 0.25 * 4 * 16 * 4;
}.play(fadeTime: 0.1).register;
    });
)