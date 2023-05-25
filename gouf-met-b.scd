(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[1], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([0, 0, 0, 1, 0, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var pitch = ~toMidi.("Db1");
    var sig = MiRings.ar(t, t, pit: pitch,
        struct: 0.125, bright: 0.275, damp: 0.75, pos: 0.275,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 1 );
    sig * 0.25 ! 2 * dd.lag(0.1);
}.play;
)


(
c.free;
c = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.1], ['lin', -8]), gate: t);
    var pitch = ~toMidi.("Db0");
    var sig = PinkNoise.ar() * env2;
    sig = sig + CombN.ar(sig, 1, ~nT.beatDur/8, 6);
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch,
        struct: 0.5, bright: 0.75, damp: 0.5, pos: 0.125,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 1 );
    sig[0] ! 2 * 3 * dd.lag(0.1);
}.play;
)


(
c.free;
c = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 0, 0, 0, 0, 0], inf));
    var t2 = t0 * Demand.kr(t0, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var envb = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t2);
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.1], ['lin', -8]), gate: t);
    var env3 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.1], ['lin', -8]), gate: t2);
    var pitch = ~toMidi.("Db0");
    var sig = PinkNoise.ar() * env2;
    sig = sig + CombN.ar(sig, 1, ~nT.beatDur/4, 6);
    sig = sig + (PinkNoise.ar() * env3 + CombN.ar(PinkNoise.ar() * env3, 1, ~nT.beatDur/3, 6));
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch,
        struct: 0.5, bright: 0.75, damp: 0.5, pos: 0.125,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * (env+envb).lag(0.1) + 200, 0, 1 );
    sig[0] ! 2 * 4 * dd.lag(0.1);
}.play;
)