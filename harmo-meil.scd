(
u.free;
u = {
    var t = Impulse.kr(0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [0.9, 8 - 0.1], [2, -8, 'lin']), t).lag(0.01);
    var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2).midiratio, inf));
    var a = ~lfo.(8 * e) * 8;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var sig = HarmonicOsc.ar(
        freq: ~toFreq.("E1") * [1, 1.01].dup * d.lag(0.01),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 500 * e + 100, 0.5, 1);
    // sig = MiVerb.ar(sig);
    sig = [sig[0] + (sig[1] * 0.5), sig[1] + (sig[0] * 0.5)] * 0.75;
    sig * 0.05 * Line.kr(0,1,0.125);
}.play;
)