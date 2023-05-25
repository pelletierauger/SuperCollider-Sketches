(
b.free;
b = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 0] ++ [0, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.1], ['lin', -8]), gate: t);
    var t8 = (tr[1]);
    var env3 = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.5], ['lin', -8]), gate: t8);
    var rise = Demand.kr(t8, 0, Dseq([Dseries(1/64, 1/64, 16)], inf));
    var pitch = ~toMidi.("Db0") + 10;
    var sig = PinkNoise.ar() * env3 * rise;
    // sig = sig + CombN.ar(sig, 1, ~nT.beatDur/8, 9);
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch,
        struct: 0.75, bright: 0.5, damp: 0.5, pos: 0.5,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 9000 * env.lag(0.1) + 200, 0, 3 );
    sig = sig[0] * 16 * dd.lag(0.1);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.95, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.95, algo: 4, timb: 0.8)[0]);
    sig = ~v.(sig, 6000, 0, 5) * 16 * 4;
        sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig * 8;
}.play;
)



(
g.free;
g = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 0] ++ [0, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.1], ['lin', -8]), gate: t);
    var t8 = ~div8.(tr[1]);
    var env3 = EnvGen.kr(Env.new([0, 1, 0], [0.005, 0.5], ['lin', -8]), gate: t8);
    var rise = Demand.kr(t8, 0, Dseq([Dseries(1/64, 1/64, 8)], inf));
    var pitch = ~toMidi.("Db0") + 10;
    var sig = PinkNoise.ar() * env3 * rise;
    // sig = sig + CombN.ar(sig, 1, ~nT.beatDur/8, 9);
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch,
        struct: 0.5, bright: 0.5, damp: 0.5, pos: 0.5,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 9000 * (1-env.lag(1)) + 200, 0, 3 );
    sig = sig[0] * 16 * dd.lag(0.1);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.95, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.95, algo: 4, timb: 0.8)[0]);
    sig = ~v.(sig, 6000, 0, 5) * 16 * 4;
        sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
        sig = DelayN.ar(sig, 1, ~nT.beatDur / 4 * 2) * Line.kr(0,1,~nT.beatDur*16);
    sig * 8;
}.play;
)


(
g.free;
g = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 0] ++ [0, 0, 0, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.1], ['lin', -8]), gate: t);
    var t8 = ~div8.(tr[1]);
    var env3 = EnvGen.kr(Env.new([0, 1, 0], [0.005, 0.5], ['lin', -8]), gate: t8);
    var rise = Demand.kr(t8, 0, Dseq([Dseries(1/64, 1/64, 8)], inf));
    var pitch = ~toMidi.("Db0") + 10;
    var sig = PinkNoise.ar() * env3 * rise;
    // sig = sig + CombN.ar(sig, 1, ~nT.beatDur/8, 9);
    // sig = ~v.(sig, 100, 0, 5) * 2;
    sig = MiRings.ar(sig, 0, pit: pitch,
        struct: 0.5, bright: 0.5, damp: 0.5, pos: 0.5,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 9000 * (1-env.lag(1)) + 200, 0, 3 );
    sig = sig[0] * 16 * dd.lag(0.1);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.95, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.95, algo: 4, timb: 0.8)[0]);
    sig = ~v.(sig, 6000, 0, 1) * 0.1;
        sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = DelayN.ar(sig, 1, ~nT.beatDur);
    sig * 8 * 4;
}.play;
)