(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = ~div8.(tr[1] * dd);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, 1].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("E2") + 0 + 12 + -5;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.75, bright: 0.25, damp: Demand.kr(t0, 0, Dwhite(0.2)), pos: Demand.kr(t0, 0, Dwhite()),
        model: 0, easteregg: 1, poly: 1, intern_exciter: 0);
    // sig.size.poll;
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.125;
    // sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128*4), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.5;
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];
    // sig = ~v.(sig, 200, 0, 5);
    sig * 0.4 * dd.lag(0.1);
}.play(fadeTime: 0);
)

(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = ~div8.(tr[1] * dd);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, 1].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("E5") + 0 + 12 + -5;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.5, bright: 0.25, damp: Demand.kr(t0, 0, Dwhite(0.2)), pos: Demand.kr(t0, 0, Dwhite()),
        model: 0, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig.size.poll;
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.125;
    // sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128*4), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.5;
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];
    // sig = ~v.(sig, 1200, 0, 5);
    sig * 0.4 * dd.lag(0.1);
}.play(fadeTime: 0);
)


(
j.free;
j = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = ~div8.(tr[1] * dd);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, -2].stutter(64), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("E5") + 0 + 12 + -5  + o;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.25, bright: 0.25, damp: Demand.kr(t0, 0, Dwhite(0.2)), pos: Demand.kr(t0, 0, Dwhite()),
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig.size.poll;
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.125;
    // sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128*4), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];
    // sig = ~v.(sig, 1200, 0, 5);
    sig * 0.4 * dd.lag(0.1);
}.play(fadeTime: 0);
)

(
j.free;
j = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = ~div8.(tr[1] * dd);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, -2].stutter(64), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("F#3") + o;
    var sig = MiRings.ar(t, t, pit: pitch,
        struct: 0.5, bright: 0.5, damp: Demand.kr(t0, 0, Dwhite(0.2)), pos: Demand.kr(t0, 0, Dwhite()),
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig.size.poll;
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.125;
    // sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig = sig + ~v.(CombC.ar(sig, 1, ~nT.beatDur/16, ~nT.beatDur*1)*1,1000);
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128), lev1: 1.75, lev2: 0.75,
        algo: 3, timb: 0.95, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.15;
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];

/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128*0), lev1: 1.75, lev2: 0.75,
        algo: 4, timb: 0.95, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.15;
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];*/

    // sig = MiVerb.ar(sig, damp: 0.99) * 2;
    // sig = ~v.(sig, 2200, 0, 1);
    sig * 0.4 * dd.lag(0.1);
}.play(fadeTime: 0);
)

~toMidi.("E6") - 29 - 5
~toNote.(54)
(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = ~div8.(tr[1] * dd);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var o = Demand.kr(t0, 0, Dseq([0, -2].stutter(64), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("E4") + 0 + 12 + -5  + o;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.125, bright: 0.25, damp: Demand.kr(t0, 0, Dwhite(0.7, 0.8)), pos: Demand.kr(t0, 0, Dwhite(0.5, 0.75)),
        model: 0, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig.size.poll;
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.125;
    // sig = VadimFilter.ar(sig, 5000 * env.lag(0.1) + 2000, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128*4), lev1: 0.5, lev2: 0.5,
        algo: 1, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    // sig[0].size.poll;
    sig = [sig[0][0], sig[1][0]];
    // sig = ~v.(sig, 1200, 0, 5);
    sig * 1 * dd.lag(0.1);
}.play(fadeTime: 0);
)