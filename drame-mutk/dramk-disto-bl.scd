(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur  * 1.5 * 0), {
    ~oneShotY.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~oneShotY = {
        | trigGate = 1 |
        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(100, 10000);
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.ar(~nT.tempo * 2 * 1) * trigGate;
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

        var disto;
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [1, 1, 2] * 0.5, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [0.25, 1, 1];
        sig = sig.sum;
        sig = sig.reverse * 0.25 + MiRings.ar(
            sig, pit: 36 + -24 + 2 + 24 + 12, struct: demm + 0.2, damp: 0.4, bright: 0.5, pos: 0.4, model: 4);
        // sig = VadimFilter.ar(sig, 400, 0, 5) * 8;
        // sig = VadimFilter.ar(sig, 1400, 0, 1) * 1;
        disto = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        disto = AnalogVintageDistortion.ar(
            input: disto,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
                disto = AnalogVintageDistortion.ar(
            input: disto,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        // sig = (sig) + (disto * 0.6);
        sig = sig * 4 + (VadimFilter.ar(disto, 7000, 0, 1) * 1);
        sig = VadimFilter.ar(sig, 9400, 0, 1) * 0.5;
    }.play(fadeTime: 0);
});
)