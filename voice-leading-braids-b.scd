(
x.free;
x = {
    var f = ~toMidi.("A4");
    var t = Impulse.kr(0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [0.5, 4 - 0.5 + 0.5], [2, 'lin', 'lin']), t);
    var v = [
        [  3,    5,   6,   7  ] + 12,
        [  0,   -2,  -3,  -2  ] - 12,
        [ -5,   -6,  -6,  -5  ],
    ];
    var vl = 3.collect({|i| Demand.kr(t, 0, Dseq(v[i], inf))});
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig = MiBraids.ar(f + vl.lag(0.5), timbre: [0.9, 0.5, 0.5], color: 0.5, model: 12);
    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    // sig = sig[0].blend(sig[1], 1 - env);
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = VadimFilter.ar(sig, 4000 * e + 100, 0, 1) * 1;
}.play;
)




(
y.free;
y = {
    var f = ~toMidi.("A3");
    var t = Impulse.kr(8);
    var e = EnvGen.kr(Env([0, 1, 0], [0.02, 0.25], [2, 'lin', 'lin']), t);
    var v = [
        [  3,    5,   3,   5  ],
        [  2,    3,   2,   3  ],
        [  0,    0,   0,   0  ],
        [ -5,   -5,  -5,  -5  ],
    ];
    var vl = v.size.collect({|i| Demand.kr(t, 0, Dseq((v[i]).stutter(8), inf))});
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig = MiBraids.ar(f + vl.lag(Line.kr(0, 0.1, 1)), timbre: 0.5, color: 0.75, model: 14);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    // sig = sig[0].blend(sig[1], 1 - env);
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = VadimFilter.ar(sig, 3000 * e + 100, 0, 1) * 1;
}.play;
)

