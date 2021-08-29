(
~stopAll = {
    if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~drums.stop;
    if(~rimz.isPlaying, {~rimz.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    [~lead, ~lead2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
    [~billes6, ~billes67].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});
    ~granulator.set(\trigGate, 0);
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~l.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~m.set(\trigGate, 0, \gate, 0, \fadeTime, 5);

    if(~crushedNoiseAw.isPlaying, {~crushedNoiseAw.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

};
)

~stopAll.();

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~stopAll.();
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 2 * 1;
    }.play;
});
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~l.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~l = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 3) * trigGate;
        var block = Demand.kr(t, 0, Dseq([1, 0, 1].rotate(0), inf));
        // var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        // var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.6,
            model: 34,
            trig: t * block,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 0.5 * 1;
    }.play;
});
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0), {

    if(~crushedNoiseAw.isPlaying, {~crushedNoiseAw.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoiseAw = {
        | trigGate = 1 |
        var trig, sig, env, block, decay, timbre, delrd, note, r, n;
        trig = Impulse.kr(~nT.tempo * 0.5);
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo * 0.25).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: 12 + Demand.kr(trig, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 1,
            color: [0.8, 0.95],
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * [env, 1 - env];
        sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig!2 * 0.125 * 6 * 1;
    }.play(fadeTime: 0.05).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~m.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~m = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 0.5 * 3) * trigGate;
        var sig;
        t = t * Demand.kr(t, 0, Dseq([1, 1, 1, 0].stutter(6), inf));
        // var block = Demand.kr(t, 0, Dseq([1, 0, 1].rotate(0), inf));
        // var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        // var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        sig = MiBraids.ar(
            pitch: 24 + 12 + 0 + -12 + [0, 0.1] + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.5,
            color: 0.5,
            model: 34,
            trig: t,
            resamp: [2, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: Demand.kr(t, 0, Dseq([0, 0.5].stutter(6), inf))
        );
        // sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 0.5 * 2;
    }.play;
});
)

(
if(~crushedNoiseAw.isPlaying, {~crushedNoiseAw.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~m.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~l.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
)