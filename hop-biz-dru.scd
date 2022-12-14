(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~x3b = {
        | trigGate = 1 |
        var td = Impulse.kr(~nT.tempo * 2) * trigGate;
        var t = Demand.kr(td, 0, Dseq([1, 0, 0].wrapExtend(15) ++ (0!17), inf)) * td;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 9.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var sig = MiBraids.ar(
            pitch: 27 + 12 + [0.0, 0.1],
            timbre: 0.965 + [0.0, 0.1],
            color: 0.2,
            model: 36,
            trig: t,
            resamp: 2,
            decim: \decim.kr(9) + [0, 4],
            bits: d,
            ws: 0
        ).sum * 4 * env;
        VadimFilter.ar(sig, 100 + (10000 * env) + SinOsc.kr(0.1).range(0, 4000), 0, 1) * 0.4 ! 2;
    }.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~x3bd.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~x3bd = {
        | trigGate = 1 |
        var td = Impulse.kr(~nT.tempo * 2) * trigGate;
        var t = Demand.kr(td, 0, Dseq([1, 0, 0].wrapExtend(15) ++ (0!17), inf)) * td;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 9.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var sig = MiBraids.ar(
            pitch: 27 + 0 + [0.0, 0.1],
            timbre: 0.5 + [0.0, 0.1],
            color: 1,
            model: 36,
            trig: t,
            resamp: 2,
            decim: \decim.kr(22) + [0, 4],
            bits: d,
            ws: 0
        ).sum * 4 * env;
                sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.5;
        VadimFilter.ar(sig, 100 + (10000 * env) + SinOsc.kr(0.1).range(0, 4000), 0, 1) * 0.4 ! 2;
        sig = Compander.ar(sig, sig,
        thresh: MouseX.kr(0.01, 1),
        slopeBelow: 1,
        slopeAbove: 0.5,
        clampTime:  0.01,
                    relaxTime:  0.01

        );
        sig * 0.8 ! 2;
    }.play(fadeTime: 0);
});
)