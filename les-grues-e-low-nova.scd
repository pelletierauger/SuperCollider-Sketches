~nT = TempoClock.new(1.39 * 2 * 1.3).permanent_(true);

~nT.tempo = 1.39 * 2 * 1.3 * -5.midiratio;
~nT.tempo

s.record;
s.stopRecording;


~toMidi.("E1") + 36

[0, 1, 0, 1, -2, -3, -4, -5] - 2

(
~nT.sched(~nT.timeToNextBeat(quant: 12) - 0.1, {
    f.set(\trigGate, 0, \relGate, 1);
});
~nT.sched(~nT.timeToNextBeat(quant: 12) + 0.05, {
    // f.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
    f =    {
        | trigGate = 1, relGate = 0 |
        // var envGate = EnvGate.new(fadeTime: 0);

        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 5], ['lin', 8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var trig0 = Impulse.kr(~nT.tempo) * trigGate;
        var trig = trig0 * Demand.kr(trig0, 0, Dseq(
            // [1, 0, 0, 0, 1, 0],
            [1, 0, 0, 1, 0, 0],
        inf));
        var no = Demand.kr(trig, 0, Dseq(
            // [-5, -5, -2, -4, -5, -5, -6, -7].stutter(2) + [0, 0].stutter(8)
            [-5, -5, -6, -4].stutter(2) + [0, 0].stutter(8)
            , inf)
        );
        var acc = Demand.kr(trig, 0, Dseq([0.5, 0.6].stutter(4), inf));
        var sig = MiPlaits.ar(64 + no,
            engine: 11,
            harm: 0.25,
            timbre: 0.2,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 8);
        sig = sig[0]!2;
        sig = VadimFilter.ar(sig, 1000, 0, 1) * 0.5 * amp;
        VadimFilter.ar(sig, 200, 0, 5);
        // sig = Decimator.ar(sig, 100, 12);
        // sig = VadimFilter.ar(sig, 2000, 0, 1) * 1!2;
    }.play(fadeTime: 0);
    nil;
});

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
        var sig = MiPlaits.ar(28 + no + [0, 0.1],
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
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq(
            [0, 0, 0, 1, 0, 0] ++ [0, 0, 0, 0, 1, 0]
            , inf));
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([0, 500].reverse.stutter(4), inf));
        var d3 = Demand.kr(b, 0, Dseq([2, 1], inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * d3], [0, 6]), b);
        var se = EnvGen.kr(Env([0, 0, 1], [0.1, 0.1]));
        var sig = MiBraids.ar(
            pitch: 20,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 2) * 0.4);
        sig = VadimFilter.ar(sig, 500 + d2, 0, 5);
        VadimFilter.ar(sig, 3700, 0.25, 1) * 3 * se;
    }.play(fadeTime: 0);
    z.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq(
            [0, 0, 1, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0] ++
            [0, 0, 1, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0]// ++
            // ([0, 0, 1, 0, 0, 1]).wrapExtend(6 * 4)
            , inf));
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([500, 1000].stutter(4), inf));
        var d3 = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0.5], inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * d3], [0, 6]), b);
        var se = EnvGen.kr(Env([0, 0, 1], [0.1, 0.1]));
        var sig = MiBraids.ar(
            pitch: 0,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 4) * 0.4);
        sig = VadimFilter.ar(sig, 100, 0, 5);
        VadimFilter.ar(sig, 1700, 0.25, 1) * 3 * 3 * se;
    }.play(fadeTime: 0);
        if(~crushedNoiseSpara.isPlaying, {~crushedNoiseSpara.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoiseSpara = {
        | trigGate = 1 |
        var sig, env, delrd, r, n;
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: [10, 0],
            timbre: 0.25,
            color: [0.95, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: [4, 3],
            ws: 0
        ) * [env * 0.5, 1 - env];
        sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig!2 * 1 * 0.5;
    }.play(fadeTime: 0.01).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    v.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    v = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq(
            [1, 0]
            , inf));
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([500, 1000].reverse.stutter(4), inf));
        var d3 = Demand.kr(b, 0, Dseq([2, 1], inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * d3], [0, 6]), b);
        var sig = MiBraids.ar(
            pitch: 20,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 2) * 0.4);
        sig = VadimFilter.ar(sig, 4000, 0, 5);
        VadimFilter.ar(sig, 7700, 0.25, 1) * 2;
    }.play(fadeTime: 0);
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    w.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    w = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq(
            ([1, 0, 1, 0, 1, 0]).wrapExtend(6 * 3) ++ [1, 1, 1, 1, 1, 1]
            , inf));
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([500, 1000].reverse.stutter(4), inf));
        var d3 = Demand.kr(t, 0, Dseq([3000, 8000].stutter(12 * 4), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * 0], [0, -8]), b);
        var sig = MiBraids.ar(
            pitch: 20,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2 * e;
        sig = (Decimator.ar(sig, 1000, 2) * 0.4);
        sig = VadimFilter.ar(sig, 2500, 0, 5);
        VadimFilter.ar(sig, 6700 + d3, 0.25, 1) * 8;
    }.play(fadeTime: 0);
});
)


-10---8---11---10--------6---5---8---6------5---3---6---5---------------
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------


------------------------------------------------------------------------
----3-----0------5------6---------------------------------------------------
---2-----0------4------7---------------------------------------------------
--2-----2------4------7----------------------------------------------------
-0-----3------6------5------------------------------------------------------
------------------------------------------------------------------------

