(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0), {
    ~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine = {
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


(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0), {
    ~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine = {
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
        sig = MiRings.ar(sig, pit: 21 + 0, struct: 0.5, bright: 0.5, damp: 0.8, model: 2);
        sig = sig * 0.25;
        // Out.ar(~reverb, sig);
    }.play(fadeTime: 0.0).register;
});
)