s.mute;
s.unmute;
~nT.tempo
~nT.tempo = 0.5;

(
x.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
x = {
    | trigGate = 1 |
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [ 1, 1, 1, 1,
          1, 1, 0, 1,
          0, 1, 0, 1 ], inf));
    // var d = Demand.kr(b, 0, Dseq([0, 5, 7, 8, 7, 5, -4, 1, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        [0, 5, 7, 8, 7, 5,  0, 1, 0].wrapExtend(18) ++
        [0, 5, 7, 8, 7, 5, -2, 1, 0].wrapExtend(18)
        , inf));
    var d2 = Demand.kr(t, 0, Dseq([0, 1], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.05, 1], ['lin', 'exp']), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 8
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 2000 * e + 100);
    sig = Splay.ar(sig, 0.5);
    sig = ~v.(CombC.ar(sig*Line.kr(0,1,0.1), 1, 0.125, 3), 1000 + (d2.lag(1)*1000));
    sig = sig * td[1].lag(0.5);
}.play;
)


(
w.free;
w = {
    var t = ~tks.(1)[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [ 1, 1, 1, 1,
          1, 1, 0, 1,
          0, 1, 0, 1 ], inf));
    var d = Demand.kr(b, 0, Dseq([0, 5, 7, 8, 7, 5, -4, 1, 0], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.005, 1], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E2") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 6000 * e + 500);
    sig = Splay.ar(sig, 0.5);
    sig = sig;
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
        [ 0, 5, 7, 8, 7, 5, -4,  1,  0 ] ++
        [ 0, 5, 7, 8, 7, 5, -4, -5, -7 ], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.5, 3+dd], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E6") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 4000 * e + 10);
    sig = Splay.ar(sig, 0.75);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig = sig * [0.25, 1] * 5 * td[1].lag(0.5);
}.play;
)


(
j.free;
j = {
    var t = Impulse.kr(0.25);
    var d = Demand.kr(t, 0, Dseq([0, -2, -4, -5], inf));
    var pitch = ~toMidi.("A1") + d;
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.001]));
    var sig = MiBraids.ar(pitch, 0.2, ~lfo.([3,3.1],0.5,0.55), model: 14);
    ~v.(sig,500) * 1 * Line.kr(0,1,0.125) * safeEnv;
}.play;
)



(
j.free;
j = {
    var t = Impulse.kr(2);
    var o = Demand.kr(t, 0, Dseq([0, 1]));
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], inf));
    var d = Demand.kr(b, 0, Dseq([0, -2, -4, -5], inf));
    var pitch = ~toMidi.("A1") + d;
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.001]));
    var sig = MiBraids.ar(pitch, 0.2, ~lfo.([3,3.1],0.5,0.55), model: 14);
    ~v.(sig,500) * 1 * Line.kr(0,1,0.125) * safeEnv * o.lag(0.4);
}.play;
x.free;
x = {
    var t = Impulse.kr(2);
    var b = t * Demand.kr(t, 0, Dseq(
        [
            1, 1, 1, 1, 1, 1, 0, 1,
            0, 1, 0, 1], inf));
    var d = Demand.kr(b, 0, Dseq([0, 5, 7, 8, 7, 5, -4, 1, 0], inf));
    var d2 = Demand.kr(t, 0, Dseq([0, 1], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.05, 1], ['lin', 'exp']), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 8
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 2000 * e + 100);
    sig = Splay.ar(sig, 0.5);
    sig = ~v.(CombC.ar(sig*Line.kr(0,1,0.1), 1, 0.125, 3), 1000 + (d2.lag(1)*1000));
    sig = sig;
}.play;
)