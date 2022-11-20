(
x.free;
x = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    // var t = Impulse.kr(2 * 2.2);
    var x = MouseX.kr(0.01, 1);
    var y = MouseX.kr(0.01, 1);
    var d = Demand.kr(t, 0, Dseq([1], inf)) * t;
    var sig = AnalogBassDrum.ar(
        trig: d,
        accent: 1,
        freq: 40 + 0 + 12,
        tone: 0.5,
        decay: 0.85,
        attackfm: 0,
        selffm: 0.5
    ) * 8;
    var wet = 1;
    sig = (sig * (1 - wet)) + (Compander.ar(
        in: sig * 4,
        control: sig * 4,
        thresh: 1,
        slopeBelow: 1,
        slopeAbove: 0.5,
        clampTime:  0.01,
        relaxTime:  0.01
    ) * wet);
    sig = VadimFilter.ar(sig, 500 + 10, 0, 1);
    sig = sig * 0.1!2;
}.play(fadeTime: 0.0);
)


(
y.free;
y = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    // var d = Demand.kr(t, 0, Dseq([0, 1], inf));
    // var t = Impulse.kr(2 * 2.2);
    var x = MouseX.kr(0.01, 1);
    var y = MouseX.kr(0.01, 1);
    var d = Demand.kr(t, 0, Dseq([0, 1], inf)) * t;
    var sig = AnalogSnareDrum.ar(
        trig: d,
        accent: 0.75,
        freq: 40 + 36,
        tone: 0.0,
        decay: 0.5,
        snappy: 0.75
        // attackfm: 0,
        // selffm: 0.55
    ) * 8;
    var wet = 1;
    sig = (sig * (1 - wet)) + (Compander.ar(
        in: sig * 4,
        control: sig * 4,
        thresh: 1,
        slopeBelow: 1.5,
        slopeAbove: 0.75,
        clampTime:  0.01,
        relaxTime:  0.02
    ) * wet);
    // sig = VadimFilter.ar(sig, 500 + 10, 0, 1);
    sig = sig * 0.02!2;
}.play(fadeTime: 0.0);
)





(
y.free;
y = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    // var d = Demand.kr(t, 0, Dseq([0, 1], inf));
    // var t = Impulse.kr(2 * 2.2);
    var x = MouseX.kr(0.01, 1);
    var y = MouseX.kr(0.01, 1);
    var d = Demand.kr(t, 0, Dseq([0, 1], inf)) * t;
    var sig = AnalogSnareDrum.ar(
        trig: d,
        accent: 0.75,
        freq: 40 + 36,
        tone: 0.0,
        decay: 0.75,
        snappy: 0.75
        // attackfm: 0,
        // selffm: 0.55
    ) * 8;
    var wet = 1;
    // var level = d.lag(0.5) * 2;
    var e = EnvGen.kr(Env([0, 1, 0], [0.005, 2], -8), d);
    sig = (sig * (1 - wet)) + (Compander.ar(
        in: sig * 4,
        control: sig * 4,
        thresh: 1,
        slopeBelow: 1.5,
        slopeAbove: 0.75,
        clampTime:  0.01,
        relaxTime:  0.02
    ) * wet);
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.5, algo: 1, timb: 0.9)[0] * e);
    // sig = VadimFilter.ar(sig, 500 + 10, 0, 1);
    sig = sig * 0.02!2;
}.play(fadeTime: 0.0);
)



(
y.free;
y = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    // var d = Demand.kr(t, 0, Dseq([0, 1], inf));
    // var t = Impulse.kr(2 * 2.2);
    var x = MouseX.kr(0.01, 1);
    var y = MouseX.kr(0.01, 1);
    var d = Demand.kr(t, 0, Dseq([0, 1], inf)) * t;
    var sig = AnalogSnareDrum.ar(
        trig: d,
        accent: 0.75,
        freq: 40 + 36,
        tone: 0.0,
        decay: 0.75,
        snappy: 0.75
        // attackfm: 0,
        // selffm: 0.55
    ) * 8;
    var wet = 1;
    // var level = d.lag(0.5) * 2;
    var e = EnvGen.kr(Env([0, 1, 0], [0.005, 2], -8), d);
    sig = (sig * (1 - wet)) + (Compander.ar(
        in: sig * 4,
        control: sig * 4,
        thresh: 1,
        slopeBelow: 1.5,
        slopeAbove: 0.75,
        clampTime:  0.01,
        relaxTime:  0.02
    ) * wet);
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.5, algo: 2, timb: 0.9)[0]);
    // sig = VadimFilter.ar(sig, 500 + 10, 0, 1);
    sig = sig * 0.02!2;
}.play(fadeTime: 0.0);
)