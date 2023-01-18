(
z.free;
z = {
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Drand([0, 1], inf)!16) * t;
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 8 - 0.01], [2, -8, 'lin']), d).lag(0.125);
    var n = Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 8;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var sig = HarmonicOsc.ar(
        freq: 110 * 2 * [1,1.01].dup * (n+2).midiratio.lag(0.1),
        firstharmonic: [0, 1].dup + [[0,0],[2,2]] + 10,
/*        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 4, 4
        ]*/
        amplitudes: e
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 1500 * e + 100, 0.5, 3)*0.1 * e;
    // sig = MiVerb.ar(sig,);
    sig * 0.1;
}.play;
)