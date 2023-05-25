(
d.free;
d = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([0, 0, 0, 1] ++ [0, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.1], ['lin', -8]), gate: t);
    var pitch = ~toMidi.("Db0") + 10;
    var sig = PinkNoise.ar() * env2;
    sig = sig + CombN.ar(sig, 1, ~nT.beatDur/4, 6);
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch,
        struct: 0.75, bright: 0.95, damp: 0.5, pos: 0.5,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 6000 * env.lag(0.1) + 200, 0, 3 );
    sig = sig[0] ! 2 * 16 * dd.lag(0.1);
        sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.95, algo: 4, timb: 0.28)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.95, algo: 4, timb: 0.28)[0]);

}.play;
)



(
d.free;
d = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 0] ++ [0, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.1], ['lin', -8]), gate: t);
    var pitch = ~toMidi.("Db0") + 10;
    var sig = PinkNoise.ar() * env2;
    sig = sig + CombN.ar(sig, 1, ~nT.beatDur/8, 9);
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch,
        struct: 0.75, bright: 0.25, damp: 0.5, pos: 0.5,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 6000 * env.lag(0.1) + 200, 0, 3 );
    sig = sig[0] ! 2 * 16 * dd.lag(0.1);
        sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.95, algo: 4, timb: 0.8)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.95, algo: 4, timb: 0.8)[0]);
    sig = ~v.(sig, 2000, 0, 5);
    sig * 8;
}.play;
)