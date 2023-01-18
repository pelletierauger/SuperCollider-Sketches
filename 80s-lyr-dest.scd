

(
e.free;
e = {
    var td = ~tks.(1);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [
            1, 1, 1, 1, 1, 1, 0, 1,
            0, 1, 0, 1, 0, 0, 0, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        [0, 2,3, 5, 3, 5, 12,10, 8] ++
        [0, 2,3, 5, 3, 5, 7,5, 3], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 6], inf));
    var e = EnvGen.kr(Env([0.1, 1, 0.001], [0.5, 3 + dd], 'exp'), b).lag(0.1);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("A3") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    );
    var sig2, sig3;
    var pn = {PinkNoise.ar()};
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 500 * e + 10);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig2 = MiWarps.ar(sig[0], pn*sig[0], 0.75, 0.75, algo: 1, timb: 0.4);
    sig3 = MiWarps.ar(sig[1], pn*sig[1], 0.75, 0.75, algo: 1, timb: 0.4);
    sig = [sig2[0], sig3[0]]*0.1 + (sig*0.1);
    sig = sig * Line.kr(0,1,0.6) * 1 * td[1].lag(0.5);
}.play;
)






(
e.set(\trigGate, 0, \gate, 1, \fadeTime, 20);
e = {
    | trigGate = 1 |
    var td = ~tks.(1, trigGate);
    var t = td[0];
    var b = t * Demand.kr(t, 0, Dseq(
        [
            1, 0], inf));
    var d = Demand.kr(b, 0, Dseq(
        [13, 12,10, 8] ++
        [7,5, 8, 15], inf));
    var dd = Demand.kr(b, 0, Dseq(
        [0, 0, 0, 0, 0, 0, 0, 0, 0], inf));
    var e = EnvGen.kr(Env([0.1, 1, 0.001], [0.5, 3 + dd], 'exp'), b).lag(0.1);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E4") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    );
    var sig2, sig3;
    var pn = {PinkNoise.ar()};
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 1500 * e + 10);
    sig = Splay.ar(sig, 0.5);
    sig = CombC.ar(sig, 1, 0.125, 2);
    sig2 = MiWarps.ar(sig[0], pn*sig[0], 0.75, 0.75, algo: 1, timb: 0.4);
    sig3 = MiWarps.ar(sig[1], pn*sig[1], 0.75, 0.75, algo: 1, timb: 0.4);
    sig = [sig2[0], sig3[0]]*0.1 + (sig*0.1);
    sig = sig * Line.kr(0,1,0.6) * 1 * td[1].lag(0.5);
    sig = ~v.(sig, 1000,0,5);
}.play;
)

