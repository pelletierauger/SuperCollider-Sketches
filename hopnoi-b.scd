
~toNote.(27)
~toNote.(63)
(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~x3bbbbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3bbbbb = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 1.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var d2 = Demand.kr(t, 0, Dseq([0, 0, 0, 3].stutter(16), inf));
        var sig = MiBraids.ar(
            pitch: 63 + [0.0, 0.1] + d2 + 0,
            timbre: 0.65 + [0.0, 0.1],
            color: 0.35,
            model: 8,
            trig: t,
            resamp: 2,
            decim: 9 + [0, 4],
            bits: d,
            ws: 0.5
        ).sum * 1 * env;
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
        sig = VadimFilter.ar(sig, 100 + (1000 * env) + SinOsc.kr(0.1).range(0, 4000), 0, 1);
        Pan2.ar(sig * 0.5, Demand.kr(t, 0, Drand([-1.0, 1.0], inf)).lag(0.5));
    }.play(fadeTime: 0);
});
)