(
{
    MiPlaits
}
)

(   // super saw
{
    var t = Impulse.kr(0.25);
    var n = Demand.kr(t, 0, 60 + Dseq([0, 2, 3, 5], inf));
    var out = MiPlaits.ar(
        pitch: n + [0, -12, -12.1],
        engine: 7,
        harm: 0.95,
        timbre: 0.5,
        morph: Phasor.kr(t, 0.00005 * 1),
        trigger: 0,
        mul: 0.8

    );
    out = LPF.ar(out, 1000);
    // out = GVerb.ar(out);
        ([out[0][0] + out[1][0], out[0][0] + out[2][0]]);
}.play
)