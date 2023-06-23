s.mute
s.unmute

(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = ~div16.(tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0].wrapExtend(8*7) ++
        [1, 0, 0, 0, 1, 0, 1, 0]
        , inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4].wrapExtend(4*2) ++ [0.5, 0.5], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + 7,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
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
    sig = sig * 0.1 * 2 * 2;
}.play(fadeTime: 0);
)


(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = ~div16.(tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0].wrapExtend(8*7) ++
        [1, 0, 0, 1, 0, 1, 0, 0]
        , inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4].wrapExtend(4*2) ++ [0.5, 0.5], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + 7,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
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
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = ~div16.(tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 1, 0, 1, 0, 0]
        , inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4].wrapExtend(7) ++ [0.5, 0.5], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + 7,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
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
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = ~div16.(tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0].wrapExtend(8*7) ++
        [1, 0, 0, 1, 0, 1, 0, 0]
        , inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4].wrapExtend(4*2) ++ [0.5, 0.5], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + 7,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
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
    sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 3, timb: 0.8)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 3, timb: 0.8)[0]);
    sig = sig * 1 * 2;
}.play(fadeTime: 0);
)


(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = ~div16.(tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0].wrapExtend(8*6) ++
        [1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 0, 1, 0, 0, 0]
        , inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4].wrapExtend(6) ++ [0.35, 0.55, 0.4, 0.55], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + 7,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
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
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.275, 0.5, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.275, 0.5, algo: 4, timb: 0.8)[0]);
    sig = sig * 1 * 0.4;
}.play(fadeTime: 0);
)






(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = ~div16.(tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 0, 0].wrapExtend(8*7) ++
        [1, 0, 0, 0, 1, 0, 1, 0]
        , inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4].wrapExtend(4*2) ++ [0.5, 0.5], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + 7,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0.95,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0.9
    )[1];
    sig = sig = CombC.ar(sig, 1, ~nT.beatDur/32, 2) * 4;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = sig * 0.1 * 8;
    sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.275, 0.5, algo: 3, timb: 0.8)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.275, 0.5, algo: 3, timb: 0.8)[0]);
    ~v.(sig, 1000) * 8;
}.play(fadeTime: 0);
)