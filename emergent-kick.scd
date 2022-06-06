


(
x.free;
x = {
    var t = Impulse.kr(2 * 3.2);
    var x = MouseX.kr(0.01, 1);
    var y = MouseX.kr(0.01, 1);
    var d = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf)) * t;
    var sig = AnalogBassDrum.ar(
        trig: d,
        accent: 0,
        freq: 40,
        tone: 0.3,
        decay: 0.99,
        attackfm: 0.25,
        selffm: 0.75
    );
    var wet = 1;
    sig = VadimFilter.ar(sig, 5000 * 0.25 + 10, 0, 1);
    sig = (sig * (1 - wet)) + (Compander.ar(
        in: sig * 4,
        control: sig * 4,
        thresh: 1,
        slopeBelow: 1,
        slopeAbove: 0.5,
        clampTime:  0.01,
        relaxTime:  0.01
    ) * wet);
    sig = (sig * 0.25) + MiRings.ar(
            sig, pit: 40 - 24, struct: x, damp: y, model: 5) * 0.5;
    sig = sig * 0.5;
}.play(fadeTime: 0.005);
)