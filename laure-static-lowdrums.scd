(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 1);
    var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 1, 0, 0];
    var pat1 = [0, 0, 0, 0, 1, 0, 0, 0];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
        engine: 9,
        harm: 0.95,
        timbre: 1,
        morph: 0.45 - [0, 0.4, 0.4, 0.5],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 1, 1, 0.96] * 0.685,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 0.75;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
        sig = VadimFilter.ar(sig, 5500, 0, 1)  * 0.5;
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        // sig = sig * 1.6 * 3.5;
        // sig = sig.clip(-1, 1);
        sig = MiRings.ar(
            sig, 0, 30 - 12, struct: 0.15, bright: 0.85, damp: 0.1,
            pos: 0.05, model: 2) * 4;
        sig = (sig * 0.25) + VadimFilter.ar(sig, 50, 0, 5);
        // sig = VadimFilter.ar(sig, 8000, 0, 1);
}.play(fadeTime: 0.0).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 1);
    var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 1, 0, 0];
    var pat1 = [0, 0, 0, 0, 1, 0, 0, 0];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
        engine: 9,
        harm: 0.5,
        timbre: 1,
        morph: 0.25 - [0, 0.4, 0.4, 0.5],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 1, 1, 0.96] * 0.685,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 0.75;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
        sig = VadimFilter.ar(sig, 5500, 0, 1)  * 0.5;
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        // sig = sig * 1.6 * 3.5;
        // sig = sig.clip(-1, 1);
        sig = MiRings.ar(
            sig, 0, 30 - 12 - 12, struct: 0.15, bright: 0.85, damp: 0.1,
            pos: 0.05, model: 2) * 4;
        sig = (sig * 0.25) + (VadimFilter.ar(sig, 50, 0, 5) * 2);
        // sig = VadimFilter.ar(sig, 8000, 0, 1);
}.play(fadeTime: 0.0).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 1);
    var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 1, 0, 0];
    var pat1 = [0, 0, 0, 0, 1, 0, 0, 0];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
        engine: 9,
        harm: 0.5,
        timbre: 1,
        morph: 0.25 - [0, 0.4, 0.4, 0.5],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 1, 1, 0.96] * 0.685,
        lpg_colour: 0
    );
    var sig2 = [sig[1][0], sig[2][0]] * 0.75;
    sig = [sig[0][0] * 2 + (sig[3][0] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
        sig = VadimFilter.ar(sig, 5500, 0, 1)  * 0.5;
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        // sig = sig * 1.6 * 3.5;
        // sig = sig.clip(-1, 1);
        sig = MiRings.ar(
            sig, 0, 30 - 12 - 12, struct: 0.15, bright: 0.85, damp: 0.1,
            pos: 0.05, model: 2) * 4;
        sig = (sig * 0.25) + (VadimFilter.ar(sig, 50, 0, 5) * 2) * 4;
        // sig = VadimFilter.ar(sig, 8000, 0, 1);
}.play(fadeTime: 0.0).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 1);
    var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 1, 0, 0];
    var pat1 = [0, 0, 0, 0, 1, 0, 0, 0];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
        engine: 9,
        harm: 0.5,
        timbre: 1,
        morph: 0.25 - [0, 0.4, 0.4, 0.5],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 1, 1, 0.96] * 0.685,
        lpg_colour: 0
    );
    var sig2 = [sig[1][0], sig[2][0]] * 0.75;
    sig = [sig[0][0] * 2 + (sig[3][0] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
        sig = VadimFilter.ar(sig, 5500, 0, 1)  * 0.5;
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        // sig = sig * 1.6 * 3.5;
        // sig = sig.clip(-1, 1);
        sig = MiRings.ar(
            sig, 0, 30, struct: 0.15, bright: 0.85, damp: 0.1,
            pos: 0.05, model: 2) * 4;
        sig = (sig * 0.25) + (VadimFilter.ar(sig, 50, 0, 5) * 2) * 0.5;
        // sig = VadimFilter.ar(sig, 8000, 0, 1);
}.play(fadeTime: 0.0).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8) + (~nT.beatDur * 0), {

if(~crushedNoiseLow.isPlaying, {~crushedNoiseLow.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoiseLow = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n, dee;
    trig = Impulse.kr(~nT.tempo * 1 * 2) * trigGate;
    block = trig * Demand.kr(trig, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([0, 3, -2, -5].stutter(2), inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.1], [2, -8, 'lin']), block);
        dee = Demand.kr(trig, 0, Dseq([-6, -6, -3, -2].stutter(16), inf));

    sig = MiBraids.ar(
        pitch: 12 + -12 + [0, 0.1] + dee,
        timbre: 1 - env,
        color: [0.8] - 0.4 + (-6 * -0.1),
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * env.lag(1);
    sig = VadimFilter.ar(sig, 700 + SinOsc.ar(0.1).range(0, 1000) * 4, 0, 1) * 0.25;
                sig = MiRings.ar(
            sig, 0, 30 + 24 + dee, struct: 0.2, bright: 0.95, damp: 0.4,
            pos: 0.05, model: 2) * 1;
        // sig = (sig * 0.25) + (VadimFilter.ar(sig, 50, 0, 5) * 4) * 0.5;
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 8 * 2;
}.play(fadeTime: 0.1).register;
});
)



(
if(~crushedNoiseLow.isPlaying, {~crushedNoiseLow.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
)