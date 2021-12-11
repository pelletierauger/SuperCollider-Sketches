~t = TempoClock.new(1).permanent_(true);

(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0.25), {
    ~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([1, 1, 1, 1], inf)) * t;
        var note = Demand.kr(t, 0, Dseq((4!6) ++ ([8]) * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.125 * note], [2, -8, 'lin']), d);

        var note2 = Demand.kr(d, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            [ 0, 3, 2, 5 ], inf) +
        Dseq([0, -3].stutter(4), inf)
        );
        var note3 = Demand.kr(d, 0, Dseq([12, 9].stutter(4), inf));
        var sig = MiBraids.ar(
            pitch: 21 + 24 + note2 + [0, 0] - 0.49,
            timbre: 0.8,
            color: 0.6,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32 + [0, 1],
            bits: 2,
            ws: 1
        ) * env;
        // sig = Decimator.ar(sig, 1000, 2);
        // sig = VadimFilter.ar(sig, 6200 + (SinOsc.kr(0.1).unipolar * 400), 0, 1);
        sig = MiRings.ar(
            sig,
            pit: 21 + note3 - 12, struct: 0.25,
            bright: env * 0.5, damp: 0.8, model: 0, pos: 0.24, poly: 2);
        // sig = VadimFilter.ar(sig, 2000, 0, 1);
        sig = sig * 0.4;
        // Out.ar(~reverb, sig);
    }.play(fadeTime: 0.1).register;
});
)

(
~t.sched(~t.timeToNextBeat(quant: 2), {

    ~x3.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1);
    ~x3 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 4) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(2) - 2, inf));
        var d2 = Demand.kr(t, 0, Dseq([0.5, 0.15, 0.15, 0.15].rotate(0), inf));
        var sig = MiBraids.ar(
            pitch: 45 + 0 + 0 + [0.0, 0.1],
            timbre: 0.65 + [0.0, 0.1],
            color: d2,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 19 + [0, 4],
            bits: d,
            ws: 0
        ) * 1 * env;
        var lfo = SinOsc.kr(0.1).range(0, 400);
    // sig;
        sig = VadimFilter.ar(sig, 50, 0, 5);
        sig = sig * Decimator.ar(sig, 1000, 1) * 1;
    sig = VadimFilter.ar(sig, 1100 + (2000 * env.pow(3)) + lfo, 0, 1) * 2;
    sig * 0.25;
    }.play(fadeTime: 0);
});
)

(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0), {
    ~synthLine2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([1, 1, 1, 1,    1, 1, 1, 0], inf)) * t;
        var note = Demand.kr(t, 0, Dseq((4!6) ++ ([8]) * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.125 * note], [2, -8, 'lin']), d);

        var note2 = Demand.kr(d, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            [ 0, 3, 2, 5 ] ++ [ 0, 3, -7 ], inf));
        var sig = MiBraids.ar(
            pitch: 21 + 24 + note2 + [0, 0] - 0.49,
            timbre: 0.8,
            color: 0.6,
            model: 43,
            // trig: t,
            resamp: 2,
            decim: 32 + [0, 1],
            bits: 2,
            ws: 1
        ) * env;
        // sig = Decimator.ar(sig, 1000, 2);
        sig = VadimFilter.ar(sig, 6200 + (SinOsc.kr(0.1).unipolar * 400), 0, 1);
        sig = MiRings.ar(sig, pit: 21 + 0, struct: 0.25, bright: 1, damp: 0.8, model: 2);
        sig = sig * 0.1;
        // Out.ar(~reverb, sig);
    }.play(fadeTime: 0.5).register;
});
)



// Très doux, feutré

(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLowB = {
        var trig = Impulse.ar((1 / (~t.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0], inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0], inf));
        var pitch = Demand.ar(trig * block, 0, Dseq([0, -3].stutter(2), inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 45 - 12 + pitch,
            timbre: 0.5,
            color: 0.0 + [0, 0.01],
            model: 0,
            resamp: 2,
            decim: 32,
            bits: 16,
            ws: 0
        );
        // sig = LPF.ar(sig, 4000);
        sig = sig * 0.6;
        sig = MiRings.ar(sig,
            pit: 45 - 12 * [1, 1.005],
            struct: 0.4,
            bright: 1,
            // pos: 0,
            model: 1
        ) * 0.1;
        [sig[1], sig[0]] * 1;
    }.play(fadeTime: 0.1);
});
)