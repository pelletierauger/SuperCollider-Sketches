
(
y.free;
y = {
    var f = ~toMidi.("A4");
    var t = Impulse.kr(6);
    var dd = [
        [1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0]
    ].wrapExtend(4);
    var v = [
        [  5 ,   5,   4 + 1,  4  ],
        [  2,   2,   1 + 1,  2  ] ++ [  2,  2,  1 + 1 - 2, -1  ],
        [ -2,  -2,   1 + 1,  0  ] - 12,
        [ -5,  -5,  -4 + 1, -3  ] - 0,
    ];
    var st = [2, 3, 2, 3] * 1;
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var e = EnvGen.kr(Env([0, 1, 0], [0.02, 0.95], [2, -4, 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.1, 1)) - 5 - 12,
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.75,
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.7, model: 37, resamp: 0, decim: 0, bits: 4, ws: 0.75);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 3000 * e + 100, 0.35 * SinOsc.kr(3).unipolar, 1) * e;
    sig = [sig[0] + sig[2], sig[1] + sig[3]];
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    // sig = MiWarps.ar(sig[1], sig[0], lev1: 0.5, lev2: 0.4, algo: 3, timb: 0.75)[1] * 4!2;
    sig.sum!2;
    sig + (sig.reverse * 0.65);
}.play;
)





(
y.free;
y = {
    var f = ~toMidi.("A4");
    var t = Impulse.kr(6);
    var dd = [
        [1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0]
    ].wrapExtend(4);
    var v = [
        [  5,   5,   4 + 1,  4  ],
        [  2,   2,   1 + 1,  2  ] ++ [  2,  2,  1 + 1 - 2, -1  ],
        [ -2,  -2,   1 + 1,  0  ] - 24,
        [ -5,  -5,  -4 + 1, -3  ] - 0,
    ];
    var st = [2, 3, 2, 3] * 1;
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var e = EnvGen.kr(Env([0, 1, 0], [0.02, 0.95], [2, -4, 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.1, 1)) - 5,
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.25,
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.125, model: 14, resamp: 2, decim: 0, bits: 4, ws: 0.75);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 3000 * e + 100, 0.35 * SinOsc.kr(3).unipolar, 1) * e;
    sig = [sig[0] + sig[2], sig[1] + sig[3]];
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    // sig = MiWarps.ar(sig[1], sig[0], lev1: 0.5, lev2: 0.4, algo: 3, timb: 0.75)[1] * 4!2;
    sig.sum!2;
    sig + (sig.reverse * 0.65);
}.play;
)





(
y.free;
y = {
    var f = ~toMidi.("A4");
    var t = Impulse.kr(6);
    var dd = [
        [1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0]
    ].wrapExtend(4);
    var v = [
        // Am                Am2   Dm6   G7
        // i                 i2    iv6   VII
        [  5,    5,    5,    3,    5,    5  ],
        [  3,    3,    3,    2,    2,    2  ],
        [  0,    0,    0,    0,    0,   -2  ] ,
        [ -5,   -5,   -5,   -5,   -4,   -4  ] - 12,
    ];
    var st = [2, 3, 2, 3] * 1;
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var e = EnvGen.kr(Env([0, 1, 0], [0.02, 0.95], [2, -4, 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.1, 1)) - 5 - 12,
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: [0.75, 0.75, 0.75, 0.75],
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.7, model: [37, 37 , 37, 2], resamp: 0, decim: 0, bits: 4, ws: 0.75);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    sig[3] = VadimFilter.ar(sig[3], 3000, 0, 1);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 3000 * e + 100, 0.35 * SinOsc.kr(3).unipolar, 1) * e;
    sig = [sig[0] + sig[2], sig[1] + sig[3]];
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    // sig = MiWarps.ar(sig[1], sig[0], lev1: 0.5, lev2: 0.4, algo: 3, timb: 0.75)[1] * 4!2;
    sig.sum!2;
    sig + (sig.reverse * 0.65);
}.play;
)