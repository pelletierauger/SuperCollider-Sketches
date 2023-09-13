(
z.free;
z = {
    var t = Impulse.kr(0.5);
    var e = EnvGen.kr(Env([0, 1, 0], [0.5, 0.5 - 0.001]*2, [10, -10, 'lin']), t).lag(0.0625);
    var d = Demand.kr(t, 0, Dseq([0, -1, 2, 3].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(2 * e) * 2;
    var b = [0.5, 1.5];
    var i = 1 - e * 0.25;
    var sig = HarmonicOsc.ar(
        freq: 55 * 2 * [1,1.01].dup * (d+7+(e*0)).midiratio.lag(0.001),
        firstharmonic: [0, 1].dup + [[0,0],[2,2]] + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 4, 4
        ]
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 8400 * e*e + 100, 0, 3)*16 * e;
        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128*4), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.125;
    sig = [sig[0][0], sig[1][0]];
    // sig = MiVerb.ar(sig,);
    sig * 0.1;
}.play;
)



(
z.free;
z = {
    var t = Impulse.kr(0.5*12);
    var e = EnvGen.kr(Env([0, 1, 0], [0.5, 0.5 - 0.001]*0.125, [10, -10, 'lin']), t).lag(0.0625);
    var d = Demand.kr(t, 0, Dseq([0, -1, 2, 3].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15).stutter(2), inf));
    var a = ~lfo.(2 * e) * 2;
    var b = [0.5, 1.5];
    var i = 1 - e * 0.25;
    var sig = HarmonicOsc.ar(
        freq: 110 * 2 * [1,1.01].dup * (d+7+(e*0)).midiratio.lag(0.001),
        firstharmonic: [0, 1].dup + [[0,0],[2,2]] + (d2*0.5),
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 4, 4
        ]
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 1400 * e*e + 100, 0, 1)*16 * e;
        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128*3), lev1: 0.25, lev2: 0.25,
        algo: 1, timb: 0.125, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 4;
    sig = [sig[0][0], sig[1][0]];
    // sig = MiVerb.ar(sig,);
    sig * 0.1;
}.play;
)
