x = { MiPlaits.ar(38 + -7 + [0, 0.1], 5, harm: SinOsc.kr(0.1).range(0.1, 0.25), morph: 0, mul: 0.2) }.play;

(
x = {

    var voice = MiPlaits.ar(38 + 5 - 12 + [0, 0.1], 5, harm: SinOsc.kr(0.1).range(0.15, 0.25), timbre: 0.75, morph: 0.5, mul: 0.2);
    LPF.ar(voice, 1750);
}.play;
)