(
e.free;
e = {
    var t = Impulse.kr(20);
    var chord = [2,3,5,-5,12,14];
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!(chord.size));
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E5") + chord,
        timbre: 0.94, color: 0.5, model: 5,
        resamp: 0, decim: 2, bits: 2, ws: 0.1) * 0.1;
    sig = sig[0] * 0.1 + (sig * d.lag(0.05));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 2100, 0, 5);
    ~v.(sig, 7000 * e + 1400, 0, 1) * 1 ! 2;
}.play;
)



(
e.free;
e = {
    var t = Impulse.kr(2);
    var chord = [2,3,5,-5,12,14];
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!(chord.size));
    var e = EnvGen.kr(Env([0,1,0],[0.01, 5.reciprocal], [0, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E4") + chord,
        timbre: 0.94, color: 0.5, model: 1,
        resamp: 2, decim: 12, bits: 2, ws: 0.1) * 0.1;
    sig = sig[0] * 0.1 + (sig * d.lag(0.05));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 2100, 0, 5);
    ~v.(sig, 2400, 0, 1) * 2 ! 2;
}.play;
)
