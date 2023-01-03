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
    sig = ~v.(sig, 1500 * e + 100, 0.5, 3)*0.1 * e;
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
    var sig = HarmonicOsc.ar(
        freq: 110 * 1 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 50 * e + 100, 0.5, 1);
    // sig = MiVerb.ar(sig,);
    sig * 4 * Line.kr(0,1,0.125);
}.play;
)