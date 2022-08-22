(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.5], ['lin', -8]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24 - 5 + 12 + 12,
        struct: n, bright: 0.15, damp: 0.95, pos: 0.95, model: 1, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 200, 0, 5);
    // sig = (ri) + (sig * ri * 0);
    sig = MiMu.ar(sig, 6);
    sig = VadimFilter.ar(sig, 5000, 0, 1);
    sig * 0.125 * dd.lag(0.1);
}.play;
)



(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.5], ['lin', -8]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24 - 5 + 12 + 12 + 12,
        struct: n, bright: 0.15, damp: 0.95, pos: 0.95, model: 4, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 200, 0, 5);
    // sig = (ri) + (sig * ri * 0);
    sig = MiMu.ar(sig, 6);
    sig = VadimFilter.ar(sig, 5000, 0, 1);
    sig * 0.125 * dd.lag(0.1);
}.play;
)



(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.5], ['lin', -8]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24 - 5 + 12 + 12 + 12,
        struct: n, bright: 0.5, damp: 0.95, pos: 0.95, model: 4, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 200, 0, 5);
    // sig = (ri) + (sig * ri * 0);
    sig = MiMu.ar(sig, 6);
    sig = VadimFilter.ar(sig, 5000, 0, 1);
    sig * 0.125 * dd.lag(0.1);
}.play;
)



(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.5], ['lin', -8]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24 - 5 + [0, 0.1],
        struct: n, bright: env, damp: 0.95, pos: 0.15, model: 4, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 200, 0, 5);
    // sig = (ri) + (sig * ri * 0);
    sig = MiMu.ar(sig, 6);
    sig = VadimFilter.ar(sig, 5000, 0, 1);
    sig * 0.125 * dd.lag(0.1);
}.play;
)