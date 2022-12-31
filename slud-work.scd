~nT = TempoClock.new(1.39 * 1 * 1.25).permanent_(true);
~nT.tempo;

~nT.tempo = 0.5;

(
z.free;
z = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
    var t = tr[1] * dd * Demand.kr(tr[1] * dd, 0, Dseq(
        [1, 0].wrapExtend(8) ++ [1, 0, 0, 0].wrapExtend(8)
        , inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2].stutter(12), inf));
    var sig = MiBraids.ar(
        pitch: 27 + 12 + [0, 7, 12] + ([0, 0.25].stutter(3)) + note,
        timbre: 0.5,     color: 0.75,     model: 9,
        trig: t,
        resamp: 2,       decim: 10,       bits: 4,       ws: 0,
    ) * 0.4 * dd.lag(0.05);
    // sig = DelayC.ar(sig, 1, (0..3)*0.1);
    sig = sig.sum;
    sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.5, bias: 0.2, lowgain: 0.8, highgain: 0.3 * e,
        shelvingfreq: (27 + 48 + 12).midicps, oversample: 0
    ) * 0.2;
    sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.5, bias: 0.2, lowgain: 0.8, highgain: 0.3,
        shelvingfreq: (27 + 48 + 48 + 12).midicps, oversample: 0
    ) * 0.2;
    sig = ~v.(sig, 8000 * e + 1800 * 0.5);
    sig ! 2 * 0.5;
}.play;
)
(
y.free;
y = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
    var t = tr[1] * dd * Demand.kr(tr[1] * dd, 0, Dseq(
        [1, 0].wrapExtend(8) ++ [1, 0, 0, 0].wrapExtend(8)
        , inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2].stutter(12), inf));
    var sig = MiBraids.ar(
        pitch: 27 + 12 + 12 + [0, 7, 12] + ([0, 0.25].stutter(3)) + note,
        timbre: 0.95,     color: 0.75,     model: 9,
        trig: t,
        resamp: 2,       decim: 10,       bits: 4,       ws: 0,
    ) * 0.4 * dd.lag(0.05);
    // sig = DelayC.ar(sig, 1, (0..3)*0.1);
    sig = sig.sum;
    sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.5, bias: 0.2, lowgain: 0.8, highgain: 0.3 * e,
        shelvingfreq: (27 + 48 + 12).midicps, oversample: 0
    ) * 0.2;
    sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.5, bias: 0.2, lowgain: 0.8, highgain: 0.3,
        shelvingfreq: (27 + 48 + 48 + 12).midicps, oversample: 0
    ) * 0.2;
    sig = ~v.(sig, 8000 * e + 1800, 0, 3);
    sig ! 2 * 0.5;
}.play;
)

(27 + 36).midicps