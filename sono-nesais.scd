(
~t.sched(~t.timeToNextBeat(quant: 4), {
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~snare = {
        | trigGate = 1|
        var t = Impulse.kr(~t.tempo * 1.6) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.1, 2.85], [2, -4, 'lin']), b);
        var d = Demand.kr(b, 0, Dseq([0.5, 0.5, 0].rotate(2), inf));
        var p = Demand.kr(b, 0, Dseq([0, -2].stutter(6), inf));

        var sig = MiBraids.ar(
            pitch: 25 + p,
            timbre: d,
            color: 1 - (0.5 - d),
            model: 0,
            trig: b,
            resamp: 0,
            decim: 22,
            bits: 4,
            ws: 0
        ) * 0.25 * env;
    var amp = Amplitude.kr(sig * env.pow(1)).pow(1);
    VadimFilter.ar(sig, 600 + (amp.lag(0.2) * 12000), 0, 1) * 1!2;
    }.play(fadeTime: 0);
});
)


(
~t.sched(~t.timeToNextBeat(quant: 4), {

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
});
)