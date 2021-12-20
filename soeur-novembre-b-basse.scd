(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0.5), {
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
            pitch: 21 + 12 + note2 + [0, 0.01] - 0.49,
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
        sig * 0.25 * 3 * [1, 3];
    }.play(fadeTime: 0.0).register;
});
)


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

s.record(~recFolder +/+ "sono-kick-test.aiff");
s.stopRecording;

(
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
)


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
            [ 0, 3, 5, 4 ] ++ [ 0, 3, -8 ], inf));
        var sig = MiBraids.ar(
            pitch: 21 + 5 + 12 + note2 + [0, 0.01] - 0.49,
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
        sig * 0.25 * 3 * [1, 3];
    }.play(fadeTime: 0.0).register;
});
)