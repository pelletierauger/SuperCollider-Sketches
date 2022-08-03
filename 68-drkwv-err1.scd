(
y.free;
y = {
    var f = ~toMidi.("A3");
    var t = Impulse.kr(6);
    var dd = [
        [1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0]
    ].wrapExtend(4);
    var v = [
        [  5,    5,   5,   3  ],
        [  3,    3,   3,   2  ],
        [  0,    0,   0,   0  ],
        [ -5,   -5,  -5,  -5  ],
    ];
    var st = [2, 3, 2, 3];
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var e = EnvGen.kr(Env([0, 1, 0], [0.02, 0.5], [2, 'lin', 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.1, 1)),
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.5,
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.125, model: 20, resamp: 2, decim: 0, bits: 4, ws: 0.75);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 2000 * e + 100, 0.5 * SinOsc.kr(3).unipolar, 1) * e;
    sig = [sig[0] + sig[2], sig[1] + sig[3]] * 1;
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    MiWarps.ar(sig[1], sig[0], lev1: 0.2, lev2: 0.4, algo: 4, timb: 0.75)[0] * 4!2;
}.play;
)





(
y.free;
y = {
    var f = ~toMidi.("A3");
    var t = Impulse.kr(6);
    var dd = [
        [1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0]
    ].wrapExtend(4);
    var v = [
        [  5,    5,   5,   3  ],
        [  3,    3,   3,   2  ],
        [  0,    0,   0,   0  ],
        [ -5,   -5,  -5,  -5  ],
    ];
    var st = [4, 6, 4, 6];
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var e = EnvGen.kr(Env([0, 1, 0], [0.02, 0.5], [2, 'lin', 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.1, 1)),
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.5,
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.125, model: 20, resamp: 2, decim: 0, bits: 4, ws: 0.75);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 2000 * e + 100, 0.5 * SinOsc.kr(3).unipolar, 1) * e;
    sig = [sig[0] + sig[2], sig[1] + sig[3]] * 1;
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    MiWarps.ar(sig[1], sig[0], lev1: 0.2, lev2: 0.4, algo: 5, timb: 0.75, osc: 2, freq: 110 * -24.midiratio, easteregg: 1)[0] * 4!2;
}.play;
)











// --------------------------------


(
y.free;
y = {
    var f = ~toMidi.("A3");
    var t = Impulse.kr(6);
    var dd = [
        [1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0]
    ].wrapExtend(4);
    var v = [
        [  5,    5,   5,   3  ],
        [  3,    3,   3,   2  ],
        [  0,    0,   0,   0  ],
        [ -5,   -5,  -5,  -5  ],
    ];
    var st = [2, 3, 2, 3];
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var e = EnvGen.kr(Env([0, 1, 0], [0.02, 0.5], [2, 'lin', 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.1, 1)),
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.5,
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.125, model: 20, resamp: 2, decim: 0, bits: 4, ws: 0.75);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 1000 * e + 100, 0.5 * SinOsc.kr(3).unipolar, 1) * e;
    sig = [sig[0] + sig[2], sig[1] + sig[3]] * 1;
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    sig = MiWarps.ar(sig[1], sig[0], lev1: 0.6, lev2: 0.4, algo: 4, timb: 0.75)[0] * 4!2;
    MiRings.ar(sig, 0, f - 24 - 12,
        struct: 0.25, bright: 0.95, damp: 0.95, pos: 0.25, model: 4
    ) + (VadimFilter.ar(sig, 100, 0, 5) * 0.5);
}.play;
)





// ---------------------------------------------------------------------------------
//  Beau, clair, simple.
// ---------------------------------------------------------------------------------

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
        [  5,    5,   5,   3  ],
        [  3,    3,   3,   2  ],
        [  0,    0,   0,   0  ],
        [ -5,   -5,  -5,  -5  ],
    ];
    var st = [2, 3, 2, 3];
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
        f + vl.lag(Line.kr(0, 0.1, 1)),
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.5,
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.125, model: 14, resamp: 2, decim: 0, bits: 4, ws: 0.75);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 3000 * e + 100, 0.35 * SinOsc.kr(3).unipolar, 1) * e;
    sig = [sig[0] + sig[2], sig[1] + sig[3]] * 1;
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    sig = MiWarps.ar(sig[1], sig[0], lev1: 0.5, lev2: 0.4, algo: 3, timb: 0.75)[1] * 4!2;
    sig;
}.play;
)


// ---------------------------------------------------------------------------------
//  Beau, clair, simple.
// ---------------------------------------------------------------------------------

(
y.free;
y = {
    var f = ~toMidi.("A2");
    var t = Impulse.kr(6);
    var dd = [
        [1, 0, 0, 1, 0, 0],
        [1, 0, 1, 0, 1, 0]
    ].wrapExtend(4);
    var v = [
        [   5,     7,    5,    3   ],
        [   3,     3,    3,    2   ],
        [   0,     0,    0,    0   ],
        [  -5,    -5,   -5,   -5   ],
    ];
    var st = [2, 3, 2, 3];
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, 1.3], [2, -8, 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.1, 1)),
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.35,
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.5, model: 21, resamp: 0, decim: 0, bits: 4, ws: 0.75);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 2000 * e * e + 700, 0.35 * SinOsc.kr(3).unipolar, 1) * e;
    sig = [sig[0] + sig[2] * 1, sig[1] + sig[3]] * 1;
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    sig2 = MiWarps.ar(sig[1], sig[0], lev1: 0.8, lev2: 0.8, algo: 3, timb: 0.125)[0] * 1;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.02)];

    sig = VadimFilter.ar(sig, 40, 0, 5);
    // sig = sig + ([sig[1], sig[0]] * 0.75);
    sig!2 + (sig2 * e * 1!2) * 0.25;
}.play;
)
