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
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0.5), {
    ~synthLine2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([1, 1, 1, 1,    1, 1, 1, 0], inf)) * t;
        var note = Demand.kr(t, 0, Dseq((4!6) ++ ([8]) * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), d);

        var note2 = Demand.kr(d, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            [ 3, 2, 3, 2 ] ++ [ 3, 2, 0 ]  /*++ [ 3, 2, 5, 9 ] ++ [ 3, 7, 0 ]*/ + 24, inf));
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
        ) * env * env;
        sig = VadimFilter.ar(sig, 2400 + (SinOsc.kr(6).unipolar * 1200 * env) * [1, 0.75], 0.25, 1);
        sig.reverse * 0.125 * 0.5 * [1, 3];
    }.play(fadeTime: 0.0).register;
});
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 0.5), {
    ~synthLine3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine3 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([1, 1, 1, 1,    1, 1, 1, 1], inf)) * t;
        var note = Demand.kr(t, 0, Dseq((4!6) ++ ([8]) * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), d);

        var note2 = Demand.kr(d, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            [ -3 + 12 ]  /*++ [ 3, 2, 5, 9 ] ++ [ 3, 7, 0 ]*/ + 24, inf));
        var sig = MiBraids.ar(
            pitch: 21 - 2 + 12 + note2 + [0, 0.01] - 0.49,
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 22,
            bits: 3,
            ws: 0
        ) * env * env;
        sig = VadimFilter.ar(sig, 1400 + (SinOsc.kr(6).unipolar * 2200 * env) * [1, 0.75], 0.25, 1);
        sig.reverse * 0.125 * 0.5 * [1, 3];
    }.play(fadeTime: 0.0).register;
});
)