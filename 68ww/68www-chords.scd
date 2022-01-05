~dir = thisProcess.nowExecutingPath.dirname;
~chords00 = PathName.new(~dir +/+ "wbbb-chords00.wav");
d = Buffer.read(s, ~chords00.fullPath);

(
~t.sched(~t.timeToNextBeat(quant: 6) - (~t.beatDur * 1.5 * 0), {
    z.set(\fadeTime, 0.01, \gate, 0);
    // y.set(\gate, 0, \fadeTime, 0.1);
    z = {
        | freeze = 0 |
        var t = Impulse.kr(~t.tempo);
        var bl = t * Demand.kr(t, 0, Dseq((1!1) ++ ( 0 ! (6 * 8 - 1)), inf));
        var sig = XPlayBuf.ar(2, d, 0.midiratio, bl, startPos: 0, loop: 0, fadeTime: 0.01);
        // var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        // var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        // sig = sig * 0.7 + VadimFilter.ar(sig2, 500, 0, 0) * 2;

        // sig = CombC.ar(sig, 1, 0.05, 3);
        sig = VadimFilter.ar(sig, 1000 + SinOsc.kr(~t.tempo * 2).range(0, 9000), 0, 1);
        sig = sig * 0.5 + MiRings.ar(sig, pit: 48 - 2, bright: 0.95, damp: 0.4, model: 2) * 0.5;
        // sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0, type: 0) * 0.5;
        // sig = VadimFilter.ar(sig, 400, 0, 5) * 2;
        sig * 2;
    }.play(fadeTime: 0);
});
)


(
~t.sched(~t.timeToNextBeat(quant: 6), {
    [~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
    ~synthLine4.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    y.set(\fadeTime, 0.01, \gate, 0);
    x.set(\fadeTime, 0.01, \gate, 0);
    x = {
        | freeze = 0 |
        var t = Impulse.kr(~t.tempo);
        var bl = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        var sig = PlayBuf.ar(2, b, -2.midiratio, bl, startPos: 0, loop: 0);
        var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        sig = sig * 0.7 * VadimFilter.ar(sig2, 500, 0, 0) * 2;
        VadimFilter.ar(sig, 2000, 0, 0) * [3, 2] + (sig3 * 0.4) * 2 * 0.2;
    }.play(fadeTime: 0);
});
~t.sched(~t.timeToNextBeat(quant: 6) - (~t.beatDur * 1.5 * 0), {
    z.set(\fadeTime, 0.01, \gate, 0);
    // y.set(\gate, 0, \fadeTime, 0.1);
    z = {
        | freeze = 0 |
        var t = Impulse.kr(~t.tempo);
        var bl = t * Demand.kr(t, 0, Dseq((1!1) ++ ( 0 ! (6 * 8 - 1)), inf));
        var sig = XPlayBuf.ar(2, d, 0.midiratio, bl, startPos: 0, loop: 0, fadeTime: 0.01);
        // var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        // var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        // sig = sig * 0.7 + VadimFilter.ar(sig2, 500, 0, 0) * 2;

        // sig = CombC.ar(sig, 1, 0.05, 3);
        sig = VadimFilter.ar(sig, 1000 + SinOsc.kr(~t.tempo * 2).range(0, 9000), 0, 1);
        sig = sig * 0.5 + MiRings.ar(sig, pit: 48 - 2, bright: 0.95, damp: 0.4, model: 2) * 0.5;
        // sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0, type: 0) * 0.5;
        // sig = VadimFilter.ar(sig, 400, 0, 5) * 2;
        sig * 2;
    }.play(fadeTime: 0);
});
)
