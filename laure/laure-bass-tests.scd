(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    ~synthLine.free;
    ~synthLine = {
        var t = Impulse.kr(~nT.tempo * 0.5);
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq([0, 0, 0, -2], inf));
        var sig = MiBraids.ar(
            pitch: 60 - 5 - 12 - 7 + note2,
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 400 + (SinOsc.kr(0.1).unipolar * 400) * [1, 0.75]);
        sig * 0.25 * 1!2 * 8;
    }.play;
});
)