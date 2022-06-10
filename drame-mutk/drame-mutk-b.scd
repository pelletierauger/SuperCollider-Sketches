~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);
~pizzi3 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/pizzi3.wav");
~c = TempoClock.new(0.5).permanent_(true);
~c.sched(0, {~c.beatsPerBar = 3});

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
        var trig2 = Impulse.ar(~nT.tempo * 4) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.ar(trig2, 0, Dseq([3176704], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 0, 1, 0, 0, 0];
        var pat1 = [1, 0, 0, 1, 0, 0, 1, 0];
        var pat2 = [1, 0, 1, 0, 1, 1, 1, 1];
        var block0 = trig * Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.ar(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.ar(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.ar(trig, 0, Dseq([0.1, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [0.5, 1, 2] * 1, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [1, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.25 + MiRings.ar(
            sig, pit: 36 + -12, struct: demm - 0.1, damp: 0.2, model: 1) * 2;
    }.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.0, {
    ~k2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k2 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var d = Impulse.kr(~nT.tempo * 0.5 * 4) * trigGate;
        // var t = d * Demand.kr(d, 0, Dseq([1, 0, 1, 1, 0, 1, 0, 0], inf));
        var t = d * Demand.kr(d, 0, Dseq([1, 0, 0, 1, 0, 0, 0, 0], inf));
        // var it = In.kr(~clickBus, 1) * trigGate;
        // var t2 = Demand.kr(it, 0, Dseq([0, 1]));
        // var t = it * Demand.kr(it, 0, Dseq([1, 0, 0, 0], inf)) * t2;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.75,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: Demand.kr(t, 0, floor(Dwhite(0, 32, inf)), inf),
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        // sig = LPF.ar(sig, 4400);
        sig * 2 * 1.5;
    }.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~k.set(\trigGate, 0, \relGate, 1);
    ~k = {
        | trigGate = 1, relGate = 0 |
        // var envGate = EnvGate.new();
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 3], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var t = Impulse.kr(~nT.tempo * 1) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.5,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: Demand.kr(t, 0, floor(Dwhite(0, 32, inf)), inf),
            decim: 12,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            bits: 2,
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = VadimFilter.ar(sig, 7400, 0, 1) + (VadimFilter.ar(sig, 7400, 0, 5) * 10);
        sig * 2 * 1 * amp;
    }.play(fadeTime: 0);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
        var trig2 = Impulse.ar(~nT.tempo * 4 * 1) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.ar(trig2, 0, Dseq([3176704], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 0, 1, 0, 0, 0].wrapExtend(24) ++ [1, 0, 1, 0, 1, 0, 1, 0].wrapExtend(8);
        var pat1 = [1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 1, 1, 1];
        var block0 = trig * Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.ar(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.ar(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.ar(trig, 0, Dseq([0.1, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [1, 1, 2] * 1, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [0.25, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.25 + MiRings.ar(
            sig, pit: 36 + -12, struct: demm - 0.1, damp: 0.2, model: 3) * 2;
    }.play(fadeTime: 0);
});
)