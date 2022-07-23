(
u.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
u = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!7), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 60 + -24,    engine: 9,
        harm: 1,           timbre: 1,          morph: 0,
        trigger: b,        level: level,
        // fm_mod: 1,         timb_mod: 1,        morph_mod: -0.5,
        decay: 0.8 - morph,       lpg_colour: 0.25
    )[0];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2;
    sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)

(
u.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
u = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!7), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 60 + 0,    engine: 10,
        harm: 0.8,           timbre: 1,          morph: 1,
        trigger: b,        level: level,
        fm_mod: 1,         timb_mod: 1,        morph_mod: -0.5,
        decay: 0.8 - morph,       lpg_colour: 0.5
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2;
    sig = VadimFilter.ar(sig, 50, 0, 5);
    sig = VadimFilter.ar(sig, 5230, 0, 1) * 4;
}.play(fadeTime: 0);
)