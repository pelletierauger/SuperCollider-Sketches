(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~x3b2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3b2 = {
        | trigGate = 1 |
        var td = Impulse.kr(~nT.tempo * 2) * trigGate;
        var t = Demand.kr(td, 0, Dseq([1, 0, 0].wrapExtend(15) ++ (0!17), inf)) * td;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 1], [2, -8, 'lin']), td);
        var d = Demand.kr(td, 0, Dseq([4, 4, 4, 5, 3, 3, 3, 2].stutter(1) - 0, inf));
        var dd = Demand.kr(td, 0, Dseq([0, 0, 0, 1, -1, -1, -1, -2], inf));
        var sig = MiBraids.ar(
            pitch: 27 + 24 + 0 + [0, 0.5] + dd,
            timbre: 0.25 + [0.0, 0.1],
            color: 0.25,
            model: 0,
            trig: td,
            resamp: 2,
            decim: \decim.kr(2) + [0, 4],
            bits: 2,
            ws: 0
        ).sum * 4 * env;
/*        sig = AnalogVintageDistortion.ar(
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
        ) * 0.75;*/
        VadimFilter.ar(sig, 100 + (4000 * env) + 100, 0, 3) * 0.025 * 2 ! 2;
    }.play(fadeTime: 0);
});
)