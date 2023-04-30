(
e.free;
e = {
    var t = Impulse.kr(0.2*4);
    var t2 = Impulse.kr(0.2);
    var lowNote = Demand.kr(t2, 0, Dseq([2, 0, -3, -2, -9, -7, -10, -14], inf));
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!6);
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var bass;
    var sig = MiBraids.ar(~toMidi.("E4") + [lowNote.lag(0.11),3,5,-5,12,14],
        timbre: 0.2, color: 0.45, model: 4) * 0.1;
    bass = sig[0];
    sig = sig[0] * 0.1 + (sig * d.lag(0.5));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    ~v.(sig, 4000 * e.lag(0.05) + 1400, 0, 5) * 8 + (bass * 2) ! 2;
}.play;
)


(
e.free;
e = {
    var t = Impulse.kr(0.2*4);
    var t2 = Impulse.kr(0.2);
    var lowNote = Demand.kr(t2, 0, Dseq([2, 0, -3, -2, -9, -7, -10, -14], inf));
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!6);
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var bass;
    var sig = MiBraids.ar(~toMidi.("E4") + [lowNote.lag(0.11),3,5,-5,12,14],
        timbre: 0.1, color: 0.25, model: 16) * 0.1;
    bass = sig[0];
    sig = sig[0] * 0.1 + (sig * d.lag(0.5));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 4000 * e.lag(0.05) + 1400, 0, 5) * 8 + (bass * 2) ! 2;
    ~v.(sig, 2000);
}.play;
)



(
e.free;
e = {
    var t = Impulse.kr(0.2*4);
    var t2 = Impulse.kr(0.2);
    var lowNote = Demand.kr(t2, 0, Dseq([2, 0, -3, -2, -9, -7, -10, -14], inf));
    var d = Demand.kr(t, 0, Dwrand([0, 1], [0.7, 0.3], inf)!6);
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var bass;
    var sig = MiBraids.ar(~toMidi.("E4") + [2,3,5,12,14],
        timbre: 0.1, color: 0.25, model: 16) * 0.1;
    bass = sig[0];
    sig = sig[0] * 0.1 + (sig * d.lag(1));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 4000 * e.lag(0.05) + 1400, 0, 5) * 8 + (bass * 2) ! 2;
    ~v.(sig, 3000);
}.play;
)