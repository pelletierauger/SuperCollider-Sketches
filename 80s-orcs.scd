(
a.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
a = {
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
    var sig = MiBraids.ar(~toMidi.("A4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.85-a, color: 0.5+a, model: 27 //model: 19
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 500 * e * ~lfo.(8, 0.75, 1) + 10);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = ~v.(sig,200,0,5);
    sig = sig * Line.kr(0,1,0.6) * 4 * td[1].lag(0.5);
}.play;
)

(
a.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
a = {
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
    var sig = MiBraids.ar(~toMidi.("A4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.85-a, color: 0.5+a, model: 20 //model: 19
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 500 * e * ~lfo.(8, 0.75, 1) + 10);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = ~v.(sig,200,0,5);
    sig = sig * Line.kr(0,1,0.6) * 8 * 4 * td[1].lag(0.5);
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
        [1, 0, 0 ,0], inf));
    var d = Demand.kr(b, 0, Dseq(
        [ 0, 3, 7, 2 ] ++
        [ 0, 3, 7, 5 ] ++
        [ 0, 3, 7, 5 ] ++
        [ 2, 7, 8, 7 ], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.1, 1, 0.001], [0.5, 8], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5, color: 0.5+(a*0.1), model: 27 //model: 19
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 500 * e * ~lfo.(8, 0.75, 1) + 10);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = ~v.(sig,200,0,5);
    sig = sig * Line.kr(0,1,0.6) * 8 * td[1].lag(0.5);
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
        [1, 0, 0 ,0].wrapExtend(4*7)++(0!4), inf));
    var d = Demand.kr(b, 0, Dseq(
        [ 0, 3, 7, 2 ] ++
        [ 0, 3, -5], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.1, 1, 0.001], [0.5, 8], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5, color: 0.5+(a*0.1), model: 27 //model: 19
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 500 * e * ~lfo.(8, 0.75, 1) + 10) + (~v.(sig,9000,0,5)*0);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = ~v.(sig,200,0,5);
    sig = sig * Line.kr(0,1,0.6) * 8 * td[1].lag(0.5);
}.play;
)



(
p.free;
p = {
    var f = ~toMidi.("A2");
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var sig = MiPlaits.ar(f + [0, 0.1], engine: 6, harm: 0.35, morph: 0.25);
    sig = [sig[0][0], sig[1][0]] * 0.2 * Line.kr(0,1,1);
    ~v.(sig, 2000)*2;
}.play;
)