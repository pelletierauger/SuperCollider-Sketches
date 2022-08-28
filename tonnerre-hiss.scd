(
~hiss.free;
~hiss = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([0, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12 - 12,
        struct: 0.5, bright: 0.75, damp: 0.65, pos: 0.275,
        model: 4, easteregg: 1, poly: 1, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 5) * 8;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)



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
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12;
    var sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12 - 12,
        struct: 0.125, bright: 0.75, damp: 0.65, pos: 0.275,
        model: 4, easteregg: 1, poly: 1, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 5) * 8;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)


(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd + DelayN.kr(tr[1] * dd, 1, ~nT.beatDur * 0.125);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.25], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12 - 5;
    var sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12 - 12,
        struct: 0.125, bright: 0.85, damp: 0.25, pos: 0.275,
        model: 4, easteregg: 1, poly: 2, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 5) * 8;
    sig = VadimFilter.ar(sig, 9000 * (1 - env.lag(0.1)) + 200, 0, 5) * 8;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)




(
u.free;
u = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd + (DelayN.kr(tr[1] * dd, 1, ~nT.beatDur * 0.125) * 0);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 12], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12 - 5;
    var sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + 12,
        struct: 0.25, bright: 0.25, damp: 0.5, pos: 0.275,
        model: 2, easteregg: 1, poly: 2, intern_exciter: 1);
/*    sig = MiWarps.ar(sig, sig, 0.5, 0.5, algo: 0, timb: 0.3, osc: 2, freq: (23 + 12).midicps,
        vgain: 1, easteregg: 0
    );*/
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 5) * 8;
    sig = VadimFilter.ar(sig, 1000 * (1 - env.lag(0.1)) + 200, 0, 5) * 1;
    // sig = VadimFilter.ar(sig, SinOsc.kr(~nT.tempo * 4).unipolar * 4000 + 4000, 0, 1) * 4;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)




(
u.free;
u = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd + (DelayN.kr(tr[1] * dd, 1, ~nT.beatDur * 0.125) * 0);
    var t = t0 * Demand.kr(t0, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.85, 0.75].stutter(32), inf));
    var ss = Demand.kr(t, 0, Dseq(Dseries(1, -1/16, 16), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 4], ['lin', -8]), gate: t) * ss;
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12 - 5;
    var sig = MiRings.ar(0, t, pit: pitch + m - 24 - 5 + 12 + [0, 0.1],
        struct: 0.1, bright: 0.75, damp: 0.1, pos: 0.75,
        model: 1, easteregg: 0, poly: 2, intern_exciter: 1);
/*    sig = MiWarps.ar(sig, sig, 0.5, 0.5, algo: 0, timb: 0.3, osc: 2, freq: (23 + 12).midicps,
        vgain: 1, easteregg: 0
    );*/
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 5) * 8;
    // sig = VadimFilter.ar(sig, 1000 * (1 - env.lag(0.1)) + 200, 0, 5) * 1;
    sig = VadimFilter.ar(sig, SinOsc.kr(~nT.tempo * 4).unipolar * 2000 + 100, 0, 1) * 4;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)