
~nT = TempoClock.new(1.39 * 2 * 1.3).permanent_(true);
1.39 * 1.45
~nT.tempo
3.7790625

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

   ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo) * trigGate;
        var pat0 = [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 1, 1];
        var pat1 = [1, 0, 1, 0, 1, 0] ++ [1, 0, 1, 0, 0, 0];
        var pat2 = [0, 1, 0, 1, 0, 1] ++ [0, 1, 0, 1, 0, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var cur = [-2, -4];

        var e0 = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 3], cur), trig * block0);

        var e1 = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 3], cur), trig * block1);

        var e2 = EnvGen.kr(Env([0, 1, 0], [0.01, 1 * 3], cur), trig * block2);
        // var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var st = Demand.kr(trig, 0, Dseq(Dstutter(12, Drand((1..150)/10, inf)), inf));
        var sig = MiBraids.ar(
            pitch: st,
            timbre: 0.25,
            color: [0.8, 0.95, 0.99] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = sig * [e0 * 2, e1 * 2, e2].rotate(2);
        sig = VadimFilter.ar(sig, [4, 2, 3] * 1000 - 1000, 0, 5);
        // sig = sig.sum;
        sig = [sig[0] + sig[1], sig[2] + sig[1]];
        sig = VadimFilter.ar(sig, 6000, 0, 1) * 4;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 0.75;
    }.play(fadeTime: 0.01).register;
    x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = Demand.kr(t, 0, Dseq([1, 0, 0], inf));
        var d = Demand.kr(t * b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(t * b, 0, Dseq([200, 200].stutter(4), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t * b);
        var sc = Scale.phrygian.degrees.clipExtend(4);
        var n = Demand.kr(t * b, 0, Dseq(sc.stutter(4), inf));
        var sig = MiBraids.ar(
            pitch: 20 + n,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2 * e;
        var ramp = Line.kr(0, 2, 60 * 10);
    sig = sig.sum;
        // sig.size.poll;
    sig = (Decimator.ar(sig, 1000, 4) * 0.4);
        sig = VadimFilter.ar(sig, d2 + (6000 * ramp), 0.25, 1) * 8!2;
        sig = sig * (1 - (ramp * 0.5));
    }.play(fadeTime: 0);
});
)

Scale.phrygian.degrees.clipExtend(6)