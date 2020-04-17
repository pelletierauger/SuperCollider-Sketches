(
var f = 220 * 10.midiratio;
x = {
        var trig = Impulse.ar(1);
    var sig = MiPlaits.ar(31 + 24 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);
    sig = (sig * 0.35) + MiRings.ar(sig,
        0,
        voct: 55,
        struct: 0.5,
        bright: 0.2,
        damp: 0.85,
        pos: 2,
        usetrigger: 0,
        bypass: 0);
}.play;
)