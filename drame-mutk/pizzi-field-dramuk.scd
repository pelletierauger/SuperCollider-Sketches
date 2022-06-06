~pizzi3 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/pizzi3.wav");
~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);
~nT = TempoClock.new(1.39 * 1.25 * 1.075 * 0.75).permanent_(true);
~c = TempoClock.new(0.5).permanent_(true);
~c.sched(0, {~c.beatsPerBar = 3});
~c.beatsPerBar

(
~c.schedAbs(~c.nextBar, {
    ~bass.free;
    ~bass = {
        var tonic, dem2, sig, sig2, start, buf, end, env, trig, dif, length;
        buf = ~pizzi3;
        trig = Impulse.ar(~c.tempo / 6);
        env = EnvGen.ar(Env.new([0.0, 1, 0.001], [0.7 * 1, 12 * 2], [2, -8]), trig);
        start = 15000;
        tonic = ~toMidi.("Gb1") - 1;
        dem2 = tonic + Demand.ar(trig, 0, Dseq([7, 0].stutter(1), inf));
        length = floor(BufSampleRate.ir(buf) / dem2.midicps);
        end = start + length;
        dif = 0;
        start = 297696;
        end = start + length;
        // end.poll;
        sig = BufRd.ar(2, buf, Phasor.ar(0, 1, start, end, start), interpolation: 0);
        // sig2 = BufRd.ar(2, buf, Phasor.ar(0, 1, start - dif, end - dif - 2, start), interpolation: 0);
        // sig = sig + sig2 * env;
        sig = sig * 1 * env;
        sig = sig * 2 + MiRings.ar(sig, pit: dem2, model: 0) * 0.4;
        // sig = MiBraids.ar(dem2) * 0.1!2;
        // sig = VadimFilter.ar(sig * 0.5, 19500 * env + 100, 0, 1);
        // sig * 3.5;
    }.play(fadeTime: 0);
});
)

(
~nT.schedAbs(~nT.nextBar + 0.5 - 0.12, {
    ~oneShot.free;
    ~oneShot = {
        var rate = 1, dem2, demm, sig, sig2, start, buf, atk, end, env, trig, dif, length;
        buf = ~pizzi3;
        start = 2447488;
        end = 2506240 - 5000;
        start = 3176704; end = 3245568;
        length = (end - start) * [0.125, 0.75, 0.5] * 1 / BufSampleRate.ir(buf);
        atk = 0.001;
        trig = Impulse.ar(1 / length);
        env = EnvGen.ar(Env.new([0, 1, 0.5, 0], [atk, length - (atk * 2), atk], [2, -8]), trig);
        sig = BufRd.ar(2, buf, Phasor.ar(trig, rate, start, end, start), interpolation: 0);
        sig = sig * env * [0.5, 1, 1.5];
        sig = sig.sum;
        sig = VadimFilter.ar(sig, 100, 0, 5);
        demm = Demand.ar(trig, 0, Dseq([0.2, 0.1].stutter(32), inf));
        sig = MiRings.ar(sig, pit: 36 - 12, struct: demm, model: 4) * 0.5;
    }.play(fadeTime: 0);
});
)




(
~c.schedAbs(~c.nextBar, {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~c.tempo * 6) * trigGate;
        var trig2 = Impulse.ar(~c.tempo * 6 * 2) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.ar(trig2, 0, Dseq([3176704], inf));
        var starts = [start0, start1, start2];
        // var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 1, 0, 0];
        var pat1 = [1, 0, 1, 0, 1, 0];
        var pat2 = [1];
        var block0 = trig * Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.ar(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.ar(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.ar(trig, 0, Dseq([0.2, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [0.5, 1, 1], starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [1, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig + MiRings.ar(sig, pit: 36 + -0, struct: demm, model: 1) * 0.5;
    }.play(fadeTime: 0);
});
)


(
~c.schedAbs(~c.nextBar, {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~c.tempo * 6) * trigGate;
        var trig2 = Impulse.ar(~c.tempo * 6 * 2) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.ar(trig2, 0, Dseq([3176704], inf));
        var starts = [start0, start1, start2];
        // var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 1, 0, 0];
        var pat1 = [1, 0, 1, 0, 1, 0];
        var pat2 = [1];
        var block0 = trig * Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.ar(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.ar(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.ar(trig, 0, Dseq([0.2, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [0.5, 1, 1], starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [1, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig * 0.5 + MiRings.ar(sig, pit: 36 + -12, struct: demm, model: 0) * 0.5;
    }.play(fadeTime: 0);
});
)



(
~c.schedAbs(~c.nextBar, {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~c.tempo * 6) * trigGate;
        var trig2 = Impulse.ar(~c.tempo * 6 * 2) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.ar(trig2, 0, Dseq([3176704], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 1, 0, 0];
        var pat1 = [1, 0, 1, 0, 1, 0];
        var pat2 = [1];
        var block0 = trig * Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.ar(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.ar(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.ar(trig, 0, Dseq([0.2, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [0.5, 1, 1] * 0.5, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [1, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.125 + MiRings.ar(
            sig, pit: 36 + -12, struct: demm, damp: 0.2, model: 1) * 0.5;
    }.play(fadeTime: 0);
});
)


~c = TempoClock.new(0.45).permanent_(true);

(
~c.schedAbs(~c.nextBar, {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~c.tempo * 6) * trigGate;
        var trig2 = Impulse.ar(~c.tempo * 6 * 2) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.ar(trig2, 0, Dseq([3176704], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 1, 0, 0];
        var pat1 = [1, 0, 1, 0, 1, 0];
        var pat2 = [1, 0, 1, 0, 1, 1];
        var block0 = trig * Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.ar(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.ar(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.ar(trig, 0, Dseq([0.2, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [0.5, 1, 2] * 0.5, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [1, 1, 2];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.125 + MiRings.ar(
            sig, pit: 36 + -12, struct: demm, damp: 0.2, model: 1) * 0.5;
    }.play(fadeTime: 0);
});
)

(
~c.schedAbs(~c.nextBar, {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~c.tempo * 6) * trigGate;
        var trig2 = Impulse.ar(~c.tempo * 6 * 2) * trigGate;
        var start0 = 3689088;
        var start1 = 2447488;
        var start2 = Demand.ar(trig2, 0, Dseq([3176704], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 1, 0, 0];
        var pat1 = [1, 0, 1, 0, 1, 0];
        var pat2 = [1, 0, 1, 0, 1, 1];
        var block0 = trig * Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.ar(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.ar(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.ar(trig, 0, Dseq([0.2, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [0.5, 1, 2] * 0.5, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [1, 1, 2];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.125 + MiRings.ar(
            sig, pit: 36 + -12, struct: demm, damp: 0.2, model: 0) * 0.5;
    }.play(fadeTime: 0);
});
)

// --------------------------------------------------------------------------------------
// Pizzi confiant, festif, doucement heavy.
// --------------------------------------------------------------------------------------

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


// --------------------------------------------------------------------------------------
// Pizzi vers la caverne
// --------------------------------------------------------------------------------------

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
            sig, pit: 36 + -24, struct: demm + 0.2, damp: 0.6, model: 4) * 1;
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
        var sig = BufRd.ar(2, buf, Phasor.ar(blocks, [1, 1, 2] * 1, starts, starts + 1e5, starts), interpolation: 0);
        sig = sig * env * [0.25, 1, 1];
        sig = sig.sum;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.05 + (MiRings.ar(
            sig, pit: 36 + -12, struct: demm + 0.8, damp: 0.25, pos: 0, model: 5) * 6) * 1;
    }.play(fadeTime: 0);
});
)


~clickBus = Bus.control(s, 1);


~hearClick = {K2A.ar(In.kr(~clickBus, 1)) * 0.5!2}.play;
~hearClick.free;

(
~clicker = Task {
    {
        {
            var rise = [100, 500, 1000].choose;
            var dec = [15, 5, 1].choose;
            var env = EnvGen.kr(Env([0, 1, 0], [0.001, ~cT.beatDur]), doneAction: 2);
            var t = Impulse.kr(0.001);
            Out.kr(~clickBus, t);
        }.play;
        [1].choose.wait;
    }.loop;
}.start(~cT, quant: [4]);
)
~clicker.stop;

~cT = TempoClock.new(1.39 * 1.25 * 1.075 * 4).permanent_(true);