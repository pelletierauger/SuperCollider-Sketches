~t = TempoClock.new(1).permanent_(true);


(
~t.sched(~t.timeToNextBeat(quant: 4), {
if(~rub.isPlaying, {~rub.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~toMidi.("A2");
    x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 4) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var sig = MiBraids.ar(
            pitch: 45,
            timbre: 0.65,
            color: d,
            model: 34,
            trig: t
        );
        VadimFilter.ar(sig, 200, 0.25, 1) * 1!2;
    }.play(fadeTime: 0);
    ~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    ~x2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 4) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5], inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24,
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 22 + [0, 4],
            bits: d,
            ws: 0
        ) * 0.5 * env;
        VadimFilter.ar(sig, SinOsc.kr(0.1).range(1000, 6000), 0.25, 5);
    }.play(fadeTime: 0);
    ~t.sched(~t.timeToNextBeat(quant: 4), {
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~snare = {
        | trigGate = 1|
        var t = Impulse.kr(~t.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq([0, 1], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 4.85], [2, -2, 'lin']), b);

        var sig = MiBraids.ar(
            pitch: 15,
            timbre: 0.5,
            color: 1,
            model: 36,
            trig: b,
            resamp: 2,
            decim: 22,
            bits: 4,
            ws: 0
        ) * 0.5!2 * env;
        VadimFilter.ar(sig, 8000, 0, 1);
    }.play(fadeTime: 0);
});
});
)


    ~toMidi.("A3");
~toMidi.("")
62
~toNote.(60)
~toNote.(57)



// ------------------------------------------------------------------
// Une belle ligne de basse sourde et inquiète, hésitante.
// ------------------------------------------------------------------
~toMidi.("A0")

// La ligne de basse est en Si mineur.

(

~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0), {
    ~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([1, 1, 1, 1,    1, 1, 1, 0], inf)) * t;
        var note = Demand.kr(t, 0, Dseq((4!6) ++ ([8]) * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), d);

        var note2 = Demand.kr(d, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            [ 0, 3, 2, 5 ] ++ [ 0, 3, -7 ], inf));
        var sig = MiBraids.ar(
            pitch: 21 - 2 + 12 + note2 + [0, 0.01] - 0.49,
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = VadimFilter.ar(sig, 200 + (SinOsc.kr(0.1).unipolar * 400) * [1, 0.75], 0.25, 1);
        sig * 0.125 * 3 * [1, 3];
    }.play(fadeTime: 0.0).register;
});
)


s.record;
s.stopRecording;

~toNote.(10)
s.record(~rec +/+ "crush-test-2.aiff");
s.stopRecording;

(
~t.sched(~t.timeToNextBeat(quant: 4), {

    [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes0 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~t.tempo * 1 * 4) * trigGate;
        var sig = MiPlaits.ar(~toMidi.("C4") + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        VadimFilter.ar(sig, 5000, 0.25, 5) * 0.8 * 3;
    }.play.register;

    ~billes1 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~t.tempo * 2 * 4) * trigGate;
        var sig = MiPlaits.ar(~toMidi.("A3") + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        VadimFilter.ar(sig, 5000, 0.25, 5) * 0.8 * 3;
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, safeEnv;
        safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.05]));
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo * 0.125 * 0.5).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: [10, 9] * 0.25,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 2,
            bits: 2,
            ws: 0
        ) * [env * 0.75, 1 - env * Line.kr(0, 1, r)];
        // sig;
        sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig = sig * 0.75!2;
        // sig!2 * 0.5;
        // Amplitude.ar(sig).poll;
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        sig * safeEnv * 16;
    }.play(fadeTime: 0.0).register;
});
)

~t.beats
(
~t.sched(~t.timeToNextBeat(quant: 4), {
    x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);

    ~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~snare = {
        | trigGate = 1|
        var t = Impulse.kr(~t.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq([0, 1], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 4.85], [2, -2, 'lin']), b);

        var sig = MiBraids.ar(
            pitch: 15,
            timbre: 0.5,
            color: 1,
            model: 36,
            trig: b,
            resamp: 2,
            decim: 22,
            bits: 4,
            ws: 1
        ) * 2!2 * env * 1;
        sig = VadimFilter.ar(sig, 500, 0, 5);
        VadimFilter.ar(sig, 8000, 0, 1);
    }.play(fadeTime: 0);
});
)



// 1   2   3   4   1   2   3   4   1   2   3   4   1   2   3   4
// |.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.|.,.,.,.
// ----------------------------------------------------------------
// ------0-------0-------0-------0-------0-------0-------0-------0-
// --0-------0-------0-------0-------0-------0-------0-------0-----
// ----7-------7-------7-------7-------7-------5-------4-------4---
// 9-------9-------9-------9-------9-------7-------5-------5-------
// ----------------------------------------------------------------




(
x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
)


(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
[~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);

)