(
x.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
x = {
    | trigGate = 1 |
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [ 1 ], inf));
    // var d = Demand.kr(b, 0, Dseq([0, 5, 7, 8, 7, 5, -4, 1, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        // [ 0, 0, 0, 0, 0, 7, 8, 7 ].stutter(2) ++
        [ 0, 0, 0, 0, 0, 2, 3, 2 ].stutter(2)
        , inf));
    var d2 = Demand.kr(t, 0, Dseq([0, 1], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.05, 1], ['lin', 'exp']), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A2") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 2000 * e + 100);
    sig = Splay.ar(sig, 0.5);
    sig = ~v.(CombC.ar(sig*Line.kr(0,1,0.1), 1, 0.125, 3), 1000 + (d2.lag(1)*1000));
    sig = sig * td[1].lag(0.5);
}.play;
)



(
x.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
x = {
    | trigGate = 1 |
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [ 1 ], inf));
    // var d = Demand.kr(b, 0, Dseq([0, 5, 7, 8, 7, 5, -4, 1, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        // [ 0, 0, 0, 0, 0, 7, 8, 7 ].stutter(2) ++
        [ 0, 0, 0, 0, 0, 2, 3, 2 ].stutter(2)
        , inf));
    var d2 = Demand.kr(t, 0, Dseq([0, 1], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.05, 1], ['lin', 'exp']), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A2") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 4000 * e + 100);
    sig = Splay.ar(sig, 0.5);
    sig = ~v.(CombC.ar(sig*Line.kr(0,1,0.1), 1, 0.125, 3), 1000 + (d2.lag(1)*2000));
    sig = sig * td[1].lag(0.5);
}.play;
)