(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
     var melo2 = Demand.kr(t, 0, Dseq([0, -5, -2, -7].stutter(16), inf));
    var melo = Demand.kr(t, 0, Dseq([0, 2, 3, 7], inf)) + melo2;
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.01, 1], [0, -8]), gate: t);
    var sig = MiBraids.ar(
        pitch: 79 + melo, timbre: 0.75*e.lag(0.01), color: 0.5, model: 14
    );
    sig = sig + MiBraids.ar(
        pitch: 79 + melo2 - 24 - 12, timbre: 0.75*e.lag(0.01), color: 0.5, model: 14
    );
    sig = ~v.(sig, 4000 * e + 100);
    sig = MiVerb.ar(sig);
    sig = sig * 0.1 * 2 ! 2;
}.play(fadeTime: 0);
)

(
h.free;
h = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 40 + 7 + 24 + 24 + 12,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0.95,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0.9
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = sig * 0.1 * 2;
}.play(fadeTime: 0);
)


(
n.free;
n = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([0, 1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + 7,    engine: 14,
        harm: 0.8,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0.95,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0.9
    )[0];
    // sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    // sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = sig * 0.4 * 2 ! 2;
}.play(fadeTime: 0);
)