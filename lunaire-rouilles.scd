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
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 15
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24 - 5 + 12 + 12,
        struct: n, bright: 0.15, damp: 0.95, pos: 0.95, model: 1, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 200, 0, 5);
    // sig = (ri) + (sig * ri * 0);
    sig = MiMu.ar(sig, 6);
    sig * 0.125 * dd.lag(0.1);
}.play;
)


// Agent Gage Blackwood
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
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 2], ['lin', -8]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(sig, b, pit: pitch - 24 - 5 + 12 + 12,
        struct: n, bright: 0.15, damp: 0.25, pos: 0.15, model: 1, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 200, 0, 5);
    // sig = (ri) + (sig * ri * 0);
    sig = MiMu.ar(sig, 6);
    sig * 0.125 * dd.lag(0.1);
}.play;
)

// Rouille nocturne
(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 10], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12 - 12,
        struct: 0.1, bright: 0.5, damp: 0.5, pos: 0.75,
        model: 3, easteregg: 1, poly: 4, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 6000 * env.lag(0.1) + 200, 0, 1) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.125 * dd.lag(0.1);
}.play;
)


// La rouille calme de l'automne musical
(
q.free;
q = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([0, 1], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.75, 0.5].stutter(4), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 10], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12,
        struct: 0.1, bright: 0.85, damp: 0.75, pos: n,
        model: 3, easteregg: 1, poly: 4, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 1000 * env.lag(0.1) + 20, 0, 1) * 8;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.125 * dd.lag(0.1);
}.play;
)

~toNote.(13);

(
q.free;
q = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([0, 1], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.75, 0.5].stutter(4), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 10], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12,
        struct: 0.4, bright: 0.85, damp: 0.75, pos: n,
        model: 3, easteregg: 1, poly: 4, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 1000 * env.lag(0.1) + 20, 0, 1) * 8;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.125 * dd.lag(0.1);
}.play;
)