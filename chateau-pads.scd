~toNote.(28);

// Shaky, stressed-out pad

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    v.free;
    v = {
        var t = Impulse.kr(~nT.tempo * 0.25);
        var d = Demand.kr(t, 0, Dseq([
            7, 8, 9, 8
        ].stutter(2), inf));
        var d2 = Demand.kr(t, 0, Dseq([0,-5].stutter(16), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, 0]), t).lag(0.95);
        var lfo = SinOsc.kr(~nT.tempo * 2).unipolar;
        var sig = MiBraids.ar(
            28 + [d + 12] + 12, timbre: 0.125 * e + [0, 0.1], color: 1 - e,
            model: 22,
            resamp: 2, decim: 16, bits: 4, ws: 0
        );
        // sig = sig[0] + sig[1];
        sig = VadimFilter.ar(sig, 2000 * lfo + 500, 0, 3);
        sig = sig * 0.05;
        sig;
    }.play;
});
)

// Noise from what used to be a pad

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    v.free;
    v = {
        var t = Impulse.kr(~nT.tempo * 0.25);
        var d = Demand.kr(t, 0, Dseq([
            7, 8, 9, 8
        ].stutter(2), inf));
        var d2 = Demand.kr(t, 0, Dseq([0,-5].stutter(16), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, 0]), t).lag(0.95);
        var lfo = SinOsc.kr(~nT.tempo * 2).unipolar;
        var sig = MiBraids.ar(
            28 + [d + 12] + 24, timbre: 1 * d/10 + [0, 0], color: 1 - 0,
            model: 43,
            resamp: 2, decim: 16, bits: 4, ws: 1
        );
        // sig = sig[0] + sig[1];
        sig = VadimFilter.ar(sig, 1000 * lfo + 3500, 0, 1);
        sig = sig * 0.05;
        sig;
    }.play;
});
)

{SinOsc.kr(3).unipolar}.plot(2);


~nT.tempo



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    v.free;
    v = {
        var t = Impulse.kr(~nT.tempo * 0.25);
        var d = Demand.kr(t, 0, Dseq([
            7, 8, 9, 8
        ].stutter(2), inf));
        var d2 = Demand.kr(t, 0, Dseq([0,-5].stutter(16), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, 0]), t).lag(0.95);
        var lfo = SinOsc.kr(~nT.tempo * 2).unipolar;
        var sig = MiBraids.ar(
            12 + [d + 12] + 12, timbre: 1 * d/10 + [0, 0], color: 1 - 0,
            model: 43,
            resamp: 2, decim: 16, bits: 4, ws: 1
        );
        // sig = sig[0] + sig[1];
        sig = VadimFilter.ar(sig, 1000 * lfo + 3500, 0, 1);
        sig = sig * 0.05;
        sig;
    }.play;
});
)