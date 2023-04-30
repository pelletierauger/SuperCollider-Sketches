(
e.free;
e = {
    |stu = 1|
    var t = Impulse.kr(20);
    var t2 = Impulse.kr(0.1);
    var highNote = Demand.kr(t2, 0, Dseq([14, 15], inf));
    var midNote = Demand.kr(t, 0, Drand([10, 12], inf));
    var chord = [3,-5,midNote,highNote, 19, 24];
    var d = Demand.kr(t, 0,Dstutter(stu,Dwrand([0, 1], [0.3, 0.7], inf))!(chord.size));
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E4") - 7 + chord,
        timbre: 0.92, color: 0.45, model: 5,
        resamp: 2, decim: 3, bits: 6, ws: 1) * 0.1;
    sig = sig[0] * 0.01 + (sig * d.lag(0.05));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciproc al).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 100, 0, 5);
    ~v.(sig, 4000 * e + 1400, 0, 1) * 0.4 ! 2;
}.play;
)
s.sampleRate
(
e.free;
e = {
    |stu = 1|
    var t = Impulse.kr(20);
    var t2 = Impulse.kr(0.1);
    var ddd = Demand.kr(t, 0, Drand([-1, 1], inf)).lag(0.05);
    var highNote = Demand.kr(t2, 0, Dseq([14, 15], inf));
    var midNote = Demand.kr(t, 0, Drand([10, 12], inf));
    var chord = [3,-5,midNote,highNote, 19, 24];
    var d = Demand.kr(t, 0,Dstutter(stu,Dwrand([0, 1], [0.3, 0.7], inf))!(chord.size));
    var e = EnvGen.kr(Env([0,1,0],[0.001, 1.reciprocal], [2, -8]), t);
    var sig = MiBraids.ar(~toMidi.("E4") + chord,
        timbre: 0.92, color: 0.45, model: 5,
        resamp: 2, decim: 3, bits: 6, ws: 1) * 0.1;
    sig = sig[0] * 0.01 + (sig * d.lag(0.05));
    sig = sig.sum;
    // sig = sig + (DelayN.ar(sig, 1, [10, 20].reciprocal).sum * 0.5);
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    // d.size.poll;
    sig = ~v.(sig, 100, 0, 5);
    sig = ~v.(sig, 4000 * e + 1400, 0, 1);
    Balance2.ar(sig, sig, ddd * 0.5);
}.play;
)




(
e.free;
e = {
    var t = Impulse.kr(20);
    var chord = [2,3,5,-5,12,14];
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
    sig = ~v.(sig, 4000 * e + 1400, 0, 1) * 0.25;
    Balance2.ar(sig, sig, SinOsc.ar(0.5) * 0.5) * 6 ;
}.play;
)