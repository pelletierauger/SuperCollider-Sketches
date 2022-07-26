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
    var pitch = Demand.kr(t, 0, Dseq([0, 3, -5, -2].stutter(32), inf));
    var sig = MiPlaits.ar(
        pitch: 36 + pitch,    engine: 5,
        harm: m,      timbre: 0.1,     morph: m + 0,
        trigger: t,   level: t.lag(0.1) * m2,
        fm_mod: m,    timb_mod: m * 0.5,     morph_mod: 0,
        decay: 0.2,   lpg_colour: 0.75
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = VadimFilter.ar(sig, 2000, 0, 1) * 2;
    sig = VAKorg35.ar(sig, freq: (36 + pitch).midicps.lag(0.5), res: 0, overdrive: 0.5) * 0.5;
    sig = sig * 0.4 * 4 * 4;
}.play(fadeTime: 0);
)


(
k.free;
k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 12 - 5,
        contour: 0.5,
        bow_level: 0.6,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.2,
        space: 0.99,
        model: 0
    );
    sig * 4;
}.play;
TempoClock.default.sched(4, {
    l.free;
    l = {
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var sig = MiElements.ar(
            gate: 1,
            pit: 32 + 12 + 12 + 12,
            contour: 0.5,
            bow_level: 0.6,
            bow_timb: 0.5,
            geom: 0.25,
            bright: 0.2,
            space: 0.99,
            model: 0
        );
        sig * 16;
    }.play;
    nil;});
)


(
    m.free;
    m = {
    var x = MouseX.kr(0, 1);
    var y = MouseY.kr(0, 1);
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var sig = MiElements.ar(
            gate: 1,
            pit: 32 + 12 + 12 + 12,
            contour: 0.45,
            bow_level: 0.6,
            bow_timb: y,
            geom: x,
        pos: y,
            bright: 0.6,
            space: 0.99,
            model: 2
        );
    sig = VadimFilter.ar(sig, 1000, 0, 3) + (sig * 0.35);
        sig * 32;
    }.play;
)