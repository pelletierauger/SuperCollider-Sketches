(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var sig = MiPlaits.ar(
        pitch: 31 + [0, 0.1],
        engine: 5,
        harm: lfo,
        morph: 0
    );
    sig = [sig[0][0], sig[1][0]] * 0.2;
    sig = sig + (VadimFilter.ar(sig, 500, 0.25, 1) * 4);
}.play(fadeTime: 0.1);
)