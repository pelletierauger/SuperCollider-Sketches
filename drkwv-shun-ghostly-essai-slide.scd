
(
x.free;
x = {
    var t = Impulse.kr(4 * -5.midiratio);
    var t2 = t * Demand.kr(t, 0, Dseq((1!1) ++ (0!15), inf));
    var melo = Demand.kr(t, 0,
        Dseq([3,  3, -1, -1,  1,  1, -4, -4,
              4,  4,  3,  3, -1, -1,  2,  2].stutter(8), inf)
    );
    var melo2 = Demand.kr(t2, 0,
        Dseq([10, 11, 16, 15,
              11, 10, 11, 2], inf)
    );
    var melo3 = Demand.kr(t2, 0,
        Dseq([-6,  2, -5, -1,
              -5, -6,  2,  5], inf)
    );
    var melo4 = Demand.kr(t2, 0,
        Dseq([5, 6, 7, 8,
            6, 5, 6, 8].stutter(1), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf)
    );
    var dec = Demand.kr(t2, 0,
        Dseq([7,  7, 7, 7,
             21, 7, 7, 7], inf)
    );
    var lagTime = Demand.kr(t2, 0,
        Dseq([0.01,  0.01, 0.01, 0.01,
              0.01,     7, 0.01, 0.01], inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1] * 7.midiratio, [0, -12]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[2, dec] * 7.midiratio, [0, -12]), gate: t2);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") - 5 + melo + [0, 12],
        timbre: 0.5 * e * 0.1 + [0.1, 0.2],
        color: 0.5 + col + (fil * 0.1 *e),
        model: [1, 14]
    ).sum;
    var haut = (MiBraids.ar(
        pitch: ~toMidi.("D5") - 5 + [melo2, melo3, melo4 - 12].lag(lagTime),
        timbre: 0.5 * e2 * 1,
        color: 0.5 * e2,
        model: [4]
    ) * [1, 1, 4]).sum * e2 * 0.5;
    haut = [haut, DelayC.ar(haut, 0.5, 0.01)];
    haut = MiVerb.ar(haut * 0.25, drywet: 0.5);
    haut = MiWarps.ar(
        haut, haut, lev1: 0.5, lev2: 0.5,
        algo: 2, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0);
    haut = ~v.(haut, 5000 * ~lfo.(4*1.5) + 4000);
    sig = ~v.(sig, 1000 * e + 100 + (fil * 500 * e));
    sig = sig * 0.125 ! 2 + (haut*2);
    sig * 0.5;
}.play;
)
