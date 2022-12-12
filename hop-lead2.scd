(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    ~lead2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~lead2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 1.5 * 1) * trigGate;
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        // var dr = Demand.kr(t, 0, Dwrand([1, 0], [0.9, 0.1], inf));
        var dr = Demand.kr(t, 0, Dseq([1, 1, 1, 1, 1, 1] ++ [1, 0, 0, 1, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 0.5], [2, -8, 'lin']), t);
        var d2 = Demand.kr(t, 0, Dseq(
            [
                13, 13, 11, 9,
                13, 13, 11, 9,
                12, 12, 11, 9,
                13, 13, 11, 9
            ]
            .stutter(3), inf));
        var sig = MiBraids.ar(
            pitch: 45 + 0 + -12 + [0.0, 0.1] + d2 + 12,
            timbre: 0.5 + [0.0, 0.1],
            color: 0.75,
            model: 15,
            trig: t,
            resamp: 2,
            decim: 1 + [0, 1],
            bits: d,
            ws: 1
        ).sum * 1 * env;
        sig = sig;
        // sig = VadimFilter.ar(sig, 3000 * env + 50, 0, 3);
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
        ) * 0.25;
        // sig = Decimator.ar(sig, 100, 12) * 4;
        sig = VadimFilter.ar(sig, 100 + (2000 * env) + SinOsc.kr(0.1).range(0, 400), 0, 3) * 0.125!2;
        // sig = VadimFilter.ar(sig, 2000, 0, 1);
    }.play(fadeTime: 0.05);
});
)