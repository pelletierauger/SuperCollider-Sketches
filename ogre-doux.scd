~nT.tempo = 1.6;


(
~hearCB.free;
~hearCB = {
    var sig = K2A.ar(In.kr(~cb, 2)) * 1;
    sig = sig[0] + sig[1] * 1!2;
    sig = VadimFilter.ar(sig, 2000, 0, 5) * 4;
    MiRings.ar(sig, pit: 40, struct: 1, damp: 0.7, pos: 0.05, model: 2);
}.play;
)


(
n.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
n = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40,    engine: 10,
        harm: 1,                timbre: 0.5,             morph: 0,
        trigger: b,             level: level,
        fm_mod: 1,              timb_mod: 1,           morph_mod: -0.5,
        decay: dec,            lpg_colour: levv.lag(0.4) * 0.5
   )[0];
     sig = [sig, DelayC.ar(sig, 0.5, 0.01)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2 * 2;
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
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.5, 0, 0, 0, 0.75].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.8, 0.6, 0.6, 0.6], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0.0);
    var sig = MiPlaits.ar(
        pitch: 12 + 24,    engine: 2,
        harm: 0,                timbre: 0.5,             morph: 0,
        trigger: b,             level: level,
        fm_mod: 0,              timb_mod: 0.25,           morph_mod: -0.5,
        decay: dec,            lpg_colour: levv.lag(0.4) * 0.5
    )[1];
    // sig = VadimFilter.ar(sig, 1000, 0, 1);
    sig = [sig, DelayC.ar(sig, 0.5, 0.01)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2 * 1;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)