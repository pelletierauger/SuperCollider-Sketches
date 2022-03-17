~t = TempoClock.new(3.16 * -2.midiratio).permanent_(true);
~t.tempo;

(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 1.5 * 0), {
~res.set(\fadeTime, 0.1, \gate, 0);
~res = {
    var t = Impulse.kr(~t.tempo * 4);
    var trig = t * Demand.kr(t, 0, Dseq([1, 1, 1, 1, 0, 0, 0, 0], inf));
    var d = Demand.kr(trig, 0, Dseq((0..3).reverse.stutter(16) + 1 / 4, inf));
    var snare = AnalogSnareDrum.ar(
        trig, accent: 0.8, decay: 0.4, tone: 0, snappy: 0.0
    );

    var sig = Resonator.ar(
        input: snare,
        freq: 55 * 2 * 18.midiratio * (d * -5).midiratio,
        position: 0.2,
        resolution: 10,
        structure: 0.7,
        brightness: 0.5,
        damping: 0.2
    );

    // Limiter
    sig = sig * 2;
    sig = sig.tanh;
    sig = VadimFilter.ar(sig, 10 + (d * 1000), 0, 1);
    sig!2;
}.play;
});
)



(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 2), {
~res2.set(\fadeTime, 0.1, \gate, 0);
~res2 = {
    var t = Impulse.kr(~t.tempo * 4);
        var trig = t * Demand.kr(t, 0, Dseq([1, 1, 1, 1, 0, 0, 0, 0].stutter(4), inf));
    var d = Demand.kr(trig, 0, Dseq((0..3).reverse.stutter(8) + 1 / 4, inf));
    var snare = AnalogSnareDrum.ar(
        trig, accent: 0.8, decay: 0.4, tone: 0, snappy: 0.0
    );

    var sig = Resonator.ar(
        input: snare,
        freq: 220 * 2 * 18.midiratio * (d * -5).midiratio,
        position: 0.2,
        resolution: 10,
        structure: 0.7,
        brightness: 0.125,
        damping: 0.8
    );

    // Limiter
    sig = sig * 2;
    sig = sig.tanh;
    sig = VadimFilter.ar(sig, 10 + 2000 + (d * 1000), 0, 5);
    sig!2 * 0.5;
}.play;
});
)


(
Ndef(\resonantsnare2, { |pan=0|
    var trig = Impulse.kr(~t.beatDur.reciprocal * 1);
    var snare = AnalogSnareDrum.ar(
        trig: trig,
        accent: 0.0,
        tone: 0.25,
        decay: 0.1,
        snappy: 1
    );

    var sig = Resonator.ar(
        input: snare,
        freq: 110 * -5.midiratio,
        position: 0.85,
        resolution: 5,
        structure: 0.5,
        brightness: 0.95,
        damping: 0.65
    );

    // Limiter
    sig = sig * 4;
    sig = sig.tanh;

    Pan2.ar(sig, pan);
}).play;
)

Ndef(\resonantsnare2).set(\gate, 0, \fadeTime, 10);
Ndef.set(\gate, 0, \fadeTime, 10);