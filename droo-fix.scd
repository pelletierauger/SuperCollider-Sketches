~toMidi.("Ab2") + ([25, 32 - 3, 30, 32] * -1)


~toMidi.("C0") + [7, 3, 2, 0]


(
x.free;
x = {
    // var x = MouseX.kr(0, 1);
    // var y = MouseY.kr(0, 1);
    var x = 0.39;
    var y = 0.5;
    var lfo = SinOsc.kr(0.25 * ((1..6)/6));
    var t = Impulse.kr(0.25);
    var t2 = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([7, 3, 2, 0], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], -8), t2);
    var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);
    var sig = MiPlaits.ar(
        ~toMidi.("C0") + ([0, 0.05].wrapExtend(6) * lfo) + [0, 12, 19].stutter(2) + xx + d,
        engine: 6,
        harm: 0.5, timbre: 1 - y, morph: 0.5
    );
    sig = [sig[0][1] + sig[2][1] + sig[4][1], sig[1][1] + sig[3][1] + sig[5][1]];
    // y.poll;
    sig = VadimFilter.ar(
        sig,
        2000 * [lfo[0], lfo[1]].unipolar + 1000,
        0.25,
        1
    ) * 0.4;
}.play;
)