(
~cloche.free;
~cloche = {
    | trigGate = 1, bright = 0.75, damp = 0.5, pos = 0.125, envMul = 0 |
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
    sig = MiRings.ar(sig, 0, pit: pitch + (env * envMul),
        struct: 0.5, bright: bright, damp: damp, pos: pos,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig[0], 3000 * env.lag(0.1) + 200, 0, 1 );
    sig ! 2 * 2 * dd.lag(0.1);
}.play;
)
~cloche.set(\bright, 0.295);
~cloche.set(\damp, 0.9);
~cloche.set(\pos, 1);
~cloche.set(\envMul, 1);

(
~cloche.free;
~cloche = {
    | trigGate = 1, bright = 0.75, damp = 0.5, pos = 0.125, envMul = 0 |
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
    sig = MiRings.ar(sig, 0, pit: pitch + (env * envMul),
        struct: 0.5, bright: bright, damp: damp, pos: pos,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig[0], 3000 * env.lag(0.1) + 200, 0, 1 );
    sig ! 2 * 3 * dd.lag(0.1);
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
    sig = MiRings.ar(sig, 0, pit: pitch + env,
        struct: 0.5, bright: 0.95, damp: 0.95, pos: 0.95,
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
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.1], ['lin', -8]), gate: t);
    var pitch = ~toMidi.("Db0");
    var sig = PinkNoise.ar() * env2;
    var sigHaut;
    sig = sig + CombN.ar(sig, 1, ~nT.beatDur/8, 6);
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch + env,
        struct: 0.5, bright: 0.95, damp: 0.95, pos: 0.95,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sigHaut = ~v.(sig[0], 5000, 0, 5) * (1-env);
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 1 );
    sig[0] ! 2 * 3 +(sigHaut * 16) * dd.lag(0.1);
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
    var sigHaut;
    sig = sig + CombN.ar(sig, 1, ~nT.beatDur/8, 6);
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch + env,
        struct: 0.5, bright: 0.95, damp: 0.95, pos: 0.95,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sigHaut = ~v.(sig[0], 5000, 0, 5) * (1-env);
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 1 );
    sig = sig[0] ! 2 * 3 + (sigHaut * 16) * dd.lag(0.1);
    sig[0] = (MiWarps.ar(sig[0], sig[0], 0.75, 0.25, algo: 1, timb: 0.328)[0]);
    sig[1] = (MiWarps.ar(sig[1], sig[1], 0.75, 0.25, algo: 1, timb: 0.428)[0]);
    sig = sig * 0.1;
}.play;
)