~dir = thisProcess.nowExecutingPath.dirname;
~chords00 = PathName.new(~dir +/+ "wbbb-chords00.wav");

~chords00monoA = Buffer.readChannel(s, ~chords00.fullPath, channels: [0]);
~chords00monoB = Buffer.readChannel(s, ~chords00.fullPath, channels: [1]);
~chords00monoA;
~chords00monoB;

(
var y, h, size;
size = s.sampleRate * 0.2;
y = Signal.hanningWindow(size * 2);
h = Array.fill(size, {|i| y[i]});
~grainShape = Buffer.alloc(s, size, 1);
~grainShape.loadCollection(h);
)

~grainShape;
~grainShape.bufnum;

~t = TempoClock.new(3.16 * -2.midiratio).permanent_(true);
~t.tempo;

(
~t.sched(~t.timeToNextBeat(quant: 8) - (~t.beatDur * 1.5 * 0), {
    ~grain.set(\fadeTime, 0.1, \gate, 0);
    ~grain = {
        var trig, trate, dur, clk, pos, pan, sig, bufn, d, e, t;
        bufn = [~chords00monoA.bufnum, ~chords00monoB.bufnum];
        trate = MouseY.kr(8, 220, 1);
        dur = 2 / trate;
        clk = Impulse.kr(trate);
        t = Impulse.kr(~t.tempo * 0.25);
        d = Demand.kr(t, 0, Dseq([5, 6, 10, 14].stutter(4), inf));
        e = EnvGen.kr(Env([0, 1, 0], [0.1, 0.2.reciprocal - 0.1]), t);
        pos = 23 + d + e + WhiteNoise.kr(0.1);
        pan = WhiteNoise.kr(1);
        trig = Impulse.kr(~t.tempo * 128);
        dur = 0.009;
        sig = TGrains3.ar(
            numChannels: 1,
            trigger: trig,
            bufnum: bufn,
            rate: Demand.kr(trig, 0, Dseq([1, 0.5], inf)),
            centerPos: pos,
            dur: 0.25,
            pan: pan,
            amp: 0.1 * Demand.kr(trig, 0, Dseq([1, 0.5], inf)),
            att: dur * 0.1 * 4,
            dec: dur * 0.3 * 4,
            window: ~grainShape.bufnum,
            interp: 4
        );
        VadimFilter.ar(sig, 8000, 0, 1) * 0.25;
    }.play;
});
)