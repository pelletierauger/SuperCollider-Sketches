~dir = thisProcess.nowExecutingPath.dirname;
~chords00 = PathName.new(~dir +/+ "wbbb-chords00.wav");

~chords00mono = Buffer.readChannel(s, ~chords00.fullPath, channels: [0]);
~chords00mono;

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

(
~grain.set(\fadeTime, 0.1, \gate, 0);
~grain = {
    var trig, trate, dur, clk, pos, pan, sig, bufn;
    bufn = ~chords00mono.bufnum;
    trate = MouseY.kr(8, 220, 1);
    dur = 2 / trate;
    clk = Impulse.kr(trate);
    pos = MouseX.kr(0, BufDur.kr(bufn)) + WhiteNoise.kr(0.1);
    pan = WhiteNoise.kr(1);
    trig = Impulse.kr(~t.tempo * 128);
    // dur.poll;
    dur = 0.009;
    sig = TGrains3.ar(
        numChannels: 2,
        trigger: trig,
        bufnum: bufn,
        // rate: 1,
        rate: Demand.kr(trig, 0, Dseq([1, 0.5], inf)),
        centerPos: pos,
        dur: 0.25,
        pan: pan,
        // amp: 0.1,
        amp: 0.1 * Demand.kr(trig, 0, Dseq([1, 0.5], inf)),
        att: dur * 0.1 * 4,
        dec: dur * 0.3 * 4,
        window: ~grainShape.bufnum,
        interp: 4
    );
    VadimFilter.ar(sig, 8000, 0, 1) * 0.25;
}.play;
)