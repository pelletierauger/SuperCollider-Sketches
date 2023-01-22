(
~hiss.free;
~hiss = {
    | trigGate = 1 |
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t0 = ~div16.(tr[0]);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 1], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.001, 0.5], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("A5") + -5 + 0;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12 - 12,
        struct: 0.5, bright: 0.75, damp: 0.65, pos: 0.275,
        model: 4, easteregg: 1, poly: 1, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 500 * env.lag(0.01) + 200, 0, 3) * 4 * env;
    // sig = (ri) + (sig * ri * 0);
    sig * 1 * dd.lag(0.1);
}.play;
)
