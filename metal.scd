~nT.tempo

~nT = TempoClock.new(1.39).permanent_(true);

// --------------------------------------------------------
// Fuzz emiter, riff.
// --------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes6 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 1;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * [3] * 1) * trigGate;
        var block = Demand.ar(trig, 0, Dseq([0, 0, 1], inf));
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0,
            Dseq((0!4) ++ (-2!4) ++ (-5!3) ++ (-4!1) ++ (-5!3) ++ (-5!1), inf));
        var dem2 = Demand.ar(trig * block, 0,
            Dseq([0.01, 1, 1, 1].stutter(4), inf));
        var sig = MiPlaits.ar(24 + [0, 0.05, 12, 12.05, 19, 19.05],
            engine: 11,
            harm: 0.25,
            timbre: 0.125,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            // morph: 0.4,
            trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0] + sig[2][0] + sig[4][0], sig[1][0] + sig[3][0] + sig[5][0]];
        sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;
        sig = sig * 0.5 * 4;

        Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.5);
        Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 1);
    }.play.register;
});
)

// --------------------------------------------------------
// Fuzz receiver.
// --------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0), {

if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise2 = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 0.5);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 0.25).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 24,
        timbre: 1,
        color: [0.8, 0.95],
        model: 37,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.25 * 6 * 2 * In.ar(~bu, 2);
}.play(fadeTime: 0.01).register;
});
)


// --------------------------------------------------------
// Fuzz bas.
// --------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0), {

if(~crushedNoiseDry.isPlaying, {~crushedNoiseDry.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoiseDry = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 0.5);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 0.25).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 24 - 12,
        timbre: 1,
        color: [0.8, 0.95],
        model: 37,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.25 * 6 * 0.25;
}.play(fadeTime: 0.01).register;
});
)


// --------------------------------------------------------
// Drum extrêmement vaseux.
// --------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~rim = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1, 1, 1, 1, 0, 0, 1, 0];
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq(0.75!24 ++ (0.75!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-24!16 ++ (-24!16) - 12, inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: [ 48, 60, 60, 84 ] - 12 + pit + 12 - 12,
            engine: 9,
            harm: 0.9,
            timbre: [0.5, 1, 1, 0.5].rotate(2),
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2],
            decay: 0.3 + [0.9, 0.6, 0.6, 0.7] * dec,
            lpg_colour: 0
        );
        var envBl = EnvGen.kr(Env([0, 0, 1], [0.5, 0.01]));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * 4 * envBl;
        sig = [sig[0][1] * 1 + (sig[3][1] * 1)]!2 + sig2;
        // sig = LPF.ar(sig, 4000);
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 0.5 * 0.1;
        Out.ar(~bu, sig);
        // Out.ar(0, sig);
    }.play(fadeTime: 0.01).register;
});
)

(

[~rim, ~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
if(~crushedNoiseDry.isPlaying, {~crushedNoiseDry.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes6 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 1;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * [3] * 1) * trigGate;
        var block = Demand.ar(trig, 0, Dseq([0, 0, 1], inf));
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0,
            Dseq((0!4) ++ (-2!4) ++ (-5!3) ++ (-4!1) ++ (-5!3) ++ (-5!1), inf));
        var dem2 = Demand.ar(trig * block, 0,
            Dseq([0.01, 1, 1, 1].stutter(4), inf));
        var sig = MiPlaits.ar(24 + 24 + 24 + dem.lag(dem2) + [0, 0.05],
            engine: 11,
            harm: 0.25,
            timbre: 0.125,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0], sig[1][0]];
        sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;
        sig = sig * 0.5;
        sig = sig.clip(-0.001, 0.001) * 16;
            sig = LPF.ar(sig, 2000) * 2;
        Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.5);
        Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 1);
    }.play.register;
});
)