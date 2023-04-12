~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);
~pizzi3 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/pizzi3.wav");
~c = TempoClock.new(0.5).permanent_(true);
~c.sched(0, {~c.beatsPerBar = 3});

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~oneShotW.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShotW = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2 * 1) * trigGate;
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
            sig, pit: 36 + -12, struct: demm + 0.8, damp: 0.25, bright: 0.3, pos: 0, model: 0) * 6) * 2;
    }.play(fadeTime: 0);
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur  * 1.5 * 0), {
    ~oneShotY.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
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
            sig, pit: 36 + -24 + 2 + 0, struct: demm + 0.3, damp: 0.7, bright: 0.5 ,pos: 0.002, model: 0);
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
        // sig = (sig) + (disto * 0.6);
        sig = sig * 0 + (VadimFilter.ar(disto, 7000, 0, 1) * 0.75);
        sig = VadimFilter.ar(sig, 9400, 0, 1) * 0.5;
    }.play(fadeTime: 0);
});
)





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
            sig, pit: 36 + -24 + 2 + 0, struct: demm + 0.2, damp: 0.7, bright: 0.5, pos: 0.6, model: 2);
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
        // sig = (sig) + (disto * 0.6);
        sig = sig * 0 + (VadimFilter.ar(disto, 7000, 0, 1) * 0.75);
        sig = VadimFilter.ar(sig, 9400, 0, 1) * 0.5;
    }.play(fadeTime: 0);
});
)




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
            sig, pit: 36 + -24 + 2 + 0, struct: demm + 0.2, damp: 0.7, bright: 0.5, pos: 0.6, model: 2);
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
        // sig = (sig) + (disto * 0.6);
        sig = sig * 0 + (VadimFilter.ar(disto, 7000, 0, 1) * 0.75);
        sig = VadimFilter.ar(sig, 9400, 0, 1) * 0.5;
    }.play(fadeTime: 0);
});
)







(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur  * 1.5 * 0), {
    ~oneShotY.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~oneShotY = {
        | trigGate = 1 |
        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
            sig, pit: 36 + -24 + 2 + 0, struct: demm + 0.2, damp: y, bright: 0.5, pos: x, model: 3);
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
        // sig = (sig) + (disto * 0.6);
        sig = sig * 16 + (VadimFilter.ar(disto, 7000, 0, 1) * 0.75);
        sig = VadimFilter.ar(sig, 9400, 0, 1) * 0.5;
    }.play(fadeTime: 0.02);
});
)
s.record;
s.stopRecording;
~recFolder.openOS


~oneShotY.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);



(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur  * 1.5 * 0), {
    ~oneShotY.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShotY = {
        | trigGate = 1 |
        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
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
            sig, pit: 36 + -24 + 2, struct: demm + 0, damp: y, bright: 0.5, pos: x, model: 4);
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
        // sig = (sig) + (disto * 0.6);
        sig = sig * 8 + (VadimFilter.ar(disto, 7000, 0, 1) * 0.25);
        sig = (sig * 0.125) + (VadimFilter.ar(sig, 1000, 0, 5) * 2);
        sig = VadimFilter.ar(sig, 9400, 0, 1) * 0.5;
                sig = AnalogPhaser.ar(
            sig * 0.5,
            SinOsc.ar(0.022),
            skew: SinOsc.kr(5.59),
            feedback: SinOsc.kr(0.005, 1pi).range(0.8,0.85),
            modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
            stages: 16
        ) * 2;
    }.play(fadeTime: 0);
});
)


(

    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 20.1);
    ~oneShotR.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShotW.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShotY.set(\trigGate, 0, \gate, 0, \fadeTime, 20.1);

    ~oneShotY2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
)