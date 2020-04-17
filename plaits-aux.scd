(
x = {
    var f = 31 + 24 + 4;
    var sig = MiPlaits.ar(f + 0, 5, harm: SinOsc.kr(0.1).range(0.1, 0.25), morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, 5, harm: SinOsc.kr(0.1).range(0.1, 0.25), morph: 0, mul: 0.2);

    var sig3 = [sig[0], sig2[0]];
    LPF.ar(sig3, 2200);
    // sig3;
}.play;
)