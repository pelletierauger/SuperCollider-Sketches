


(
c.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
c = {
    |trigGate = 1|
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,
         0, 1, 0, 1, 0, 0, 0, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        [0, 5, 7, 8, 7, 5, 7, 10, 8, 7, 15-12, 19-12, 14-12] ++
        [0, 5, 7, 8, 7, 5, 7, 10, 8, 7, 15-12, 19-12, 17-12], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.5, 3 + dd], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A3") + d + ~lfo.(8, 0, 0.5) - (e*0.25),
        timbre: e, color: 0.25, model: 0
    );
    // sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 1500 * e * ~lfo.(8, 0.75, 1) + 10);
    // sig = Splay.ar(sig, 1);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = ~v.(sig, 100, 0, 5);
    sig = sig * Line.kr(0,1,0.6) * 0.5 * td[1].lag(0.5) * 1 ! 2;
}.play;
)


(
z.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
z = {
    |trigGate = 1|
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,
         0, 1, 0, 1, 0, 0, 0, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        // 0, 2, 3, 5, 3, 5
        [0, 2, 3, 5, 3, 5, 7, 10, 8, 7, 15-12, 19-12, 14-12] ++
        [0, 2, 3, 5, 3, 5, 7, 10, 8, 7, 15-12, 19-12, 17-12], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.1, 1, 0.001], [0.5, 3 + dd], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 20 //model: 19
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 2500 * e * ~lfo.(8, 0.75, 1) + 10);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = sig * Line.kr(0,1,0.6) * 2 * td[1].lag(0.5);
}.play;
)

// Le lyrique plus bas, viré dans l'oreille gauche, et moins fort.
(
z.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
z = {
    |trigGate = 1|
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,
         0, 1, 0, 1, 0, 0, 0, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        // 0, 2, 3, 5, 3, 5
        [0, 2, 3, 5, 3, 5, 7, 10, 8, 7, 15-12, 19-12, 14-12] ++
        [0, 2, 3, 5, 3, 5, 7, 10, 8, 7, 15-12, 19-12, 17-12], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.1, 1, 0.001], [0.5, 3 + dd], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 20 //model: 19
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 2500 * e * ~lfo.(8, 0.75, 1) + 10);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = sig.reverse * Line.kr(0,1,0.6) * 1 * td[1].lag(0.5);
}.play;
)


(
u.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
z.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
x.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
z = {
    |trigGate = 1|
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 1], inf));
    var d = Demand.kr(b, 0, Dseq(
        [ 0, 3, 7, 2 ] ++
        [ 0, 3, 7, 5 ] ++
        [ 0, 3, 7, 5 ] ++
        [ 2, 7, 8, 7 ], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.1, 1, 0.001], [0.5, 3], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A5") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 20 //model: 19
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 1500 * e * ~lfo.(8, 0.75, 1) + 10);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = ~v.(sig,500,0,5);
    sig = sig * Line.kr(0,1,0.6) * 4 * td[1].lag(0.5);
}.play;
)