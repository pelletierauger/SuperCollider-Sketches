(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3");
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2, pi).range(0.025, 0.85);
    var sig = MiBraids.ar(f - 12 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)



//  La distance éthérée.


(
~k.free;
~k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: ~toMidi.("B3") - 6,
        contour: 0.5,
        bow_level: 0.6,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.2,
        space: 0.99,
        model: 0
    );
    sig * 4;
}.play;
TempoClock.default.sched(4, {
    ~l.free;
    ~l = {
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var sig = MiElements.ar(
            gate: 1,
            pit: ~toMidi.("B3") - 6 + 3,
            contour: 0.5,
            bow_level: 0.6,
            bow_timb: 0.5,
            geom: 0.25,
            bright: 0.2,
            space: 0.99,
            model: 0
        );
        sig * 4;
    }.play;

    nil;});

)


// L’interférence

(
// 3:SINE_TRIANGLE
// ~toMidi.("F3")
var f = ~toMidi.("F3");
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 16;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 1 * [1, 1.001], lfo, lfo2, model, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, 2000, 0, 5) * 0.2 * Line.kr(0, 1, 10);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)


(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3") - 6;
~drone2.free;
~drone2 = {
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 16;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 2, decim: 5, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 2, decim: 5, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 2, decim: 5, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, model, resamp: 2, decim: 5, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, 3000, 0, 5);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)




(
k.free;
k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: ~toMidi.("B3") - 6 - 12 - 12,
        contour: 0.5,
        bow_level: 0.6,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.2,
        space: 0.99,
        model: 0
    );
    sig * 4;
}.play;
TempoClock.default.sched(4, {
    l.free;
    l = {
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var i = Impulse.kr(0.25);
        var d = Demand.kr(i, 0, Dseq([0, -3], inf));
        var sig = MiElements.ar(
            gate: 1,
            pit: ~toMidi.("B3") - 6 + 3 - 12 + d,
            contour: 0.5,
            bow_level: 0.6,
            bow_timb: 0.5,
            geom: 0.25,
            bright: 0.2,
            space: 0.99,
            model: 0
        );
        sig * 4;
    }.play;

    nil;});

)


(
    l.free;
    l = {
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var i = Impulse.kr(0.25);
        var d = Demand.kr(i, 0, Dseq([3, 0], inf));
        var sig = MiElements.ar(
        // blow_in: i,
            gate: 1,
            pit: ~toMidi.("F2") + d,
            contour: 0.5,
            bow_level: 0.6,
            bow_timb: 0.5,
            geom: 0.25,
            bright: 0.2,
            space: 0.99,
            model: 0
        );
    sig = VadimFilter.ar(sig, 4000, 0, 1);
        sig * 4;
    }.play;
)



(
k.set(\gate, 0, \fadeTime, 3);
k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: ~toMidi.("F1"),
        contour: 0.5,
        bow_level: 0.6,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.2,
        space: 0.99,
        model: 0
    );
    sig = VadimFilter.ar(sig, 4000, 0, 1);
    sig * 4;
}.play;
)


d ----6--6--6--6--3--3--1--1------------------------------------------------
b ---6--6--6--6--1--1--1--1--------------------------------------------------
g --5--5--4--4--1--1--0--0---------------------------------------------------
d ---------------------------------------------------------------------------
a ---------------------------------------------------------------------------
e --------------------------------------------------------------------------


   abrasion chromatique            sensation du Fa.
d ---------------------------------------------------------------------------
b --9-6-9-6-8-6-8-6-7-6-7-6-4------------------------------------------------
g ---------------------------------5-3-5-3-6-5-3-1-0-1-3-5-------------------
d ---------------------------------------------------------------------------
a ---------------------------------------------------------------------------
e ---------------------------------------------------------------------------




d ---------------------------------------------------------------------------
b ----8-8-8-8-9-9-9-9-7-7-7-7------------------------------------------------
g ----8-8-8-8-8-8-8-8-8-8-8-8-------------------------------------------------
d --------------------------------1--1--1--1------1--1----------1--1----------
a -------------------------------3--3--3--3------3--3----------3--3-----------
e ------------------------------1--1--4--4------1--1--2-2-2-2-1--1-----------


d ---------------------------------------------------------------------------
b ---------------------------------------------------------------------------
g --------------1--1--0--0---------------------------------------------------
d --1--1--3--3-1--1--1--1----------------------------------------------------
a -3--3--3--3-3--3--3--3-----------------------------------------------------
e 1--1--4--4-----------------------------------------------------------------




~nT = TempoClock.new(1.39 * 2 * 1.3).permanent_(true);

~nT.tempo = 1.39 * 2 * 1.3 * -5.midiratio;


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
        VadimFilter.ar(sig, 3700, 0.25, 1) * 0.25 * se;
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
        VadimFilter.ar(sig, 1700, 0.25, 1) * 3 * 0.5 * se;
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
        sig!2 * 1 * 0.25;«
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
        VadimFilter.ar(sig, 4700, 0.25, 1) * 8;
    }.play(fadeTime: 0);
});
)


// Les grues, étincelles

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
        var d3 = Demand.kr(t, 0, Dseq([3000, 3000].stutter(12 * 4), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * 0.1], [0, -8]), b);
        var sig = MiBraids.ar(
            pitch: 20 + 12,
            timbre: 0.75,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2 * e;
        // sig = (Decimator.ar(sig, 1000, 2) * 0.4);
        sig = VadimFilter.ar(sig, 2500, 0, 5);
        VadimFilter.ar(sig, 6700 + d3, 0.25, 1) * 4 * Line.kr(0, 1, 10);
    }.play(fadeTime: 0);
});
)


// Les grues crushy nova


(
~nT.sched(~nT.timeToNextBeat(quant: 12) + (~nT.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig, block0, block1, timbre0, timbre1;
        trig = Impulse.kr(~nT.tempo);
        block0 = Demand.kr(trig, 0, Dseq([1] ++ (0!23), inf));
        block1 = Demand.kr(trig, 0, Dseq((0!12) ++ [1] ++ (0!11), inf));
        timbre0 = Demand.kr(trig * block0, 0, Dseq([0, -2].stutter(1), inf));
        timbre1 = Demand.kr(trig * block1, 0, Dseq([0, -2].stutter(1), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.05;
        n = (~nT.tempo / 24).reciprocal;
        // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        env = EnvGen.kr(Env([0, 1, 0], [r, n - r]), [block0, block1]);
        sig = MiBraids.ar(
            pitch: [12, 5] + [timbre0, timbre1] + 67 - 5,
            timbre: 0.25,
            color: [0.95, 0.97] - 0.4,
            model: 11,
            resamp: 2,
            decim: 2,
            bits: [4, 4],
            ws: 0.5
        ) * env * [1, 2] * XLine.kr(0.001, 1, 0.05);
        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        sig = VadimFilter.ar(sig, 2000, 0, 1) * 4;
        sig + (sig.reverse * 0.25) * 0.25;
    }.play(fadeTime: 0).register;
});
)
