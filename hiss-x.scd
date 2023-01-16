(
~hissX.free;
~hissX = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var ddd = Demand.kr(t, 0, Dseq([8, 7,5,3,2,0,3, 5].stutter(1), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 8], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("A#3") + ddd;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: 0.52, color: 0.5*env, model: 14
    );
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    sig = ~v.(sig, 6000 * SinOsc.kr(~nT.tempo*4).unipolar*env + 100, 0, 1) * env;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.135 * dd.lag(0.1);
}.play;
)
