
Safety(s).disable;

(
x.free;
x = {
    var t = Impulse.kr(6);
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 48,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0
    )[0];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = sig * 0.4 * 1;
}.play(fadeTime: 0);
)


(
y.free;
y = {
    var t = Impulse.kr(4);
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 0,    engine: 15,
        harm: m + 0.6,      timbre: 0.85,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0.75,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = sig * 0.4 * 8 * 2;
}.play(fadeTime: 0);
)



(
z.free;
z = {
    var t = Impulse.kr(6);
    var b = t * Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var m3 = Demand.kr(b, 0, Dwhite());
    var sig = MiPlaits.ar(
        pitch: 0,           engine: 15,
        harm: 1 - (m2 * 0.1),            timbre: 0.85,       morph: m,
        trigger: b,         level: t.lag(0.1) * m2 * 2,
        fm_mod: -1 + m2,    timb_mod: 0.75,     morph_mod: 0,
        decay: 0.5,         lpg_colour: 0
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = sig + (VAKorg35.ar(sig, freq: 200, res: 0, overdrive: 0.05) * m3.lag(0.1) * 4);
    sig = sig * 0.4 * 8 * 2;
}.play(fadeTime: 0);
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
z.free;
z = {
    var t = Impulse.kr(~nT.tempo * 4);
    var b = t * Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var m3 = Demand.kr(b, 0, Dwhite());
    var sig = MiPlaits.ar(
        pitch: 0,           engine: 15,
        harm: 1 - (m2 * 0.1),            timbre: 0.85,       morph: m,
        trigger: b,         level: t.lag(0.1) * m2 * 2,
        fm_mod: -1 + m2,    timb_mod: 0.75,     morph_mod: 0,
        decay: 0.5,         lpg_colour: 0
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = sig + (VAKorg35.ar(sig, freq: 200, res: 0, overdrive: 0.05) * m3.lag(0.1) * 4);
    sig = sig * 1 * 8 * 2;
}.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + 0.25, {
x.free;
x = {
    var t = Impulse.kr(~nT.tempo * 4);
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 48,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0
    )[0];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = sig * 0.4 * 1;
}.play(fadeTime: 0);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.5, {
w.free;
w = {
        // var t = Impulse.kr(~nT.tempo * 4 * 1);
        var t = DelayN.kr(Impulse.kr(~nT.tempo * 4 * 1), 1, 0.5);
        var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!7), inf));
        var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
        var level = b.lag(0.1) * m2 * 12 + (b * 4);
    var sig = MiPlaits.ar(
        pitch: 60 - 12 - 0,    engine: 9,
        harm: m,      timbre: 1,     morph: morph,
        trigger: b,   level: level * level,
        fm_mod: 0,    timb_mod: 0,     morph_mod: -0.5,
        decay: 0.65,   lpg_colour: 0.25
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2;
        sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.5, {
u.free;
u = {
        var t = DelayN.kr(Impulse.kr(~nT.tempo * 4 * 1), 1, 0.5);
        var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!7), inf));
        var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
        var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 60 + 12,    engine: 10,
        harm: 1,      timbre: 1,     morph: 0,
        trigger: b,   level: level,
        fm_mod: 1,    timb_mod: 1,     morph_mod: -0.5,
        decay: 0.65,   lpg_colour: 0.25
    )[0];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 4;
        sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
});
)