(
l.free;
l = {
    var trig = Impulse.ar(122/60 * 0.5);
    var dem = Demand.ar(trig, 0, Dseq([0.95, 0.75].stutter(4), inf));
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 12 + 12 - 9 - 12,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.25 + (1 - dem * 0.5),
        geom: dem,
        bright: 0.4,
        damp: 0.4,
        space: 1,
        model: 1
    );
    HPF.ar(sig * 4, 700) * 32;
}.play;
)