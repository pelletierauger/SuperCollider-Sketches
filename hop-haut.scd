(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    ~x3bbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3bbb = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var d2 = Demand.kr(t, 0, Dseq([0, 3, 2, 7].stutter(16), inf));
        var sig = MiBraids.ar(
            pitch: 39 + 24 + [0.0, 0.1] + d2,
            timbre: 0.65 + [0.0, 0.1],
            color: 0.35,
            model: 23,
            trig: t,
            resamp: 2,
            decim: 9 + [0, 4],
            bits: d,
            ws: 0.5
        ).sum * 1 * env;
        sig = sig * Line.ar(0, 1, 60);
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
        VadimFilter.ar(sig, 1000 + (1000 * env) + SinOsc.kr(0.1).range(0, 400), 0, 1) * 0.25 ! 2;
    }.play(fadeTime: 0.05);
});
)