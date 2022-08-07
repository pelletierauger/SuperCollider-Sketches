Safety(s).disable;

// ---------------------------------------------------------------------------------
//  Beau, clair, simple.
// ---------------------------------------------------------------------------------

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
        // Am4               Am2   Dm6   G7    Bm   Em7
        // i                 i2    iv6   VII   ii   v7
        [  5,    5,    5,    3,    5,    5,    5,   5 ],
        [  3,    3,    3,    2,    2,    2,    2,   2 ],
        [  0,    0,    0,    0,    0,   -2,   -4,  -5 ],
        [ -5,   -5,   -5,   -5,   -4,   -4,   -4,  -2 ],
    ];
    var st = [2, 3, 2, 3];
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var e = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5], [-1, -6, 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.05, 1)),
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.1 * e * e * e + 0.4,
        timbre: [0.5, 0.5, 0.15, 0.15],
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        // model: 14,
        color: 0, model: 14, resamp: 0, decim: 0, bits: 4, ws: 0.75,
        // model: 0, timbre: 0.92, resamp: 0
    );
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 2000 * e + 10, 0.25 * SinOsc.kr(3).unipolar, 1) * e;
    // sig = [sig[0] + sig[2], sig[1] + sig[3]];
/*    sig = MiRings.ar(sig, 0, f - 24,
        struct: 0.125, bright: 0.85, damp: 0.25, pos: 0.25, model: 2
    );*/
    // sig = MiWarps.ar(sig[1], sig[0], lev1: 0.5, lev2: 0.4, algo: 3, timb: 0.75)[1] * 4!2;
    // sig.sum!2;
    // sig = sig + (sig.reverse * 0.65);
    sig = [sig[0], sig[2], sig[1], sig[3]];
    sig = sig.size.collect({|i| Pan2.ar(sig[i], [-0.75,-0.5,0.5,0.75][i])}).sum;
    // sig = MiVerb.ar(sig, 0.4, drywet: 0.1);
    sig = MiRings.ar(sig, 0, f - 24 + 12,
        struct: 0.0625, bright: 0.85, damp: 0.125, pos: 0.75, model: 2, easteregg:1
    ) * 0.4 + (sig * 0.5);
        sig = MiRings.ar(sig * 0.5, 0, f - 24 + 12,
        struct: 0.125, bright: 0.85, damp: 0.0625, pos: 0.75, model: 0, easteregg:0
    ) * 0.4 + (sig * 0.2);
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    // sig = VadimFilter.ar(sig, 1000, 0, 1) * 2 + (sig * 0.7);
}.play;
)
