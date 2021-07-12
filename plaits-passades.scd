(
y.free;
y = {
    | trigGate = 1 |
    var t = Impulse.kr(0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 8], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 12 + 5 - 0,
        engine: 2,
        harm: 0.5,
        timbre: env.pow(3).lag(0.4) * 0.5,
        morph: 0.8
    ) * 0.25 * env;
    sig = LPF.ar(sig, 1000);
    sig[1]!2;
}.play;
)

y.set(\trigGate, 0, \gate, 0, \fadeTime, 25);

(
x.free;
x = {
    | trigGate = 1 |
    var t = Impulse.kr(0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 8], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 12 + 5 - 0,
        engine: 2,
        harm: 0.1,
        timbre: env.pow(3).lag(0.4) * 0.5,
        morph: env.pow(1)
    ) * 0.25 * env;
    sig = LPF.ar(sig, 1000);
    sig[1]!2;
}.play;
)

x.set(\trigGate, 0, \gate, 0, \fadeTime, 25);