(
q.free;
q = {
    var t = Impulse.kr(0.5);
    var t2 = Impulse.kr(0.5*16);
    var e = EnvGen.kr(Env([0, 1, 0], [0.1, 16 - 0.1], [2, -8, 'lin']), t).lag(0.125);
    var e2 = EnvGen.kr(Env([0, 1, 0], [0.001, 0.1], [2, -8, 'lin']), t2);
    var d = Demand.kr(t, 0, Dseq([3].stutter(4), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 8;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var disto;
    var asdf = Demand.kr(t2, 0, Dseq([0, 3, 4, 5, 6, 7].stutter(8), inf));
    var sig = HarmonicOsc.ar(
        freq: 110 * (-22+7+12).midiratio * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 1].dup + asdf,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );
    var d2ss = Demand.kr(t2, 0, Dwhite(50, 5000, inf));
    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, d2ss * e * e2 + 100, 0, 1);
    // sig = MiVerb.ar(sig,);
            disto = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 0.125, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        disto = AnalogVintageDistortion.ar(
            input: disto,
            drivegain: 0.125, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
    sig = disto * 0.01;
    sig = VadimFilter.ar(sig, 50, 0, 5);
    sig * 4 * Line.kr(0,1,0.125);
}.play;
)