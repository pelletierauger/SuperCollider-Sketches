~nT = TempoClock.new(1.39 * 2 * 1.3).permanent_(true);


(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block, timbre;
        trig = Impulse.kr(~nT.tempo);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        timbre = Demand.kr(trig * block, 0, Dseq([0, -2].stutter(4), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [10, 5] + timbre + 10 + 20,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 40,
            resamp: 2,
            decim: 32,
            bits: [4, 4],
            ws: 0
        ) * [env * 0.5, 1 - env] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig + (sig.reverse * 0.5) * 1;
    }.play(fadeTime: 0).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise3.isPlaying, {~crushedNoise3.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise3 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block, timbre;
        trig = Impulse.kr(~nT.tempo * 4);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        timbre = Demand.kr(trig * block, 0, Dseq([0, -2].stutter(4), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo * 4 / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [10, 5] + timbre + 10 + 20,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: [4, 4],
            ws: 0
        ) * [env * 0.5, 1 - env] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig = sig + (sig.reverse * 0.5) * 0.25;
        sig = MiRings.ar(sig, pit: 48 - 12, damp: 0.8, model: 2) * 1.7;
    }.play(fadeTime: 0).register;
});
)

//  Le bon


(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block, timbre;
        trig = Impulse.kr(~nT.tempo);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        timbre = Demand.kr(trig * block, 0, Dseq([0, -2].stutter(4), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [12, 5] + timbre + 67,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 11,
            resamp: 2,
            decim: 2,
            bits: [4, 4],
            ws: 0.5
        ) * [env * 0.5, 1 - env] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig + (sig.reverse * 0.25) * 1;
    }.play(fadeTime: 0).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
f.free;
f =    {
    var trig = Impulse.kr(~nT.tempo / 3);
        var no = Demand.kr(trig, 0, Dseq([0, 1, 0, 1, -2, -3, -4, -12].stutter(2), inf));
    var sig = MiPlaits.ar(31 + 24 + 12 + no,
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.1,
        lpg_colour: 0,
        mul: 8);
        sig = sig[0]!2;
        VadimFilter.ar(sig, 1000, 0, 1) * 0.5;
        // sig = Decimator.ar(sig, 100, 12);
        // sig = VadimFilter.ar(sig, 2000, 0, 1) * 1!2;
    }.play;
    nil;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
g.free;
g =    {
    var trig = Impulse.kr(~nT.tempo);
        var bl = trig * Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 0, 0], inf));
        var no = Demand.kr(bl, 0, Dseq([0, 3, 6, 5].stutter(2), inf));
    var sig = MiPlaits.ar(31 + 24 + 2 - 24 + no + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.25,
        trigger: bl,
        decay: 0.1,
        lpg_colour: 0,
        mul: 8);
        sig = [sig[0][0], sig[1][0]];
        // VadimFilter.ar(sig, 500, 0, 5) * 8;
        // sig = Decimator.ar(sig, 1000, 12);
        // sig = VadimFilter.ar(sig, 2000, 0, 1);
    }.play;
    nil;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise3.isPlaying, {~crushedNoise3.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise3 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block, timbre;
        trig = Impulse.kr(~nT.tempo);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        timbre = Demand.kr(trig * block, 0, Dseq([0, -2].stutter(4), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [12, 5] + timbre + 67 - 36 - 12,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 11,
            resamp: 2,
            decim: 2,
            bits: [4, 4],
            ws: 0.5
        ) * [env * 1, 1 - env] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig.reverse * 4 * 1;
    }.play(fadeTime: 0).register;
});
)
