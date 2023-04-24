(
x.free;
x = {
    var t = Impulse.kr(0.25);
    var d = Demand.kr(t, 0, Dseq([0].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(4) * 4;
    var b = [0.5, 1.5];
    var e = EnvGen.kr(Env([0, 1, 0], [0.05, 8 - 0.05], [2, -8, 'lin']), t).lag(0.125);
    var i = 1 - e * 4;
    var sig = HarmonicOsc.ar(
        freq: 110 * 0.5 * d.midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + 4,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 5000 * e + 1000, 0, 5);
    // sig = MiVerb.ar(sig,);

    sig * 0.2;
}.play;
)



(
u.free;
u = {
    var t = Impulse.kr(0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [0.9, 8 - 0.1], [2, -8, 'lin']), t).lag(0.125);
    var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 8;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var sig = HarmonicOsc.ar(
        freq: 110 * 0.25 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 500 * e + 100, 0.5, 1);
    // sig = MiVerb.ar(sig,);
    sig = [sig[0]+(sig[1]*0.5),sig[1]+(sig[0]*0.5)]*0.75;
    sig * 0.05 * Line.kr(0,1,0.125);
}.play;
)



(
z.free;
z = {
    var t = Impulse.kr(2);
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4 - 0.01], [2, -8, 'lin']), t).lag(0.125);
    var d = Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 2;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var sig = HarmonicOsc.ar(
        freq: 110 * 4 * [1,1.01].dup * (d+7+(e*0)).midiratio.lag(0.1),
        firstharmonic: [0, 1].dup + [[0,0],[2,2]],
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 4, 4
        ]
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 1500 * e + 100 * 0.5, 0.5, 3)*0.1 * e;
    // sig = MiVerb.ar(sig,);
    sig * 0.1;
}.play;
)


(
y.free;
y = {
    var t = Impulse.kr(0.5);
    var e = EnvGen.kr(Env([0, 1, 0], [0.1, 16 - 0.1], [2, -8, 'lin']), t).lag(0.125);
    var d = Demand.kr(t, 0, Dseq([3].stutter(4), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 8;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var disto;
    var sig = HarmonicOsc.ar(
        freq: 110 * -22.midiratio * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 1].dup + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );
    var d2ss = Demand.kr(t, 0, Dwhite(150, 3000, inf));
    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, d2ss * e + 100, 0.5, 1);
    // sig = MiVerb.ar(sig,);
            disto = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.63,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        disto = AnalogVintageDistortion.ar(
            input: disto,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.63,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
    sig = disto * 0.01;
    sig = VadimFilter.ar(sig, 1000, 0, 5);
    sig * 4 * Line.kr(0,1,0.125);
}.play;
)


(
f.free;
f = {
    var t = Impulse.kr(0.5);
    var t2 = Impulse.kr(0.5*32);
    var e = EnvGen.kr(Env([0, 1, 0], [0.1, 16 - 0.1], [2, -8, 'lin']), t).lag(0.125);
    var e2 = EnvGen.kr(Env([0, 1, 0], [0.001, 0.1], [2, -8, 'lin']), t2);
    var d = Demand.kr(t, 0, Dseq([3].stutter(4), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 8;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var disto;
    var sig = HarmonicOsc.ar(
        freq: 110 * (-22+7+12).midiratio * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 1].dup + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );
    var d2ss = Demand.kr(t2, 0, Dwhite(50, 5000, inf));
    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, d2ss * e + 100, 0, 1);
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
    sig = VadimFilter.ar(sig, 500 * e2 + 10, 0, 5);
    sig * 4 * Line.kr(0,1,0.125);
}.play;
)


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


(
q.free;
q = {
    var t = Impulse.kr(0.5);
    var t2 = Impulse.kr(0.5*0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [0.1, 16 - 0.1], [2, -8, 'lin']), t).lag(0.125);
    var e2 = EnvGen.kr(Env([0, 1, 0], [0.1, 0.1]*32, [2, -8, 'lin']), t2);
    var d = Demand.kr(t, 0, Dseq([3].stutter(4), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 8;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var disto;
    var asdf = Demand.kr(t2, 0, Dseq([0, 1, 2, 1].stutter(2), inf));
    var sig = HarmonicOsc.ar(
        freq: 110 * (-22+7 + -12).midiratio * [1,1.01].dup * (d+7).midiratio.lag(0.1),
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
    sig = ~v.(sig, d2ss * e * e2 + 1000, 0, 1);
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
    sig = VadimFilter.ar(sig, 8000 * e2 + 500, 0, 1);
    sig * 4 * Line.kr(0,1,0.125);
}.play;
)