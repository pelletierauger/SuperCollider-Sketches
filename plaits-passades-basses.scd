(
z.free;
z = {
    | trigGate = 1 |
    var t = Impulse.kr(0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0.7, 0], [0.01, 0.1, 4], [2, 'lin', 0]), t);
    var note = Demand.kr(t, 0,
        Dseq([-6, -10, -12, -9].stutter(2)
            , inf) +
            Dseq([-12, 0], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 0 + [0, 0.1],
        engine: 6,
        harm: env.pow(3) * 0.05,
        timbre: env.pow(3).lag(0.1),
        morph: 0.5
    ) * 0.25 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 2000);
    sig = MiRings.ar(sig,
        pit: 60 + note - 24,
        struct: 0.9,
        bright: 0.3,
        damp: 0.7,
        pos: 0.25,
        model: 0
    );
    // sig = LPF.ar(sig, 1200);
    // sig[1]!2;
}.play;
)

z.set(\trigGate, 0, \gate, 0, \fadeTime, 15);