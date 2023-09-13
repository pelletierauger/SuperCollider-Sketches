(
w.free ;
w = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var melo = Demand.kr(t, 0, Dseq([7, 2, 3, 0].stutter(8), inf));
    var m2 = Demand.kr(t, 0, Dseq([0.75, 0.64].stutter(4), inf));
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("E2") + melo,    engine: 0,
        harm: m,      timbre: m2,     morph: m * 1.5,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0
    )[0];
    var tail;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = VadimFilter.ar(sig, 2500, 0, 1);
    // tail = CombN.ar(sig, 1, ~nT.beatDur * 0.25, 1);
    // sig = sig * 0.5 + (VadimFilter.ar(tail, 900, 0, 1) * 8);
/*        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );*/
    sig = sig * 0.8 * 8;
}.play(fadeTime: 0);
)
~toNote.(47 + 24)
~toMidi.("E4")