(
u.free;
u = {
    |trigGate = 1 |
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var de = t * Demand.kr(t, 0, Dseq((1!1)++(0!15), inf));
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.5, 3], [6, 0, -6, 'lin']), de);
    var sig = MiBraids.ar(~toMidi.("D3") + [-24, 0, 3, 7, 14],
        timbre: 0.5, color: 0.5, model: 0;
    ).sum * dd.lag(0.025);
    sig = ~v.(sig, 2000 * e + 100) * 0.05 ! 2;
}.play;
)

(
u.free;
u = {
    |trigGate = 1 |
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var de = t * Demand.kr(t, 0, Dseq((1!1)++(0!15), inf));
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.05, 0.75, 6], [0, 0, -6]), de);
    var sig = MiBraids.ar(~toMidi.("D3") + [-24, 0, 3, 7,15, 14],
        timbre: 0.125*e, color: 0.5, model: 5;
    ).sum * dd.lag(0.025) * (1 - WhiteNoise.ar(e*1));
    sig = ~v.(sig, 4000 * e + 100) * 0.0125 * 0.5 ! 2;
}.play;
)


(
v.free;
v = {
    |trigGate = 1 |
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var de = t * Demand.kr(t, 0, Dseq((1!1)++(0!15), inf));
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.5, 3], [6, 0, -6, 'lin']), de);
    var sig = MiBraids.ar(~toMidi.("D3") + [3, 7, 15, 14, 24, 36],
        timbre: 0.5*e, color: 0.5, model: 8;
    ).sum;
    sig = ~v.(sig, 2000 * e + 100, 0, 5) * 0.025 ! 2;
}.play;
)