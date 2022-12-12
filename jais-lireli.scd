// Les lignes religieuses

(
~ligneReli1.free;
~ligneReli1 = {
        | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var i = Impulse.kr(0.25);
    var d = Demand.kr(t, 0, Dseq([0, 2, 5, 4].stutter(2), inf));
    var sig = MiElements.ar(
        gate: 1,
        pit: ~toMidi.("B4") - 6 + 3 - 12 + d + 7,
        contour: 0.51,
        bow_level: 0.6,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.2,
        space: 0.99,
        model: 0
    );
    sig * 4;
}.play;
)


// Les lignes religieuses

(
~ligneReli1.free;
~ligneReli1 = {
        | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var i = Impulse.kr(0.25);
    var d = Demand.kr(t, 0, Dseq([0, 2, 5, 4].stutter(2), inf));
    var e = Demand.kr(t, 0, Dseq([1, 0], inf)).lag(0.3) * 0.5;
    var sig = MiElements.ar(
        gate: 1,
        pit: ~toMidi.("B4") - 6 + 3 - 12 + d + 7,
        contour: 0.51,
        bow_level: 0.6,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.2 + e,
        space: 0.99,
        model: 0
    );
    sig * 4;
}.play;
)