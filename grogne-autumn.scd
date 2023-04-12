(
    ~oneShotR.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShotR = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~grogne;
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2 * 1) * trigGate;
        // var trig = In.kr(~clickBus, 1) * trigGate;
        // var trig2 = In.kr(~clickBus, 1) * trigGate;
        var start0 = 3589088;
        var start1 = 2447488;
        var start2 = Demand.kr(trig2, 0, Dseq([3176704], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2] * 2;
        var pat1 = [1, 0, 0, 0, 1, 0, 0, 0];
        var pat0 = [1, 0, 0, 1, 0, 0, 1, 0];
        var pat2 = [0, 0, 1, 0];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.025;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, length - (atk * 1) * 0.5, atk] * 1, [2, -8]), blocks);
        var demm = Demand.kr(trig, 0, Dseq([0.1, 0.1].stutter(24), inf));
        var sig = BufRd.ar(1, buf, Phasor.ar(blocks, [1, 1, 1] * 0.5, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig ! 2 * env * [0.25, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.05 + (MiRings.ar(
            sig, pit: 36 + -12, struct: 0.2, damp: 0.5, bright: 0.1, pos: 0, model: 4) * 6) * 8;
    }.play(fadeTime: 0);
)