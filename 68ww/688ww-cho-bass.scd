(
~t.sched(~t.timeToNextBeat(quant: 6) + (~t.beatDur * 2.pow(-4)), {
    ~synthLine3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine3 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 1) * trigGate;
        var bl = t * Demand.kr(t, 0, Dseq(
            [1, 0, 0, 1, 0, 0], inf)
        );
        var acc = Demand.kr(bl, 0, Dseq([0.025, 0.05], inf));
        var env = EnvGen.kr(
            Env([0, 1, 0], [0.01, 7], [2, -4, 'lin']
        ), bl);
        var note = Demand.kr(bl, 0,
            Dseq([3, 3, 0, 1, -4, -4, -7, -7].stutter(2), inf)
        );
        var sig = MiBraids.ar(
            pitch: 24 + 12 + note,
            timbre: acc,
            color: acc,
            model: 1,
            resamp: 0,
            decim: 22,
            bits: 3,
            ws: 0
        ) * env;
        sig = VadimFilter.ar(sig, 100 + (2000 * env), 0, 1);
        sig * 0.5 ! 2;
    }.play(fadeTime: 0.0).register;
});

~t.sched(~t.timeToNextBeat(quant: 6) - (~t.beatDur * 1.5 * 0), {
    z.set(\fadeTime, 0.01, \gate, 0);
    // y.set(\gate, 0, \fadeTime, 0.1);
    z = {
        | freeze = 0 |
        var t = Impulse.kr(~t.tempo);
        var bl = t * Demand.kr(t, 0, Dseq((1!1) ++ ( 0 ! (6 * 8 - 1)), inf));
        var sig = XPlayBuf.ar(2, d, 0.midiratio, bl, startPos: 0, loop: 0, fadeTime: 0.01);
        // var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        // var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        // sig = sig * 0.7 + VadimFilter.ar(sig2, 500, 0, 0) * 2;

        // sig = CombC.ar(sig, 1, 0.05, 3);
        sig = VadimFilter.ar(sig, 1000 + SinOsc.kr(~t.tempo * 2).range(0, 9000), 0, 1);
        sig = sig * 0.5 + MiRings.ar(sig, pit: 48 - 2, bright: 0.95, damp: 0.4, model: 2) * 0.5;
        // sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0, type: 0) * 0.5;
        // sig = VadimFilter.ar(sig, 400, 0, 5) * 2;
        sig * 2;
    }.play(fadeTime: 0);
});
)




(
~t.sched(~t.timeToNextBeat(quant: 6) - (~t.beatDur * 2.pow(-4)), {
    ~synthLine3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine3 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 1) * trigGate;
        var bl = t * Demand.kr(t, 0, Dseq(
            [1, 0, 0, 1, 0, 0], inf)
        );
        var acc = Demand.kr(bl, 0, Dseq([0.025, 0.05], inf));
        var env = EnvGen.kr(
            Env([0, 1, 0], [0.01, 7], [2, -8, 'lin']
        ), bl);
        var note = Demand.kr(bl, 0,
            Dseq([-4, -4, 0, 1].stutter(2), inf)
        );
        var sig = MiBraids.ar(
            pitch: 24 + 12 + note,
            timbre: acc,
            color: acc,
            model: 1,
            resamp: 0,
            decim: 22,
            bits: 3,
            ws: 0
        ) * env;
        sig = VadimFilter.ar(sig, 100 + (4000 * env), 0, 1);
        sig * 0.75 ! 2;
    }.play(fadeTime: 0.0).register;
});

)