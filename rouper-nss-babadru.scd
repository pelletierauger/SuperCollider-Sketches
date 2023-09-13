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
        accent: 0,
        freq: ~toFreq.("E1"),
        tone: 0,
        decay: 0.65,
        attackfm: 0.2,
        selffm: 0.1
    ) * 8;
    var wet = 1;
/*    sig = (sig * (1 - wet)) + (Compander.ar(
        in: sig * 4,
        control: sig * 4,
        thresh: 1,
        slopeBelow: 1,
        slopeAbove: 0.5,
        clampTime:  0.01,
        relaxTime:  0.01
    ) * wet);*/
    sig = VadimFilter.ar(sig, 500 + 10, 0, 1);
    sig = sig * 20!2;
}.play(fadeTime: 0.0);
)