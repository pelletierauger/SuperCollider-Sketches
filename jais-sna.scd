(
~sna.free;
~sna = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd ;
    var d = Demand.kr(t, 0, Dwrand([1, 0], [0.1, 0.9], inf));
    var b = t * Demand.kr(t, 0, Dseq([0, 0, 1, d], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 40 + 7 + 36,    engine: 15,
        harm: m,      timbre: 0,     morph: m,
        trigger: b,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0.5,
        decay: 0.75,   lpg_colour: 0.9
    )[0];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = sig * 0.1 * 4;
}.play(fadeTime: 0);
)



(
~sna2.free;
~sna2 = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd ;
    var b = t * Demand.kr(t, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 40 + 7 + 0,    engine: 14,
        harm: m,      timbre: 0.125,     morph: m,
        trigger: b,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0.95,     morph_mod: 0.5,
        decay: 0.5,   lpg_colour: 0.9
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = sig * 0.1 * 8;
}.play(fadeTime: 0);
)
