(
w.free;
w = {
    var t = Impulse.kr(2);
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!6);
    var e = EnvGen.kr(Env([0,1,0],[0.001, 10.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(
        ~toMidi.("E3") + [2,3,5,-5,12,14], timbre: 0.89, color: 0.91, model: 43) * 0.1;
    sig = sig[0] * 0.1 + (sig * d.lag(0.1));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    ~v.(sig, 2000, 0, 1) * 0.3 ! 2;
}.play;
)