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
        var sig = PlayBuf.ar(2, b, -7.midiratio, bl, startPos: 0, loop: 0);
        var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;

        // sig = sig * 0.7 * VadimFilter.ar(sig2, 500, 0, 0) * 2;
        sig = sig + DelayC.ar(sig2 * 0.5, 0.5, ~t.beatDur * 0.5) * 1;
        sig = sig + MiRings.ar(sig, pit: 48 - 5, struct: 0.2, model: 4);
        VadimFilter.ar(sig, 5000, 0, 0) * [3, 2] * 2 * 0.1;
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
        var sig = PlayBuf.ar(2, b, -7.midiratio, bl, startPos: 0, loop: 0);
        var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        var sig3 = MiRings.ar(sig, pit: 48 - 5, struct: 0.3, model: 4);
        sig = sig * 0.7 * VadimFilter.ar(sig2, 500, 0, 0) * 2;
        VadimFilter.ar(sig, 2000, 0, 0) * [3, 2] + (sig3 * 0.4) * 2 * 0.2;
    }.play(fadeTime: 0);
});
)
