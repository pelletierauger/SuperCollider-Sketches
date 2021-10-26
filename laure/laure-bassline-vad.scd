(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq(
            [0, -3, -2, -5].wrapExtend(16) - 5 ++
            ([0, -3, -2, -5].wrapExtend(16).reverse - 12), inf));
        var sig = MiBraids.ar(
            pitch: 60 - 5 - 12 - 7 + 5 + note2 + [0, 0.01],
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = VadimFilter.ar(sig, 400 + (SinOsc.kr(0.1).unipolar * 400) * [1, 0.75], 0.25, 1);
        sig * 0.25 * 3 * [1, 3];
    }.play.register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq(
            [0, -3, -2, -5].wrapExtend(16) - 5 ++
            ([0, -3, -2, -5].wrapExtend(16).reverse - 12), inf));
        var sig = MiBraids.ar(
            pitch: 60 - 5 - 12 - 7 + 5 + 36 + note2 + [0, 0.01],
            timbre: 1,
            color: 0,
            model: 46,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 4400 + (SinOsc.kr(0.1).unipolar * 400) * [1, 0.75]);
        sig * 0.25 * 0.3 * [1, 3];
    }.play.register;
});
)