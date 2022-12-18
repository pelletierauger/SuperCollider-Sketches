(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~x3b2x.set(\trigGate, 0, \gate, 0, \fadeTime, 30.1);
    ~x3b2x = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 0.5], [2, -8, 'lin']), t);
        var env2 = EnvGen.kr(Env([0, 1, 0], [0.001, 0.25 * 1], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 4, 4, 5, 3, 3, 3, 2].stutter(1) - 0, inf));
        var note = Demand.kr(t, 0, Dseq(
            [0, 0, 0, 1, -1, -1, -1, -2].stutter(4), inf));
            // [0, 0, 0, 1, 3, 3, 3, 5, 0, 0, 0, 1, -1, -1, -1, -2].stutter(4), inf));

        var sig = MiBraids.ar(
            pitch: 27 + 24 + 0 + [0, 0.5] + 12 + note,
            timbre: 0.5 + [0.0, 0.1],
            color: 0.5 + (note * 0.2),
            model: 28,
            trig: t,
            resamp: 2,
            decim: \decim.kr(2) + [0, 4],
            bits: 1,
            ws: 0
        ).sum;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.5;
/*        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.75;*/
        sig = ~v.(sig, 100 + (4000 * env) + 3000, 0, 5) * 1;
        // sig = ~v.(sig, 10000) * 4;
/*        sig = Pan2.ar(sig,
            Demand.kr(t, 0, Dseq([-0.5, 0.5].stutter(1).lag(1), inf))
        ) * 8;*/
        MiRings.ar(sig!2,
            pit: 27+12+note, struct: 0.25, bright: 0.25,
            damp: 0.2, pos: 0.25, model: 2) * 16 * 8;
    }.play(fadeTime: 0.05);
});
)