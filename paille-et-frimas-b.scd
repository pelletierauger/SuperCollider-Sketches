~nT = TempoClock.new(1.39 * 2 * 1.3).permanent_(true);


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var pat1 = [1, 0, 1, 0, 1, 0] ++ [1, 0, 1, 0, 1, 0];
        var pat2 = [1, 0, 1, 0, 1, 0] ++ [1, 1, 1, 1, 1, 1];

        var block1 = Demand.kr(t, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(t, 0, Dseq(pat2, inf));
        var d = Demand.kr(t * block1, 0, Dseq([0.5, 0.15, 0.15].rotate(0), inf));
        var dd = Demand.kr(t * block1, 0, Dseq([200, 500].stutter(3), inf));
        var dddd = Demand.kr(t * block1, 0, Dseq([9000, 12000].stutter(3), inf));
        var ddd = Demand.kr(t * block2, 0, Dseq(
            (0!3) ++ ((1..6) * 100), inf
        ));
        var sig = MiBraids.ar(
            pitch: [45, 45, 46],
            timbre: 0.65,
            color: d,
            model: 34,
            trig: t * [block2],
            resamp: [0, 2, 2],
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2;
        // ddd.poll;
        VadimFilter.ar(sig[0], dd, 0.25, 1) * 0.5!2 +
        (VadimFilter.ar([sig[1], sig[2]] * Line.kr(0, 1, 0.05), dddd, 0, 5) * 1.2);
    }.play(fadeTime: 0);
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq([0, 0, 0, 1, 0, 0], inf));
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([500, 1000].stutter(4), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [0, -8]), b);
        var sig = MiBraids.ar(
            pitch: 0,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 4) * 0.4);
        sig = VadimFilter.ar(sig, 100, 0, 5);
        VadimFilter.ar(sig, 500, 0.25, 1) * 12;
    }.play(fadeTime: 0);
});
)


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
        var cur = [-2, -6];

        var e0 = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 3], cur), trig * block0);

        var e1 = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5 * 3], cur), trig * block1);

        var e2 = EnvGen.kr(Env([0, 1, 0], [0.01, 1 * 3], cur), trig * block2);
        // var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiBraids.ar(
            pitch: 0,
            timbre: 0.25,
            color: [0.8, 0.95, 0.99] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = sig * [e0 * 2, e1 * 2, e2].rotate(2);
        sig = VadimFilter.ar(sig, [4, 2, 3] * 100 + 100, 0.25, 1);
        sig = VadimFilter.ar(sig, 50, 0, 5);
        // sig = sig.sum;
        sig = [sig[0], sig[2]];
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 16;
    }.play(fadeTime: 0.01).register;
});
)

(
y.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n;
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: [10, 0],
            timbre: 0.25,
            color: [0.95, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: [4, 3],
            ws: 0
        ) * [env * 0.5, 1 - env];
        sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig!2 * 1 * 2;
    }.play(fadeTime: 0.01).register;
});
)