(
x = {
    var sig = MiPlaits.ar(38 + -7 + 12 + 4 + 19 + [0, 0.1], 5,
    harm: SinOsc.kr(0.1).range(0.1, 0.5),
    timbre: 0.5,
    morph: 0.25,
    mul: 0.2);
    var lfoFreq = SinOsc.kr(0.25).range(440, 900);
    LPF.ar(sig, lfoFreq);
    // sig;
}.play;
)


(
{
    LFSaw.ar(55 * [1, 1.001]) * 0.1;
}.play;
)