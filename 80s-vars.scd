~nT.tempo = 0.5;

(
y.free;
y = {
    | trigGate = 1 |
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [ 1, 1, 1, 1, 1, 1, 0, 1,
          0, 1, 0, 1, 0, 0, 0, 0 ], inf));
    var d = Demand.kr(b, 0, Dseq(
        [ 0, 5, 7, 8, 7, 5, -4,  3,  0 ] ++
        [ 0, 5, 7, 8, 7, 5, -4, -5, -7 ], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.1, 3+dd], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E3") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.75+a, model: 37
    ) * td[1].lag(0.1);
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 4000 * e + 10);
    sig = Splay.ar(sig, 0.75);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = sig * [1, 1] * 5 * td[1].lag(0.1);
}.play;
)


(
y.free;
y = {
    | trigGate = 1 |
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [ 1, 1, 1, 1, 1, 1, 0, 1,
          0, 1, 0, 1, 0, 0, 0, 0 ], inf));
    var d = Demand.kr(b, 0, Dseq(
        [ 0, 5, 7, 8, 7, 5, -4,  3,  0 ] ++
        [ 0, 5, 7, 8, 7, 5, -4, -5, -7 ], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.05, 3], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E3") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 4000 * e + 10);
    sig = Splay.ar(sig, 0.75);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = sig * [0.25, 1] * 2;
}.play;
)


(
y.free;
y = {
    | trigGate = 1 |
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [ 1, 1, 1, 1, 1, 1, 0, 1,
          0, 1, 0, 1, 0, 0, 0, 0 ], inf));
    var d = Demand.kr(b, 0, Dseq(
        [ 0, 5, 7, 8, 7, 5, -4,  3,  0 ] ++
        [ 0, 5, 7, 8, 7, 5, -4, -5, -7 ], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.05, 3], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E6") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 4
    )* td[1].lag(0.6);
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 4000 * (e) + 10, 0, 5);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = sig * td[1].lag(0.6);
}.play;
)