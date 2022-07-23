(
~ba.free;
~ba = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.15, 0.1], inf));
    var pitch = Demand.kr(t, 0, Dseq([0, 3, -2, -5].stutter(8), inf));
    var sig = MiPlaits.ar(
        pitch: 36 + pitch,    engine: 1,
        harm: m,      timbre: 0.1,     morph: m + 0,
        trigger: t,   level: t.lag(0.1) * m2,
        fm_mod: m,    timb_mod: m * 0.5,     morph_mod: 0,
        decay: 0.2,   lpg_colour: 0.75
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = VadimFilter.ar(sig, 2000, 0, 1) * 2;
    sig = VAKorg35.ar(sig, freq: 1200, res: 0, overdrive: 0.05) * 0.5;
    sig = sig * 0.4 * 4 * 2;
}.play(fadeTime: 0);
)