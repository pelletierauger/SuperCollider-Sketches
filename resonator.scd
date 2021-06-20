(
Ndef(\resonantsnare, { |pan=0|
    var trig = Impulse.kr(~t.beatDur.reciprocal * 1);
    var snare = AnalogSnareDrum.ar(
        trig, decay: 0.2
    );

    var sig = Resonator.ar(
        input: snare,
        freq: 220 * -8.midiratio,
        position: 0.85,
        resolution: 5,
        structure: 0.5,
        brightness: 0.95,
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