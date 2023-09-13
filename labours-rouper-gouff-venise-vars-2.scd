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
    var o = Demand.kr(t0, 0, Dseq([0, 1].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B4") + 0 + 12 + o;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.75, bright: 0.5, damp: 0.25, pos: 0.275,
        model: 0, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128), lev1: 0.5, lev2: 0.5,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    sig * 4 * dd.lag(0.1);
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
    var o = Demand.kr(t0, 0, Dseq([0, 1].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("E4") + 0 + 12 + 0;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.75, bright: 0.5, damp: 0.5, pos: 0.125,
        model: 1, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128), lev1: 0.5, lev2: 0.5,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0)[0] * 0.25 ! 2;
    sig = ~v.(sig, 200, 0, 5);
    sig * 4 * dd.lag(0.1);
}.play(fadeTime: 0);
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
    var o = Demand.kr(t0, 0, Dseq([0, 1].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B3") + 0 + 12 + o;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.75, bright: 0.5, damp: 0.25, pos: 0.275,
        model: 0, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128/8), lev1: 0.75, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig * 4 * dd.lag(0.1);
}.play;
)