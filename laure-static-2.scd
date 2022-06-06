
~nT = TempoClock.new(1.39 * 2.5).permanent_(true);
~nT.tempo = 1.39;
~nT.tempo = 1.39 * 2.5;


(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1.5 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.0625).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 24,
        timbre: SinOsc.kr(0.125).unipolar,
        color: [0.8, 0.95] - 0.2,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = VadimFilter.ar(sig, 700 + SinOsc.ar(0.1).range(0, 2000), 0, 1);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.25 * 4;
}.play(fadeTime: 0.01).register;
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1 * 0.0625).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 0,
        timbre: SinOsc.kr(0.125).unipolar,
        color: [0.8, 0.95],
        model: 37,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = VadimFilter.ar(sig, 700 + SinOsc.ar(0.1).range(0, 2000), 0, 1) + (sig * 0.05);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 1 * 4;
}.play(fadeTime: 0.01).register;
});
)



// ----------------------------------------------------------------------
// Version mono, l'idée originale simplement exprimée
// ----------------------------------------------------------------------


(
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 2.5);
    var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
    var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 24] + 24 - [24, 12, 12],
        engine: 9,
        harm: 0.95,
        timbre: 1,
        morph: 0.45 - [0, 0.2],
        trigger: trig * [block0, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, dm],
        lpg_colour: 0
    );
    sig = [sig[0][1] + (sig[1][1] * 1.5) + (sig[2][1] * 0.125)]!2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 3.6;
}.play(fadeTime: 0.01).register;
)

~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);




// ----------------------------------------------------------------------
// Version stéréo, bien meilleure
// ----------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
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
        decay: 0.0 + [0.9, 1, 1, 0.76] * 0.685,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 0.75;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
        sig = VadimFilter.ar(sig, 5500, 0, 1);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 1.6 * 0.5;
}.play(fadeTime: 0.01).register;
});
)

// ----------------------------------------------------------------------
// rimshots
// ----------------------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~rim = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 1);
    var pat0 = [1, 0, 0, 0, 0, 1, 0, 0].rotate(-2);
    var pat1 = [0, 0, 1, 0, 0, 0, 1, 1].rotate(-2);
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq((0.65!1) ++ (0.5!23) ++ (0.65!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-12!24 ++ (-24!8), inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0 + 12 + pit,
        engine: 10,
        harm: 0.15,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.9] * dec * 1.7,
            // timb_mod: 0.5,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.5)]!2 + sig2;
        sig = VadimFilter.ar(sig, 2700, 0, 1) * 2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 0.6 * 0.5;
}.play(fadeTime: 0.01).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    d.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    d = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2 * 0.125) * trigGate;
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq([0, -5], inf));
        var sig = MiBraids.ar(
            pitch: 36 + 12 + 12 - 12 + note2 + [0, 0.1],
            timbre: 0.9 + [-0.05, 0.05],
            color: 0.2,
            model: 35,
            trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 400 + (SinOsc.kr(0.1).unipolar * 400));
        sig * 0.25 * 16;
    }.play;
});
)

~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes0 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2) * trigGate;
        var sig = MiPlaits.ar(31 + 28 + -1 + 4 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.8 * 3;
    }.play.register;

   ~billes1 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
        var sig = MiPlaits.ar(28 + 24 + 5 + -2 + 4 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.8 * 3;
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq([0, -3, -2, -5], inf));
        var sig = MiBraids.ar(
            pitch: 60 - 5 - 12 - 7 + note2 + [0, 0.01],
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 400 + (SinOsc.kr(0.1).unipolar * 400) * [1, 0.75]);
        sig * 0.25 * 3 * [1, 3];
    }.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~rim = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 2);
    var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
    var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq(0!24 ++ (0.75!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(0!24 ++ (-24!8), inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 24 + 12 + pit,
        engine: 9,
        harm: 0.95,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * dec,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 3.6;
            sig = sig * 1 + (CombC.ar(in: sig,
    maxdelaytime: 0.5,
    delaytime: ~nT.tempo * [0.125, 0.126] * 0.125,
    decaytime: 1,
            mul: 1, add: 0) * 0.125 * 0);
}.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1.5 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 0.125).reciprocal;
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
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.25 * 16;
}.play(fadeTime: 0.01).register;
});
)