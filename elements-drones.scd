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
        sig * 4;
    }.play;

    nil;});

)
z = { MiRings2.ar(PinkNoise.ar(0.1), pit: 32 + 0, model:3) * 2.25 * Line.kr(0, 1, 3)}.play;
z.free;



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
    var sig2 = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 12 - 5 + 0.1,
        contour: 0.5,
        bow_level: 0.6,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.2,
        space: 0.99,
        model: 0
    );
    [sig[0], sig2[1]] * 4;
}.play;
TempoClock.default.sched(4, {
    l.free;
    l = {
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var sig = MiElements.ar(
            gate: 1,
            pit: 32 + 12 + 12 + 12 + 0.05,
            contour: 0.5,
            bow_level: 0.6,
            bow_timb: 0.5,
            geom: 0.25,
            bright: 0.2,
            space: 0.99,
            model: 0
        );
        var sig2 = MiElements.ar(
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
        [sig[0], sig2[0]] * 4;
    }.play;

    nil;});
)

//  Tentatives de basses

z = { MiRings2.ar(PinkNoise.ar(0.1), pit: 32 + 0, model:3) * 2.25 * Line.kr(0, 1, 3)}.play;
z.free;

(
x = {
    var f = 32 - 0;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    LPF.ar([sig1[0], sig2[0]] * 1 * Line.kr(0, 1, 3), 500);
}.play;
)

x.free;