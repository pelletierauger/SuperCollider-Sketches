(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3b = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 1], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 4, 4, 5, 3, 3, 3, 2].stutter(1) - 0, inf));
        var note = Demand.kr(t, 0, Dseq([0, 0, 0, 1, -1, -1, -1, -2], inf));
        var sig = MiBraids.ar(
            pitch: 27 + 24 + 0 + [0, 0.25] + note,
            timbre: 0.5 + [0.0, 0.1],
            color: 0.5,
            model: 0,
            trig: t,
            resamp: 2,
            decim: \decim.kr(2) + [0, 4],
            bits: 4,
            ws: 0.5
        )[0] * 4 * env * dd.lag(0.05);
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
        ) * 0.75 * env;
        ~v.(sig, 100 + (4000 * env) + 100 + ~x.(0,7000)) * 0.1 ! 2 * dd.lag(0.05);
    }.play(fadeTime: 0);
});
)

~x = {|min = 0, max = 1| MouseX.kr(min, max)};
