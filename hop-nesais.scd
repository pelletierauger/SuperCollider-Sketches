(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~x3b = {
        | trigGate = 1 |
        var td = Impulse.kr(~nT.tempo * 1) * trigGate;
        var t = Demand.kr(td, 0, Dseq([1, 0, 0, 0], inf)) * td;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 1.25], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var sig = MiBraids.ar(
            pitch: 27 + 36 + [0.0, 0.1],
            timbre: 0.125 + [0.0, 0.1],
            color: 0.95,
            model: 36,
            trig: t,
            resamp: 0,
            decim: \decim.kr(9) + [0, 4],
            bits: d,
            ws: 0
        )[0] ! 2 * 1 * env;
        sig = VadimFilter.ar(sig, 10000, 0, 1) + (sig * 0.5);
        // sig = sig + (VadimFilter.ar(sig, (27 + 36).midicps, 0.25, 3));
        // sig;
        // sig = Decimator.ar(sig, 100, 12) * 4;
        sig * 0.5;
        // VadimFilter.ar(sig, 100 + (10000 * env) + SinOsc.kr(0.1).range(0, 4000), 0, 3) * 0.4;
    }.play(fadeTime: 0);
});
)

(27 + 36).midicps