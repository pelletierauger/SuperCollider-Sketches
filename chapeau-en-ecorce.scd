~nT = TempoClock.new(1.39).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    x.free;
    x = {
        var tt = ~nT.tempo;
        var t = Impulse.ar(tt * 0.125);
        var dem = Demand.ar(t, 0, Dseq([1, 1], inf));
        var dem2 = Demand.ar(t, 0, Dseq([-7, -10], inf));
        var dem3 = Demand.ar(t, 0, Dseq([2, 3], inf));
        var env = EnvGen.ar(Env([0.5, 0.7, 0.5], [0.02, ~nT.beatDur * 4 - 0.2], [2, 'lin', 'lin']), t);
        var sig = MiBraids.ar(
            pitch: 45 + 12 + [dem2 - 12, 0, dem3],
            timbre: 0.5,
            color: dem,
            model: [12, 2, 1] + 0,
            trig: 0,
            resamp: 0,
            decim: 16,
            bits: 4,
            ws: 1,
            mul: [2, 0.5, 1] * SinOsc.ar([1, 2, 3] * 0.1).range(1, 0.5)
        );
        sig = [sig[1] + sig[0], sig[2] + sig[0]];
        sig = LPF.ar(sig, 4000);
        sig * 0.2;
    }.play(fadeTime: 0.01);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    x.free;
    x = {
        var tt = ~nT.tempo;
        var t = Impulse.ar(tt * 0.125);
        var dem = Demand.ar(t, 0, Dseq([1, 1], inf));
        var dem2 = Demand.ar(t, 0, Dseq([-7, -10], inf));
        var dem3 = Demand.ar(t, 0, Dseq([2, 3], inf));
        var env = EnvGen.ar(Env([0.5, 0.7, 0.5], [0.02, ~nT.beatDur * 4 - 0.2], [2, 'lin', 'lin']), t);
        var sig = MiBraids.ar(
            pitch: 45 + 12 + [dem2 - 12, 0, dem3].wrapExtend(6),
            timbre: 0.5,
            color: dem,
            model: [12, 2, 1].wrapExtend(6) + 0,
            trig: 0,
            resamp: [0, 2].stutter(3),
            decim: 32,
            bits: 6,
            ws: 1,
            mul: [2, 0.5, 1].wrapExtend(6) * SinOsc.ar([1, 2, 3].wrapExtend(6) * 0.1).range(1, 0.5)
        );
        sig = [sig[1] + sig[0], sig[2] + sig[0]] + ([sig[4] + sig[3], sig[5] + sig[3]] * 0.95);
        sig = LPF.ar(sig, 4000);
        sig * 0.2;
    }.play(fadeTime: 0.01);
});
)

