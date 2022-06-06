(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.kr(~nT.tempo * 4) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4 * 1) * trigGate;
        // var trig = In.kr(~clickBus, 1) * trigGate;
        // var trig2 = In.kr(~clickBus, 1) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.kr(trig2, 0, Dseq([3176704], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 0, 1, 0, 0, 0].wrapExtend(24) ++ [1, 0, 1, 0, 1, 0, 1, 0].wrapExtend(8);
        var pat1 = [1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.kr(trig, 0, Dseq([0.1, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [1, 1, 2] * 0.5, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [0.25, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.05 + (MiRings.ar(
            sig, pit: 36 + -12, struct: demm + 0.8, damp: 0.25, bright: 0.3, pos: 0, model: 0) * 6) * 1;
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
        var trig = Impulse.kr(~nT.tempo * 4) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4 * 1) * trigGate;
        // var trig = In.kr(~clickBus, 1) * trigGate;
        // var trig2 = In.kr(~clickBus, 1) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.kr(trig2, 0, Dseq([3176704], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 0, 1, 0, 0, 0].wrapExtend(24) ++ [1, 0, 1, 0, 1, 0, 1, 0].wrapExtend(8);
        var pat1 = [1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.kr(trig, 0, Dseq([0.1, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [1, 1, 2] * 0.5, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [0.25, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.05 + (MiRings.ar(
            sig, pit: 36 + -12, struct: demm + 0.8, damp: 0.25, bright: 0.3, pos: 0.5, model: 0) * 6) * 1;
    }.play(fadeTime: 0);
});
)




// --------------------------------------------------------------------------------------
// Pizzi vers la caverne
// --------------------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur  * 1.5 * 0), {
    ~oneShotX.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~oneShotX = {
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
            sig, pit: 36 + -24, struct: demm + 0.2, damp: 0.6, model: 4);
        sig = VadimFilter.ar(sig, 1000, 0, 5) * 8;
    }.play(fadeTime: 0);
});
)


(
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShotX.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~k.set(\trigGate, 0, \relGate, 1);
)