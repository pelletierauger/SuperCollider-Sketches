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
    var sig = MiBraids.ar(f + vl.lag(Line.kr(0, 0.1, 1)), timbre: SinOsc.kr(0.125).unipolar * 0.5, color: 0.75, model: 14);
    // sig[1] = DelayN.ar(sig[1], 0.5, 0.125);
    /*    sig = sig.sum * 0.1;
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);*/
    sig = VadimFilter.ar(sig, 3000 * e + 100, 0, 1) * 1;
    sig = [sig[0] + sig[2], sig[1] + sig[3]] * 0.1;
}.play;
)
(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | trigGate = 1 |
    // var sig = WhiteNoise.ar();
    // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
    // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
    var t = Impulse.kr(0.25 * 4) * trigGate;
    var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.1, 15], [2, 'lin', 'lin']), t * bl);
    var f = Demand.kr(t * bl, 0, Dseq([0, -4, 0, -7], inf));
    var sig = MiBraids.ar(
        ~toMidi.("A1") + f.lag(Line.kr(0, 0.5, 1)),
        timbre: 0.2, color: 0, model: 17, resamp: 2, decim: 12, bits: 2, ws: 0) * 0.4;
    var freq = 80 + (500 - (env * 500));
    // SinOsc.kr(0.1).exprange(80.0, 1000.0)
    sig = sig + (VAKorg35.ar(sig, freq: freq, res: 0.1, overdrive: 0.05) * 0.5);
/*    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );*/
    // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
    // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
    // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

    sig!2 * 0.0625;
}.play
)
