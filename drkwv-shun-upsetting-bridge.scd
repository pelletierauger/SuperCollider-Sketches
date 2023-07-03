
(
x.free;
x = {
    var t = Impulse.kr(4 * -5.midiratio);
    var t2 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0] ++
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0], inf));
    var t3 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0], inf));
    var t4 = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0], inf));
    var melo = Demand.kr(t, 0,
        Dseq([0, 0, 0, 0].stutter(1), inf) +
        // Dseq([0, -5, 0, 3].stutter(16), inf)
        Dseq([3, 3, -1, -1,  1,  1, -4, -4,
              4, 4,  3,  3, -1, -1,  2,  2].stutter(8), inf)
    );
    var melo2 = Demand.kr(t2, 0,
        Dseq(
             [10, 11, 16, 15,
              11, 10, 11, 2].stutter(1), inf)
    );
    var melo3 = Demand.kr(t2, 0,
        Dseq([-6, 2, -5, -1,
            -5, -6, 2, 5].stutter(1), inf)
    );
        var melo4 = Demand.kr(t2, 0,
        Dseq([5, 6, 7, 8,
            6, 5, 6, 8].stutter(1), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf) +
        Dseq([0, 0].stutter(16), inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1] * 7.midiratio, [0, -12]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[2, 7] * 7.midiratio, [0, -12]), gate: t2);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") - 5 + melo + [0,12],
        timbre: 0.5 * e * 0.1 + [0.1,0.2],
        color: 0.5 + col + (fil*0.1*e),
        model: [1,14]
    ).sum;
    var haut = (MiBraids.ar(
        pitch: ~toMidi.("D6") - 5 + [melo2, melo3, melo4-12].lag(0.01),
        timbre: 0.5 * e2 * 1,
        color: 0.5 * e2,
        model: [14,14,4]
    ) * [1, 1, 4]).sum * e2 * 0.5;
    haut = [haut, DelayC.ar(haut, 0.5, 0.01)];
    haut = MiVerb.ar(haut * 0.25, drywet: 0.5);
    sig = ~v.(sig, 1000 * e + 100 + (fil * 500 * e));
    haut = MiWarps.ar(
        haut, haut, lev1: 0.5, lev2: 0.85,
        algo: 2, timb: 0.85, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    haut = ~v.(haut, 5000 * ~lfo.(4*1.5) + 4000);
    sig = sig * 0.125 ! 2 + (haut*2);
    sig * 1;
}.play;
)



(
x.free;
x = {
    var t = Impulse.kr(2 * -5.midiratio);
    var t2 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0] ++
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0], inf));
    var t3 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0], inf));
    var t4 = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0], inf));
    var melo = Demand.kr(t, 0,
        Dseq([0, 0, 0, 0].stutter(1), inf) +
        // Dseq([0, -5, 0, 3].stutter(16), inf)
        Dseq([3, 3, -1, -1,  1,  1, -4, -4,
              4, 4,  3,  3, -1, -1,  2,  2].stutter(8), inf)
    );
    var melo2 = Demand.kr(t2, 0,
        Dseq(
             [10, 11, 16, 15,
              11, 10, 11, 2].stutter(1), inf)
    );
    var melo3 = Demand.kr(t2, 0,
        Dseq([-6, 2, -5, -1,
            -5, -6, 2, 5].stutter(1), inf)
    );
        var melo4 = Demand.kr(t2, 0,
        Dseq([5, 6, 7, 8,
            6, 5, 6, 8].stutter(1), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf) +
        Dseq([0, 0].stutter(16), inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1] * 7.midiratio * 2, [0, -12]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[2, 7] * 7.midiratio * 2, [0, -12]), gate: t2);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") - 5 + melo + [0,12],
        timbre: 0.5 * e * 0.1 + [0.1,0.2],
        color: 0.5 + col + (fil*0.1*e),
        model: [1,14]
    ).sum;
    var haut = (MiBraids.ar(
        pitch: ~toMidi.("D6") - 5 + [melo2, melo3, melo4-12].lag(0.01),
        timbre: 0.5 * e2 * 1,
        color: 0.5 * e2,
        model: [14,14,4]
    ) * [1, 1, 4]).sum * e2 * 0.5;
    haut = [haut, DelayC.ar(haut, 0.5, 0.01)];
    haut = MiVerb.ar(haut * 0.25, drywet: 0.5);
    sig = ~v.(sig, 1000 * e + 100 + (fil * 500 * e));
    haut = MiWarps.ar(
        haut, haut, lev1: 0.5, lev2: 0.85,
        algo: 2, timb: 0.85, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    haut = ~v.(haut, 5000 * ~lfo.(4*1.5) + 4000);
    sig = sig * 0.125 ! 2 + (haut*2);
    sig * 1;
}.play;
)


(
x.free;
x = {
    var t = Impulse.kr(4 * -5.midiratio);
    var t2 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0] ++
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0], inf));
    var t3 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0], inf));
    var t4 = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0], inf));
    var melo = Demand.kr(t, 0,
        Dseq([0, 0, 0, 0].stutter(1), inf) +
        // Dseq([0, -5, 0, 3].stutter(16), inf)
        Dseq([3, 3, -1, -1, 1, 1, -4, -4,
            4, 4, 3, 3, -1, -1, 2, 2, 5, 5].stutter(8), inf)
    );
    var melo2 = Demand.kr(t2, 0,
        Dseq(
             [10, 11, 16, 15,
                11, 10, 11, 2, 5].stutter(1), inf)
    );
    var melo3 = Demand.kr(t2, 0,
        Dseq([-6, 2, -5, -1,
            -5, -6, 2, 5, -1].stutter(1), inf)
    );
        var melo4 = Demand.kr(t2, 0,
        Dseq([5, 6, 7, 8,
            6, 5, 6, 8, 8].stutter(1), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf) +
        Dseq([0, 0].stutter(16), inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1] * 7.midiratio, [0, -12]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[2, 7] * 7.midiratio, [0, -12]), gate: t2);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") - 5 + melo + [0,12],
        timbre: 0.5 * e * 0.1 + [0.1,0.2],
        color: 0.5 + col + (fil*0.1*e),
        model: [1,14]
    ).sum;
    var haut = (MiBraids.ar(
        pitch: ~toMidi.("D5") - 5 + [melo2, melo3, melo4-12].lag(0.01),
        timbre: 0.5 * e2 * 1,
        color: 0.5 * e2,
        model: [14,14,4]
    ) * [1, 1, 4]).sum * e2 * 0.5 * ~lfo.(4*2* -5.midiratio) * ~lfo.(4*4* -5.midiratio,0.5,1);
    var drums = (MiBraids.ar(
            pitch: ~toMidi.("D2") - 5 + [0,0],
            timbre: [0.75,1], color: [1,0.5], model: [34,36], trig: [t3,t4],
        resamp: [0, 2], decim: 32, bits: 2
        ) * [3,4] * 0.25).sum * Line.kr(0,1,1);
    drums = drums + CombC.ar(drums, 1, 1/4*1.5 * 7.midiratio, 2);
    // haut = ~v.(haut, 5000);
    haut = [haut, DelayC.ar(haut, 0.5, 0.01)];
    haut = MiVerb.ar(haut * 0.25, drywet: 0.5) * ~lfo.(4*1* -5.midiratio,0.5,1) * ~lfo.(4*2* -5.midiratio,0.5,1);
    // haut = haut + (~v.(haut, 1500, 0, 5)*4);
    // sig = sig + VAKorg35.ar(sig, 1000 * e + 10, 0.5, 1, 1);
    sig = ~v.(sig, 1000 * e + 100 + (fil * 500 * e));
/*                haut = MiWarps.ar(
        haut, haut, lev1: 0.5, lev2: 0.9,
        algo: 4, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    sig = sig * 0.25 ! 2 + haut;

    sig * 1;
}.play;
)