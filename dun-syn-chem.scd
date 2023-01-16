(
~hissX.free;
~hissX = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq((1!1) ++ (1!1), inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var ddd = Demand.kr(t, 0, Dseq([8, 7, 5, 0].stutter(2), inf));
    var e = EnvGen.kr(Env.new([0.001, 1, 0.001], [0.05, 0.5], ['exp']), gate: t);
    var ri;
    var pitch = ~toMidi.("A#1") + ddd;
    var sig = MiBraids.ar(pitch + [0, 0.1+12, 0.2, 0.3+12],
        timbre: 0.4+(1-e), color: 0.5 * e, model: 14
    );
    sig = [sig[0] + (sig[1]), sig[2] + (sig[3])];
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    // sig = ~v.(sig, 2000 *(1-e) + 10, 0, 5);
    sig = ~v.(sig, 3000 * e + 100);
    // sig = ~v.(sig, 100, 0, 5);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)


(
~hissXZ.free;
~hissXZ = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq(1!1 ++ (0!15), inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var ddd = Demand.kr(t, 0, Dseq([8, 7,5,3,2,0,3, 5].stutter(1), inf));
    var e = EnvGen.kr(Env.new([0.001, 1, 0.001], [0.15, 6], ['exp']), gate: t).lag(0.01);
    var ri;
    var pitch = ~toMidi.("A#3") + ddd;
    var sig = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0,
        timbre: 0.72+(1-e), color: 0.5, model: 14
    ).sum;
    var sig2 = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0.5,
        timbre: 0.72+(1-e), color: 0.5, model: 14
    ).sum;
    sig = [sig + (sig2*(e.linlin(0,1,0.5,1))), sig2 + (sig*(e.linlin(0,1,0.5,1)))];
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    sig = ~v.(sig, 1500 * ~lfo.(~nT.tempo*4*e,0.5+(1-(0.5*e)),1) * e + 500, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.4);
}.play;
)




(
~hissX.free;
~hissX = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq((1!1) ++ (0!3), inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var ddd = Demand.kr(t, 0, Dseq([8, 7, 8, 0].stutter(2), inf));
    var e = EnvGen.kr(Env.new([0.001, 1, 0.001], [0.05, 1], ['exp']), gate: t);
    var ri;
    var pitch = ~toMidi.("A#0") + ddd;
    var sig = MiBraids.ar(pitch + [0, 0.1+12, 0.2, 0.3+12],
        timbre: 0.3, color: 0.95, model: 3 + floor(MouseX.kr(0,32))
    );
    sig = [sig[0] + (sig[1]), sig[2] + (sig[3])];
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    // sig = ~v.(sig, 2000 *(1-e) + 10, 0, 5);
    sig = ~v.(sig, 2000 * e + 200);
    // sig = ~v.(sig, 100, 0, 5);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)