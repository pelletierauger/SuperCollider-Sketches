Safety(s).disable;

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
        // Am11              Am2   Dm6   G7
        // i                 i2    iv6   VII
        [  5,    5,    5,    3,    5,    5  ],
        [  3,    3,    3,    2,    2,    2  ],
        [  0,    0,    0,    0,    0,   -2  ],
        [ -5,   -5,   -5,   -5,   -4,   -4  ],
    ];
    var st = [2, 3, 2, 3];
    var vl = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq((v[i]).stutter(st[i]), inf));
    });
    var ve = v.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var acc = [[1, 0.75], [0.75, 0.75, 1]].wrapExtend(4);
    var accArr = v.size.collect({
        |i|
        var d0 = t * Demand.kr(t, 0, Dseq(dd[i], inf));
        Demand.kr(d0, 0, Dseq(acc[i], inf));
    });
    var e = EnvGen.kr(Env([0, 1, 0], [0.03, 2], [2, -4, 'lin']), ve);
    var lfo = SinOsc.kr(32 * e).unipolar;
    var sig2;
    var sig = MiBraids.ar(
        f + vl.lag(Line.kr(0, 0.1, 1)),
        timbre: SinOsc.kr(0.125).unipolar * 0.5,
        timbre: 0.5 * accArr,
        // timbre: 0.5 - (SinOsc.kr(0.125).unipolar * 0.1),
        color: 0.125, model: 14, resamp: 0, decim: 0, bits: 4, ws: 0.75);
    // sig = sig;
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 2000 * e + 100, 0.35 * SinOsc.kr(st).unipolar, 1) * e;
    sig = [sig[0] + sig[2], sig[1] + sig[3]];
/*    sig2 = MiRings.ar(sig, 0, f - 12,
        struct: 0.125, bright: 0.85, damp: 0.5, pos: 0.25, model: 0
    );*/
    // sig = MiWarps.ar(sig[1], sig[0], lev1: 0.5, lev2: 0.4, algo: 3, timb: 0.75)[1] * 4!2;
    // sig.sum!2;
    sig + (sig.reverse * 0.65) * 0.1;
}.play;

~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~k = {
    | trigGate = 1 |
    var f = ~toMidi.("A4");
    var t = Impulse.kr(6) * trigGate;
    var dd = [
        [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 0, 0],
        [0, 0, 1, 0, 1, 0] ++ [0, 1, 0, 0, 1, 0],
        [1]
    ];
    var b = dd.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var b0 = b[0];
    var morph = Demand.kr(b0, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b0, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b0, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b0, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b0, 0, Dseq([0.5, 0.51], inf));
    var level = b0.lag(0.5) * m2 * 2;
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("A4") - 36 + [0, 0, 0],      engine: [13, 14, 15],
        harm: 0.95,          timbre: [0.503, 0.1],               morph: [0.75, 0.5, 0.1],
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: -0.25,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   );
    sig = sig[0][1] + (sig[1][0] * 1) + (sig[2][0]);
    sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = VadimFilter.ar(sig, 4000 + 10, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.1 * 1;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)
