(
~t.sched(~t.timeToNextBeat(quant: 4), {

    x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    x = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~t.tempo * 4) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var sig = MiBraids.ar(
            pitch: 45,
            timbre: 0.65,
            color: d,
            model: 34,
            trig: t
        );
        sig = VadimFilter.ar(sig, 200, 0.25, 1) * 1!2;
        Out.ar(~toC, sig);
    }.play(fadeTime: 0);
    ~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    ~x2 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
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
        sig = VadimFilter.ar(sig, SinOsc.kr(0.1).range(1000, 6000), 0.25, 5);
        Out.ar(~toC, sig);
    }.play(fadeTime: 0);
    ~t.sched(~t.timeToNextBeat(quant: 4), {
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~snare = {
        | trigGate = 1|
        var envGate = EnvGate.new();
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
        sig = VadimFilter.ar(sig, 8000, 0, 1);
            Out.ar(~toC, sig);
    }.play(fadeTime: 0);
});
});
)