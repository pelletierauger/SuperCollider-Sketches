~nT.tempo = 1.6;

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
        pitch: 79 + [melo, melo2 - 24 - 12],
        timbre: 0.75*e.lag(0.01), color: 0.5, model: 14
    ).sum;
    sig = ~v.(sig, 4000 * e + 100);
    sig = MiVerb.ar(sig);
    sig = sig * 0.1 * 2 ! 2;
}.play(fadeTime: 0);
)


(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
     var melo2 = Demand.kr(t, 0, Dseq([0, -5, -2, -7].stutter(16), inf));
    var melo = Demand.kr(t, 0, Dseq([0, 2, 3, 7], inf)) + melo2;
    var e = EnvGen.kr(Env([0,1,0],[0.01, 1], [0, -4]), gate: t);
    var sig = MiBraids.ar(
        pitch: 79 + [melo, melo2 - 24 - 12, melo2 - 24 - 12 + 0.1],
        timbre: 0.75*e.lag(0.01), color: 0.85, model: 5
    );
    sig = [sig[0] + sig[1], sig[0] + sig[2]];
    sig = ~v.(sig, 2000 * e + 100);
    sig = ~v.(sig, 500, 0, 5);
    sig = MiVerb.ar(sig, time: 0.7, drywet: 0.5, damp: 0.1);
    sig = ~v.(sig, 1500, 0, 1);
    sig = sig * 0.1 * 2;
}.play(fadeTime: 0);
)




~nT.tempo = 1.6;
~nT.tempo = 1;
(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
     var melo2 = Demand.kr(t, 0, Dseq([0, -5, -2, -7].stutter(16*2), inf));
    var melo = Demand.kr(t, 0, Dseq([0, 2, 3, 7].stutter(2), inf) + Dseq([0, -12], inf)) + melo2;
    var drr = Demand.kr(t, 0, Dseq([34, 36], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.01, 0.5], [0, -4]), gate: t);
    var sig = MiBraids.ar(
        pitch: 79 + 0 + [melo, melo2 - 24 - 12, melo2 - 24 - 12 + 0.1],
        timbre: 0.75*e.lag(0.01), color: 0.285, model: 26
    );
    var drums = MiBraids.ar(
        pitch: 79 - 36 - 0,
        timbre: 0.75, color: 0.5, model: 34, trig: b
    );
    var bass = [sig[1], sig[2]];
    sig = [sig[0] + sig[1], sig[0] + sig[2]];
    sig = ~v.(sig, 2000 * e + 100);
    sig = ~v.(sig, 500, 0, 5);
    sig = MiVerb.ar(sig, time: 0.7, drywet: 0.5, damp: 0.1);
    // sig = ~v.(sig, 1500, 0, 1);
    // bass = bass + VAKorg35.ar(bass, 2000, 0, 1, 1);
    sig = sig * 0.5 + (bass*0.25) * 1 + (drums*2) * 0.1 * 2;
}.play(fadeTime: 0);
)



(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
    var d = t * Demand.kr(t, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    var melo2 = Demand.kr(t, 0, Dseq([0, -5, -2, -7].stutter(16*2), inf));
    var melo = Demand.kr(t, 0, Dseq([0, 2, 3, 7].stutter(2), inf) + Dseq([0, -12], inf)) + melo2;
    var drr = Demand.kr(t, 0, Dseq([34, 36], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.01, 0.5], [0, -4]), gate: t);
    var sig = MiBraids.ar(
        pitch: 79 + 0 + [melo, melo2 - 24 - 12, melo2 - 24 - 12 + 0.1],
        timbre: 0.75*e.lag(0.01), color: 0.285, model: 26
    );
    var bass = [sig[1], sig[2]];
    var drums = MiBraids.ar(
        pitch: 79 - 36 - 0,
        timbre: 0.5, color: 1, model: 34, trig: b
    );
    drums = drums + MiBraids.ar(
        pitch: 79,
        timbre: 0.25, color: 0.2, model: 36, trig: d, resamp: 0, decim: 12, bits: 5
    );
    drums = drums + (MiPlaits.ar(
        pitch: 79 + 24,    engine: 15,
        harm: m,      timbre: 0.5,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0
    )[1] * 0.4);
    sig = [sig[0] + sig[1], sig[0] + sig[2]];
    sig = ~v.(sig, 2000 * e + 100);
    sig = ~v.(sig, 500, 0, 5);
    sig = MiVerb.ar(sig, time: 0.7, drywet: 0.5, damp: 0.1);
    sig = sig + (bass*0.25) * 0.2 + (drums*0.125) * 0.1 * 2;
}.play(fadeTime: 0);
)


~nT.tempo = 1.6/4
~nT.tempo = 1.6
(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
    var d = t * Demand.kr(t, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    var melo2 = Demand.kr(t, 0, Dseq([0, -5, -2, -7].stutter(16*2), inf));
    var melo = Demand.kr(t, 0, Dseq([0, 2, 3, 7].stutter(2), inf) + Dseq([0, -12], inf)) + melo2;
    var drr = Demand.kr(t, 0, Dseq([34, 36], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var m3 = Demand.kr(b, 0, Dseq([0.2, 0.4, 0.6, 0.4], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.01, 0.5], [0, -4]), gate: t);
    var sig = MiBraids.ar(
        pitch: 79 + 0 + [melo, melo2 - 24 - 12, melo2 - 24 - 12 + 0.1],
        timbre: [0.75, 0.75*e.lag(0.01),0.75*e.lag(0.01)],
        color: 0.285, model: [37, 26, 26] - 12
    );
    var bass = [sig[1], sig[2]];
    var drums = MiBraids.ar(
        pitch: 79 - 36 - 0,
        timbre: 0.5, color: 1, model: 34, trig: b
    );
    drums = drums + MiBraids.ar(
        pitch: 79,
        timbre: 0.25, color: 0.2, model: 36, trig: d, resamp: 2, decim: 12, bits: 5
    );
    drums = drums + (MiPlaits.ar(
        pitch: 79 + 24,    engine: 15,
        harm: m,      timbre: 0.5,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0
    )[1] * 2);
    sig = [sig[0] + sig[1], sig[0] + sig[2]];
    sig = ~v.(sig, 2000 * e + 100);
    sig = ~v.(sig, 500, 0, 5);
    sig = MiVerb.ar(sig, time: 0.7, drywet: 0.5, damp: 0.1);
    sig = sig * 1 + (bass*0.25) * 0.2 + ~v.(drums*0.125,6000) * 0.4 * 2;
        sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 0.7,
        algo: 1, timb: m3, osc:0, freq: ~toFreq.("E0"), easteregg:0);
}.play(fadeTime: 0);
)


(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
    var d = t * Demand.kr(t, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    var melo2 = Demand.kr(t, 0, Dseq([0, -5, -2, -7].stutter(16*2), inf));
    var melo = Demand.kr(t, 0, Dseq([0, 2, 3, 7].stutter(2), inf) + Dseq([0, -12], inf)) + melo2;
    var drr = Demand.kr(t, 0, Dseq([34, 36], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var m3 = Demand.kr(b, 0, Dseq([0.2, 0.4, 0.6, 0.4], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.01, 0.5], [0, -4]), gate: t);
    var sig = MiBraids.ar(
        pitch: 79 + 0 + [melo, melo2 - 24 - 12, melo2 - 24 - 12 + 0.1],
        timbre: [0.75, 0.75*e.lag(0.01),0.75*e.lag(0.01)],
        color: 0.285, model: 3
    );
    var bass = [sig[1], sig[2]];
    var drums = MiBraids.ar(
        pitch: 79 - 36 - 0,
        timbre: 0.5, color: 1, model: 34, trig: b
    );
    drums = drums + MiBraids.ar(
        pitch: 79,
        timbre: 0.25, color: 0.2, model: 36, trig: d, resamp: 2, decim: 12, bits: 5
    );
    drums = drums + (MiPlaits.ar(
        pitch: 79 + 24 ,    engine: 15,
        harm: m,      timbre: 0.5,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0
    )[1] * 2);
    sig = [sig[0] + sig[1], sig[0] + sig[2]];
    sig = ~v.(sig, 2000 * e + 100);
    sig = ~v.(sig, 500, 0, 5);
    sig = MiVerb.ar(sig, time: 0.7, drywet: 0.35, damp: 0.1);
    sig = sig * 1.5 + (bass*0.125) * 0.2 * 0.4 * 2;
        sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 0.27,
        algo: 1, timb: m3*e, osc:0, freq: ~toFreq.("E0"), easteregg:0);
    sig = ~v.(sig, 2000);
}.play(fadeTime: 0);
)