~nT.tempo = 1.2;
~nT.tempo;
(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b  = t * Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    var b2 = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0], inf));
    var b3 = t * Demand.kr(t, 0, Dseq([1, 1, 1, 1, 0, 1, 1, 1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var melo2 = Demand.kr(b, 0, Dseq([0, -2].stutter(20), inf));
    var melo = Demand.kr(b, 0, Dseq([0, 3, 2, 8, 7].mirror2, inf) + Dseq([0,12].stutter(5), inf)) + melo2;
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.01, 1], [0, -8]), gate: b);
    var e2 = EnvGen.kr(Env([0,1,0],[0.01, 1], [0, -8]), gate: b3);
    var sig = MiBraids.ar(
        pitch: 79 + [melo + -12, melo2 - 24 - 24],
        timbre: 0.75*e.lag(0.01), color: [0.25,0.2], model: [4, 14]
    );
    var bass = sig[1];
    var drums = MiBraids.ar(
        pitch: 79 - 36 + melo2,
        timbre: 0.75, color: 0.25, model: 34, trig: b2
    ) * 4;
    bass = ~v.(bass, 2000 * [e2] + 100);
    bass = [bass, DelayC.ar(bass, 0.5, 0.01)];
    sig = ~v.(sig, 9000 * [e*e,e2] + 10);
    sig = ~v.(sig, 1000, 0, 5) * 4;
    sig = MiVerb.ar(sig[0], time: 0.7, drywet: 0.5) + (sig[0]!2);
    sig = sig * 1 + bass + drums * 0.1 * 2 * dd.lag(0.05);
}.play(fadeTime: 0);
)