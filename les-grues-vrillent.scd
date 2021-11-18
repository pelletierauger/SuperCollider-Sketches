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
        r = 0.1;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        sig = MiBraids.ar(
            pitch: [10, 5] + timbre + 23,
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

~nT.sched(~nT.timeToNextBeat(quant: 12), {
    g.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
    g =    {
        | trigGate = 1 |
        var envGate = EnvGate.new;
        var trig = Impulse.kr(~nT.tempo) * trigGate;
        var bl = trig * Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 0, 0], inf));
        var amp = Demand.kr(bl, 0, Dseq([1, 1, 0.1], inf)).lag(0.1);
        var no2 = Demand.kr(bl, 0, Dseq([1, 1, 0.25], inf)).lag(0.1);
        var no = Demand.kr(bl, 0, Dseq([0, 3, 6, 5].stutter(2), inf));
        var sig = MiPlaits.ar(33 + no + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25 * 1,
            trigger: bl,
            decay: 0.1,
            lpg_colour: 0,
            mul: 8);
        sig = [sig[0][0], sig[1][0]] * envGate;
        // sig = VadimFilter.ar(sig, 2000, 0, 1);
        // VadimFilter.ar(sig, 500, 0, 5) * 8;
        // sig = Decimator.ar(sig, 1000, 12);
        sig = VadimFilter.ar(sig, 200 + (800), 0, 1) * 1;
    }.play;
    nil;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 12) - 0.1, {
    f.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
});
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    // f.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
    f =    {
        | trigGate = 1 |
        var envGate = EnvGate.new;
        var trig = Impulse.kr(~nT.tempo) * trigGate;
        var bl = trig * Demand.kr(trig, 0, Dseq(
            [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 0, 0] ++
            [1, 0, 0, 1, 0, 1] ++ [0, 0, 0, 1, 0, 0]
            , inf));
        var no = Demand.kr(bl, 0, Dseq([0, 1, 0, 1, -2, -3, -4, -5].stutter(2), inf));
        var sig = MiPlaits.ar(31 + 24 + 12 + no,
            engine: 11,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: bl,
            decay: 0.1,
            lpg_colour: 0,
            mul: 8);
        sig = sig[0]!2;
        VadimFilter.ar(sig, 1000, 0, 1) * 0.5 * envGate;
        // sig = Decimator.ar(sig, 100, 12);
        // sig = VadimFilter.ar(sig, 2000, 0, 1) * 1!2;
    }.play;
    nil;
});
)



(
    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    f.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
    g.set(\trigGate, 0, \gate, 0, \fadeTime, 10);

)