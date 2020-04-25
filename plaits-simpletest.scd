(
{
    var trig = Impulse.kr(1);
    MiPlaits2.ar(35,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.25,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 1);
}.plot(1);
)