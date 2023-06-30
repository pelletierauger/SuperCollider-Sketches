(
x.free;
x = {
    var t = Impulse.kr(8);
    var melo = Demand.kr(t, 0,
        Dseq([0, 0, 0, 0].stutter(1), inf) +
        // Dseq([0, -5, 0, 3].stutter(16), inf)
        Dseq([0, 0, -5, -5, 0, 0, 3, -6].stutter(8), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf) +
        Dseq([0, 0].stutter(16), inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1], [0, -12]), gate: t);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") + melo + [0,12],
        timbre: 0.5 * e * 0.1 + [0.1,0.2],
        color: 0.5 + col + (fil*0.1*e),
        model: [1,14]
    ).sum;
    sig = sig + VAKorg35.ar(sig, 1000 * e + 10, 0.5, 1, 1);
    sig = ~v.(sig, 3000 * e + 100 + (fil * 1500 * e));
    // sig = AnalogTape.ar(sig, bias: 0.125, saturation: 0.1, drive: 0.5, oversample: 3, mode: 2);
    // sig = ~v.(sig, 2000);
    // sig = VASEM12.ar(sig, 3500, 0, transition: 0.125);
    // sig = sig + MiRings.ar(sig, pit: (~toMidi.("D2") + melo).lag(0.1), struct: 0, model:1);
    // sig = MiVerb.ar(sig * 0.1, time: 2, drywet: 0.5, damp: 0.9);
    sig * 0.05 ! 2;
}.play;
)

~toNote.(39)



(
x.free;
x = {
    var t = Impulse.kr(4);
    var t2 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 1, 0,
         0, 0, 0, 0, 0, 0, 1, 0] ++
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 1, 0,
         0, 0, 0, 0, 0, 0, 1, 0], inf));
    var melo = Demand.kr(t, 0,
        Dseq([0, 0, 0, 0].stutter(1), inf) +
        // Dseq([0, -5, 0, 3].stutter(16), inf)
        Dseq([0, 0, -5, -5, 0, 0, 3, -6].stutter(8), inf)
    );
    var melo2 = Demand.kr(t2, 0,
        Dseq([3, 2, 5, 3, 3, 1, -2, 3].stutter(1), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf) +
        Dseq([0, 0].stutter(16), inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1], [0, -12]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[2, 7], [0, -12]), gate: t2);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") + melo + [0,12],
        timbre: 0.5 * e * 0.1 + [0.1,0.2],
        color: 0.5 + col + (fil*0.1*e),
        model: [1,14]
    ).sum;
    var haut = MiBraids.ar(
        pitch: ~toMidi.("D5") + melo2.lag(0.05),
        timbre: 0.5 * e2 * 1,
        color: 0.5 * e2,
        model: 14
    ) * e2 * 4 * ~lfo.(4*1) * ~lfo.(4*2,0.5,1);
    haut = ~v.(haut, 2000);
    haut = MiVerb.ar(haut);
    sig = sig + VAKorg35.ar(sig, 1000 * e + 10, 0.5, 1, 1);
    sig = ~v.(sig, 1000 * e + 100 + (fil * 500 * e));
     sig = sig ! 2 + haut;
    sig * 0.05;
}.play;
)

~toNote.(39)


(
x.free;
x = {
    var t = Impulse.kr(4);
    var t2 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 1, 0,
         0, 0, 0, 0, 0, 0, 1, 0] ++
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 1, 0,
         0, 0, 0, 0, 0, 0, 1, 0], inf));
    var melo = Demand.kr(t, 0,
        Dseq([0, 0, 0, 0].stutter(1), inf) +
        // Dseq([0, -5, 0, 3].stutter(16), inf)
        Dseq([0, 0, -5, -5, 0, 0, 3, -6].stutter(8), inf)
    );
    var melo2 = Demand.kr(t2, 0,
        Dseq([3, 2, 5, 3, 3, 1, -2, 3].stutter(1), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf) +
        Dseq([0, 0].stutter(16), inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1], [0, -12]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[2, 7], [0, -12]), gate: t2);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") + melo + [0,12],
        timbre: 0.5 * e * 0.1 + [0.1,0.2],
        color: 0.5 + col + (fil*0.1*e),
        model: [1,14]
    ).sum;
    var haut = MiBraids.ar(
        pitch: ~toMidi.("D5") + melo2.lag(0.05),
        timbre: 0.5 * e2 * 1,
        color: 0.5 * e2,
        model: 9
    ) * e2 * 4 * ~lfo.(4*1) * ~lfo.(4*2,0.5,1);
    haut = ~v.(haut, 5000);
    haut = MiVerb.ar(haut);
    sig = sig + VAKorg35.ar(sig, 1000 * e + 10, 0.5, 1, 1);
    sig = ~v.(sig, 1000 * e + 100 + (fil * 500 * e));
     sig = sig ! 2 + haut;
    sig * 0.05;
}.play;
)


(
x.free;
x = {
    var t = Impulse.kr(4);
    var t2 = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 1, 0,
         0, 0, 0, 0, 0, 0, 1, 0] ++
        [1, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         1, 0, 0, 0, 0, 0, 1, 0,
         0, 0, 0, 0, 0, 0, 1, 0], inf));
    var melo = Demand.kr(t, 0,
        Dseq([0, 0, 0, 0].stutter(1), inf) +
        // Dseq([0, -5, 0, 3].stutter(16), inf)
        Dseq([0, 0, -5, -5, 0, 0, 3, -6].stutter(8), inf)
    );
    var melo2 = Demand.kr(t2, 0,
        Dseq([3, 2, 5, 3, 3, 1, -2, 3].stutter(1), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf) +
        Dseq([0, 0].stutter(16), inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1], [0, -12]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[2, 7], [0, -12]), gate: t2);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") + melo + [0,12],
        timbre: 0.5 * e * 0.1 + [0.1,0.2],
        color: 0.5 + col + (fil*0.1*e),
        model: [1,14]
    ).sum;
    var haut = MiBraids.ar(
        pitch: ~toMidi.("D5") + melo2.lag(0.05),
        timbre: 0.5 * e2 * 1,
        color: 0.5 * e2,
        model: 14
    ) * e2 * 4 * ~lfo.(4*1) * ~lfo.(4*2,0.5,1);
    haut = haut + CombC.ar(haut, 1, 1/8, 2);
    haut = ~v.(haut, 5000);
    haut = MiVerb.ar(haut * 0.25, drywet: 1) * ~lfo.(4*1,0.5,1) * ~lfo.(4*2,0.5,1);
        haut = ~v.(haut, 5000);
    sig = sig + VAKorg35.ar(sig, 1000 * e + 10, 0.5, 1, 1);
    sig = ~v.(sig, 1000 * e + 100 + (fil * 500 * e));
     sig = sig * 0.5 ! 2 + haut;
    sig * 1;
}.play;
)