(
z.free;
z = {
    var f = 31 - 2;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var alg = 5;
    var sig = MiPlaits.ar(f + [0, 0.1], alg, harm: lfo, morph: 0, mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    sig = [sig[0][0], sig[1][0]] * 2;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05) +
    (VadimFilter.ar(sig, 1000, resonance: 0, type: 5) * 3);
}.play(fadeTime: 0.3);
)
