(
j.set(\gate, 0, \fadeTime, 0.1);
j = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -4].stutter(8), inf));
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("D2") + 12 + note.lag(0.1),
        engine: 2,
        harm: 0.25,
        timbre: 0.25,
        morph: 0.75,
        decay: 1
    )[1] * 0.25;
    sig = VadimFilter.ar(sig, 3000, 0, 1);
    sig!2 * dd.lag(0.1) * 2;
}.play;
)
