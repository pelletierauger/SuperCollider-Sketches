(
~t.sched(~t.timeToNextBeat(quant: 6), {
    z.set(\fadeTime, 0.01, \gate, 0);
    ~synthLine3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    [~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
    x.set(\fadeTime, 0.01, \gate, 0);
    y.set(\gate, 0, \fadeTime, 0.1);
    x = {
        | freeze = 0 |
        var t = Impulse.kr(~t.tempo);
        var bl = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        var sig = PlayBuf.ar(2, b, -2.midiratio, bl, startPos: 0, loop: 0);
        var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        sig = sig * 0.7 + VadimFilter.ar(sig2, 500, 0, 0) * 2;
        sig + (sig3 * 0.2) * 0.2;
    }.play(fadeTime: 0);
});
~t.sched(~t.timeToNextBeat(quant: 6) - (~t.beatDur * 0), {
    ~synthLine4.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~synthLine4 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 2) * trigGate;
        var bl = t * Demand.kr(t, 0, Dseq(
            [0, 0, 1, 0, 1, 0] ++ [0, 1, 0, 0, 1, 0], inf));
        var acc = Demand.kr(bl, 0, Dseq([0, 0.2], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [2, -8, 'lin']), bl);

        var note = Demand.kr(bl, 0, Dseq([0, -4, -5, -4].stutter(4), inf));
        var note2 = Demand.kr(bl, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            // [ -3 + 12 ]  /*++ [ 3, 2, 5, 9 ] ++ [ 3, 7, 0 ]*/
            (-3!5) ++ (-5!1) ++ (-3!2)
            + 24, inf));
        var sig = MiBraids.ar(
            pitch: 24 + 24 + 12 + note,
            timbre: acc * 0.25 * env,
            color: acc * 0.5,
            model: 3,
            // trig: t,
            resamp: 0,
            decim: 12,
            bits: 2,
            ws: 0
        ) * env;
        // sig = VadimFilter.ar(sig, 1400 + (SinOsc.kr(6).unipolar * 2200 * env) * [1, 0.75], 0.25, 1);
        sig = VadimFilter.ar(sig, 100 + (5000 * env), 0, 1);
        // sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0, type: 0) * 0.25;
        sig = sig!2 * 0.25;
        // MiRings.ar(sig, bl, pit: 24 + 12 + note, damp: 0.5, model: 0);
        // sig = sig.reverse * 0.125 * 0.5 * [1, 3] * 0.5;
        // sig = MiRings.ar(sig, 0, 21 - 2 + 0 + note2, model: 1) * 0.25;
    }.play(fadeTime: 0.0).register;
});
)


(
~t.sched(~t.timeToNextBeat(quant: 6) - (~t.beatDur * 0), {
    ~synthLine4.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~synthLine4 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 2) * trigGate;
        var bl = t * Demand.kr(t, 0, Dseq(
            [0, 0, 1, 0, 1, 0] ++ [0, 1, 0, 0, 1, 0], inf));
        var acc = Demand.kr(bl, 0, Dseq([0, 0.2], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 6], [2, -8, 'lin']), bl);

        var note = Demand.kr(bl, 0, Dseq([0, -4, -5, -4].stutter(4), inf));
        var note2 = Demand.kr(bl, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            // [ -3 + 12 ]  /*++ [ 3, 2, 5, 9 ] ++ [ 3, 7, 0 ]*/
            (-3!5) ++ (-5!1) ++ (-3!2)
            + 24, inf));
        var sig = MiBraids.ar(
            pitch: 24 + 24 + 24 - 2 + note - 0.49,
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 2,
            decim: 12,
            bits: 5,
            ws: 0
        ) * env;
        // sig = VadimFilter.ar(sig, 1400 + (SinOsc.kr(6).unipolar * 2200 * env) * [1, 0.75], 0.25, 1);
        sig = sig * VadimFilter.ar(sig, 1000 + (5000 * env), 0, 1);
        // sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0, type: 0) * 0.25;

        sig = sig!2 * 0.25;
        // MiRings.ar(sig, bl, pit: 24 + 12 + note, damp: 0.5, model: 0);
        // sig = sig.reverse * 0.125 * 0.5 * [1, 3] * 0.5;
        sig = sig * MiRings.ar(
            sig, 0,
            46 + note - 24,
            struct: 0.15,
            bright: 0.5,
            damp: 1,
            model: 1) * 0.5 * 4;
        sig = VadimFilter.ar(sig, 2000, 0, 5) * 1.5;
    }.play(fadeTime: 0.0).register;
});
)