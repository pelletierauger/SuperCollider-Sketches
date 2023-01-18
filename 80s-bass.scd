~nT.tempo = 0.5;

(
b.free;
b = {
    var td = ~tks.(1);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        [-4, 1, 0] ++
        [-4, -5, -7], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 9], inf));
    var e = EnvGen.kr(Env([0.1, 1, 0.001], [0.5, 3 + dd], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E3") + d.lag(0.25) + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    ) * td[1].lag(0.5);
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 2500 * e + 10);
    sig = Splay.ar(sig, 1);
    sig = CombC.ar(sig, 1, 0.125, 1.5);
    sig = sig * Line.kr(0,1,0.6) * td[1].lag(0.5) * 0.25;
}.play;
)