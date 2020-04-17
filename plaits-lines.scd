x = { MiPlaits.ar(31 + 12 + 0 + [0, 0.1], 2, timbre: 0.2, harm: 0, morph: 0.5, mul: 0.2) }.play;


(
x = {
    var freq = EnvGen.ar(Env.step([35, 30, 35], [5, 5, 5], 2, 0));
    MiPlaits.ar(freq + 9 + [0, 0.1], 2, timbre: 0.2, harm: 0, morph: 0.5, mul: 0.2)
}.play;
// x = { MiPlaits.ar(35 + 9 + 7 + 5 + [0, 0.1], 2, timbre: 0.2, harm: 0.5, morph: 0, mul: 0.1) }.play;
)

x = { MiPlaits.ar(35 + 12 + 24 + [0, 0.1], 11, timbre: 0.25, harm: 0.125, morph: 0.5, mul: 0.1) }.play;

