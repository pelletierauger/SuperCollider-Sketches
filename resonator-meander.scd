~t = TempoClock.new(3.16 * -2.midiratio).permanent_(true);
~t.tempo;

(
Ndef(\resonantsnare, { |pan=0|
    var t = Impulse.kr(~t.tempo * 2.5);
    var trig = t * Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    var d = Demand.kr(trig, 0, Dseq((0..5) / 5, inf));
    var snare = AnalogSnareDrum.ar(
        trig, accent: 0.8, decay: 0.4, tone: 0, snappy: 0.0
    );

    var sig = Resonator.ar(
        input: snare,
        freq: 55 * 18.midiratio * (d * -5).midiratio,
        position: 0.4,
        resolution: 10,
        structure: 0.7,
        brightness: 0.05,
        damping: 0.5
    );

    // Limiter
    sig = sig * 2;
    sig = sig.tanh;

    Pan2.ar(sig, pan);
}).play;
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
        freq: 110 * -8.midiratio,
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