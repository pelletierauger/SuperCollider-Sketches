(
v.free;
v = {
    var trig, sig;
    trig = Impulse.kr(7.5 * 0.25);
    sig = MiPlaits.ar(55 - 24,
        engine: 13,
        harm: 0.5,
        timbre: 0.2,
        morph: 0.5,
        trigger: trig,
        decay: 0.1
    );
    sig = sig[0]!2 * 2;
}.play;
)

(
w.free;
w = {
    var trig, sig;
    trig = Impulse.kr(7.5 * 0.125);
    sig = MiPlaits.ar(55 - 24,
        engine: 15,
        harm: 0.05,
        timbre: 0.6,
        morph: 0.2,
        trigger: trig
    );
    sig = sig[0]!2 * 1;
}.play;
)