(
x.free;
x = {
    var sig = MiBraids.ar(52) * 0.1!2;
    var t = Impulse.kr(1);
    sig = sig * EnvGen.kr(Env([0, 1, 0], [0.001, 1]), t);
    MiRings.ar(sig, pit: 52, struct: 0.3, model: 4) * 0.2;
}.play;
)