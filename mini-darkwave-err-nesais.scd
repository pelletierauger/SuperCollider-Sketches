(
v.set(\trigGate, 0, \gate, 0, \fadeTime, 1);
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
    var d = t * Demand.kr(t, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    var melo2 = Demand.kr(t, 0, Dseq([0, -5, -2, -7].stutter(16*2), inf));
    var melo = Demand.kr(t, 0, Dseq([0, 7, 8, 7].stutter(2), inf) + Dseq([0, 12], inf)) + melo2;
    var drr = Demand.kr(t, 0, Dseq([34, 36], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.005, 0.5], [8, -16]), gate: t);
    var sig = MiBraids.ar(
        pitch: 79 + 0 + [melo, melo2 - 24 + -24, melo2 - 24 + -24 + 0.1],
        timbre: [0.75*e.lag(0.01),0.25,0.25], color: [0.85,0.285,0.285], model: [ 26, 14, 14 ]
    );
    var bass = ~v.([sig[1], sig[2]], 3000) * 4;
    var drums = MiBraids.ar(
        pitch: 79 - 36 - 0,
        timbre: 0.5, color: 1, model: 34, trig: b
    );
    var hats;
    drums = drums + MiBraids.ar(
        pitch: 79,
        timbre: 0.25, color: 0.2, model: 36, trig: d, resamp: 0, decim: 12, bits: 5
    );
    hats = (MiPlaits.ar(
        pitch: 79 + 0,    engine: 15,
        harm: m,      timbre: 1,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0
    )[1] * 0.4 * 16);
    hats = [hats, DelayC.ar(hats, 0.5, 0.02)];
    // drums = drums + hats;
    // sig = [sig[0] + sig[1], sig[0] + sig[2]];
    sig = sig[0] ! 2;
    sig = ~v.(sig, 9000 * e + 100);
    // sig = ~v.(sig, 500, 0, 5);
    sig = MiVerb.ar(sig, time: 0.7, drywet: 0.125, damp: 0.1);
    sig = sig * 0.5 + (bass*0) * 0.2 + (drums*0.125) * 1 * 2;
    sig = ~v.(sig, 4500, 0, 1) + (hats*0.05) * dd.lag(0.05);
}.play(fadeTime: 0);
)


(
v.set(\trigGate, 0, \gate, 0, \fadeTime, 1);
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
    var d = t * Demand.kr(t, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    var melo2 = Demand.kr(t, 0, Dseq([0, -5, -2, -7].stutter(16*2), inf));
    var melo = Demand.kr(t, 0, Dseq([0, 7, 8, 7].stutter(2), inf) + Dseq([0, 12], inf)) + melo2;
    var drr = Demand.kr(t, 0, Dseq([34, 36], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var m3 = Demand.kr(b, 0, Dseq([0.2, 0.4, 0.6, 0.4], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.005, 0.5], [8, -16]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[0.01, 0.5], [0, -4]), gate: t);
    var sig = MiBraids.ar(
        pitch: 79 + 0 + [melo, melo2 - 24 - 12, melo2 - 24 - 12 + 0.1],
        timbre: 0.75*[e,e2,e2].lag(0.01), color: [0.25,0.285,0.285], model: [ 14, 26, 26 ]
    );
    var bass = ~v.([sig[1], sig[2]],3000) * 4;
    var drums = MiBraids.ar(
        pitch: 79 - 36 - 0,
        timbre: 0.5, color: 1, model: 34, trig: b
    );
    var hats;
    drums = drums + MiBraids.ar(
        pitch: 79,
        timbre: 0.25, color: 0.2, model: 36, trig: d, resamp: 2, decim: 32, bits: 5
    );
    hats = (MiPlaits.ar(
        pitch: 79 + 0,    engine: 15,
        harm: m,      timbre: 1,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0
    )[1] * 0.4 * 16);
    hats = [hats, DelayC.ar(hats, 0.5, 0.02)];
    // drums = drums + hats;
    // sig = [sig[0] + sig[1], sig[0] + sig[2]];
    sig = sig[0] ! 2;
    sig = ~v.(sig, 9000 * e + 100);
    // sig = ~v.(sig, 500, 0, 5);
    sig = MiVerb.ar(sig, time: 0.7, drywet: 0.125, damp: 0.1);
    sig = sig * 1 + (bass*0.1) * 0.2 + (drums*0.125) * 1 * 2;
    sig = ~v.(sig, 4500, 0, 1) + (hats*0.05) * 0.2 * dd.lag(0.05);
            sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 0.5,
        algo: 1, timb: m3, osc:0, freq: ~toFreq.("E0"), easteregg:0);
}.play(fadeTime: 0);
)