(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B4") + -5 + 12;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.35, bright: 0.5, damp: 0.25, pos: 0.275,
        model: 1, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 ! 2 * dd.lag(0.1);
}.play;
)


(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, -2].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B4") + -5 + 12 + o;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.355, bright: 0.5, damp: 0.25, pos: 0.275,
        model: 1, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)


(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, -2].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12 + o;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.355, bright: 0.5, damp: 0.25, pos: 0.275,
        model: 1, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)


(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, -2].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B4") + -5 + 12 + o;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.355, bright: 0.5, damp: 0.25, pos: 0.275,
        model: 1, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.28)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.28)[0]);
    sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;

    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)


(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, -2].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B4") + -5 + 12 + o;
    var st = t + CombN.kr(t, 1, 0.01, 1);
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.355, bright: 0.5, damp: 0.25, pos: 0.275,
        model: 1, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.28)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.28)[0]);
    sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;

    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)