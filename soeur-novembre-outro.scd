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
~t.sched(~t.timeToNextBeat(quant: 4), {
    ~chor.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~chor = {
        | trigGate = 1|
        var t = Impulse.kr(~t.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
        var dT = DelayN.ar(b!3, 0.2, (0..2)/10);
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 4.85], [2, -2, 'lin']), dT);

        var sig = MiBraids.ar(
            pitch: ~toMidi.("D2") + 24 + [-5, -10, 3] + 12,
            timbre: 0,
            color: 0,
            model: 0,
            // trig: ,
            resamp: 0,
            decim: 22,
            bits: 4,
            ws: 0
        );
        sig = sig * env;
        sig = sig.sum;
        sig = VadimFilter.ar(sig, 500, 0, 5);
        VadimFilter.ar(sig, 1000, 0, 1) * 0.5!2;
    }.play(fadeTime: 0);
});
)





(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0), {
    ~synthLine2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
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
~t.sched(~t.timeToNextBeat(quant: 4) - 0.25, {
    ~chor.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~chor = {
        | trigGate = 1|
        var envGate = EnvGate.new(fadeTime: 0);
        var t = Impulse.kr(~t.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
        var cc = Demand.kr(b, 0, Dseq([[-5, -10, 3], [-3, -10, 4]], inf));
        var dT = DelayN.kr(b!3, 0.2, (0..2)/10 * 2);
        var env = EnvGen.kr(Env([0, 1, 0], [0.5, 4.85], [2, -2, 'lin']), dT);
        var sig = MiBraids.ar(
            pitch: ~toMidi.("D2") + 24 + cc + 12,
            timbre: 0.2 + (1 - env * 0.8),
            color: 0.5,
            model: 5,
            resamp: 0,
            decim: 22,
            bits: 4,
            ws: 0
        );
        // sig = sig * env;
        var lfo = SinOsc.kr((3..5) + 2).range(0.6, 1);
        // env.size.poll
        sig = VadimFilter.ar(sig, 500 + (2000 * env * lfo), 0, 1) * env;
        // sig = sig.sum;
        sig = VadimFilter.ar(sig, 50, 0, 5) * 0.35!2 * envGate;
        Out.ar(0, sig * 0.25);
        Out.ar(~reverb, sig);
    }.play();
});
)



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
            decim: 12,
            bits: 4,
            ws: 0
        ) * 2!2 * env * 1;
        sig = VadimFilter.ar(sig, 200, 0, 5);
        VadimFilter.ar(sig, 3000, 0, 1) * 2;
    }.play(fadeTime: 0);
});
)



(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0.5), {
    ~synthLine2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([1, 1, 1, 1,    1, 1, 1, 0], inf)) * t;
        var note = Demand.kr(t, 0, Dseq((4!6) ++ ([8]) * 32 * 1.5, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.2, 0.125 * note], [2, -8, 'lin']), d);

        var note2 = Demand.kr(d, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            [ 3, 2, 3, 2 ] ++ [ 3, 2, 0 ]  /*++ [ 3, 2, 5, 9 ] ++ [ 3, 7, 0 ]*/ + 24, inf));
        var sig = MiBraids.ar(
            pitch: 21 - 2 + 12 + note2 + [0, 0.01] - 0.49 - 12,
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env * env;
        sig = VadimFilter.ar(sig, 400 + (SinOsc.kr(~t.tempo / 4).range(0.25, 1) * 1200 * env) * [1, 0.75], 0.25, 1);
        sig.reverse * 0.25 * 3 * [1, 3];
    }.play(fadeTime: 0.0).register;
});
)


(
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
            // [ -3 + 12 ]  /*++ [ 3, 2, 5, 9 ] ++ [ 3, 7, 0 ]*/
            (-2!5) ++ (-2!1) ++ (-2!2) - 12
            + 24, inf));
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
        sig = sig.reverse * 0.125 * 0.5 * [1, 3];
        sig = MiRings.ar(sig, 0, 21 - 2 + 0 + note2, model: 1) * 1
    }.play(fadeTime: 0.0).register;
});
)