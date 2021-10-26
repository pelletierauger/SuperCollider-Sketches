(
~t.sched(~t.timeToNextBeat(quant: 4), {

    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3b = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 8) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 4, inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24 + 24 + [0.0, 0.1],
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 29 + [0, 4],
            bits: d,
            ws: 0
        ) * 1 * env;
    // sig;
    sig = Decimator.ar(sig, 100, 12) * 4;
    VadimFilter.ar(sig, 100 + (3000 * env) + SinOsc.kr(0.1).range(0, 4000), 0.25, 5) * 4;
    }.play(fadeTime: 0);
});
)


(
~t.sched(~t.timeToNextBeat(quant: 4), {

    ~x3.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 8) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 4, inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24 + 24 + [0.0, 0.1],
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 29 + [0, 4],
            bits: d,
            ws: 0
        ) * 1 * env;
    // sig;
    sig = Decimator.ar(sig, 200, 22) * 8;
    VadimFilter.ar(sig, 100 + (3000 * env) + SinOsc.kr(0.1).range(0, 4000), 0.25, 5) * 4;
    }.play(fadeTime: 0);
});
)



// ------------------------------------------------------------------
// Shake sourd et nerveux.
// ------------------------------------------------------------------

(
~t.sched(~t.timeToNextBeat(quant: 4), {

    ~x3.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 8) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 4, inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24 + 0 + [0.0, 0.1],
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 29 + [0, 4],
            bits: d,
            ws: 0
        ) * 1 * env;
    // sig;
    sig = Decimator.ar(sig, 200, 22) * 8;
    VadimFilter.ar(sig, 100 + (3000 * env) + SinOsc.kr(0.1).range(0, 4000), 0.25, 1) * 1;
    }.play(fadeTime: 0);
});
)