(
e.free;
e = {
    var t = Impulse.kr(20);
    var t2 = Impulse.kr(0.1);
    var bass = Demand.kr(t2, 0, Dseq([-12, -16], inf));
    var chord = [bass, 2,3,5,-5,12,14];
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!(chord.size));
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E4") + chord,
        timbre: 0.92, color: 0.45, model: 5,
        resamp: 0, decim: 12, bits: 6, ws: 1) * 0.1;
    sig = sig[0] * 0.1 + (sig * d.lag(0.05));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 100, 0, 5);
    ~v.(sig, 4000 * e + 1400, 0, 1) * 1 ! 2 * [1, 0.25];
}.play;

g.free;
g = {
    var t = Impulse.kr(20);
    var t2 = Impulse.kr(0.1);
    var bass = Demand.kr(t2, 0, Dseq([-12, -16] - 12, inf));
    var chord = [bass, 2,3,5,-5,12,14];
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!(chord.size));
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E4") + chord,
        timbre: 0.72, color: 0.45, model: 5,
        resamp: 2, decim: 12, bits: 6, ws: 1) * 0.1;
    sig = sig[0] * 0.1 + (sig * d.lag(0.05) * 0.5);
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 10, 0, 5);
    ~v.(sig, 9000 * e + 1400, 0, 1) * 1 ! 2 * [0.25, 1];
}.play;
)