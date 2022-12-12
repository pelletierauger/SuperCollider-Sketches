(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    ~lead.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~lead = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 1) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 0.5], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var d2 = Demand.kr(t, 0, Dseq(
            [
                13, 13, 11, 9,
                13, 13, 11, 9,
                12, 12, 11, 9,
                13, 13, 11, 9
            ]
            .stutter(2), inf));
        var sig = MiBraids.ar(
            pitch: 45 + 0 + -12 + [0.0, 0.1] + d2 + 12 + 12,
            timbre: 0.95 + [0.0, 0.1],
            color: 0.5,
            model: 41,
            trig: t,
            resamp: 0,
            decim: 21 + [0, 1],
            bits: d,
            ws: 1
        ) * 1 * env;
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
        sig = VadimFilter.ar(sig, 100 + (2000 * env) + SinOsc.kr(0.1).range(0, 400), 0, 5) * 0.25;
        // sig = VadimFilter.ar(sig, 2000, 0, 1);
    }.play(fadeTime: 0.05);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~lead.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~lead = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.75] * 1.5, [-8, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var d2 = Demand.kr(t, 0, Dseq(
            [
                13, 13, 11, 9,
                13, 13, 11, 9,
                12, 12, 11, 9,
                13, 13, 11, 9
            ]
            .stutter(4), inf));
        var sig = MiBraids.ar(
            pitch: 45 + 0 + -12 + [0.0, 0.1] + d2 + 24,
            timbre: 0.5 + [0.0, 0.1],
            color: 1,
            model: 2,
            trig: t,
            resamp: 2,
            decim: 1 + [0, 1],
            bits: d,
            ws: 1
        ) * 1;
        sig = sig;
        sig = VadimFilter.ar(sig, 3000 * env + 50, 0, 3);
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0.51, lowgain: 0.3, highgain: 0.5,
            shelvingfreq: 2200, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0.51, lowgain: 0.3, highgain: 0.5,
            shelvingfreq: 2200, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0.51, lowgain: 0.3, highgain: 0.5,
            shelvingfreq: 2200, oversample: 0
        ) * 0.25;
        // sig = Decimator.ar(sig, 100, 12) * 4;
        sig = VadimFilter.ar(sig, (1000 * env) + SinOsc.kr(0.1).range(0, 400) + 2000, 0, 5) * 0.25;
        // sig = VadimFilter.ar(sig, 2000, 0, 1);
        sig = sig * env;
    }.play(fadeTime: 0.0);
});
)