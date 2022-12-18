(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    ~x3b2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3b2 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 2], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 4, 4, 5, 3, 3, 3, 2].stutter(1) - 0, inf));
        var note = Demand.kr(t, 0, Dseq([0, 0, 0, 1, -1, -1, -1, -2].stutter(4), inf));
        var sig = MiBraids.ar(
            pitch: 27 + 24 + 0 + [0, 0.25] + -24 + note,
            timbre: 0.5 + [0.0, 0.1],
            color: 0.5,
            model: 5,
            trig: t,
            resamp: 2,
            decim: \decim.kr(22) + [0, 4],
            bits: 4,
            ws: 0.5
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
        ) * 0.75;
        sig = ~v.(sig, 100 + (4000 * env) + 7000) * 0.2;
        Pan2.ar(sig,
            Demand.kr(t, 0, Dseq([-0.5, 0.5].stutter(4), inf))
        )  * 0.75;
    }.play(fadeTime: 0);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    ~x3b2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3b2 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 0.5], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 4, 4, 5, 3, 3, 3, 2].stutter(1) - 0, inf));
        var note = Demand.kr(t, 0, Dseq([0, 0, 0, 1, -1, -1, -1, -2].stutter(4), inf));
        var sig = MiBraids.ar(
            pitch: 27 + 24 + 0 + [0, 0.25] + 12 + note,
            timbre: 0.95 + [0.0, 0.1],
            color: 0.95,
            model: 0,
            trig: t,
            resamp: 2,
            decim: \decim.kr(2) + [0, 4],
            bits: 2,
            ws: 0.5
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
        ) * 0.75;
        sig = ~v.(sig, 100 + (4000 * env) + 7000) * 0.2;
        Pan2.ar(sig,
            Demand.kr(t, 0, Dseq([-0.5, 0.5].stutter(4), inf))
        )  * 0.75;
    }.play(fadeTime: 0);
});
)