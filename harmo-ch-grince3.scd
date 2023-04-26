(
g.free;
g = {
    var t = Impulse.kr(5);
    var t2 = Impulse.kr(0.1);
    var bass = Demand.kr(t2, 0, Dseq([-12, -16] - 12, inf));
    var chord = [bass, 2,3,5,-5,12,14];
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!(chord.size));
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E5") + chord,
        timbre: 0.72, color: 0.45, model: 6,
        resamp: 0, decim: 12, bits: 6, ws: 1) * 0.1;
    sig = sig[0] * 0.1 + (sig * d.lag(0.05) * 0.25);
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 500, 0, 5);
    ~v.(sig, 2000 * e + 1400, 0, 1) * 1 ! 2;
}.play;
)


(
w.free;
w = {
    var t = Impulse.kr(20);
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!6);
    var e = EnvGen.kr(Env([0,1,0],[0.001, 10.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E4") + [2,3,5,-5,12,14], timbre: 0.2, color: 0.45, model: 14) * 0.1;
    sig = sig[0] * 0.1 + (sig * d);
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    ~v.(sig, 2000, 0, 5) * 0.5 ! 2 * [1, 0.1];
}.play;

z.free;
z = {
    var t = Impulse.kr(20);
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!6);
    var e = EnvGen.kr(Env([0,1,0],[0.001, 10.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E3") + [2,3,5,-5,12,14], timbre: 0.2, color: 0.45, model: 14) * 0.1;
    sig = sig[0] * 0.1 + (sig * d);
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    ~v.(sig, 2000, 0, 5) * 0.5 ! 2 * [1, 0.1].reverse;
}.play;
)