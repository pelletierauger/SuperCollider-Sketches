(
u.free;
u = {
    var t = Impulse.kr(0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [2, 2], [2, -8, 'lin']), t).lag(0.125);
    var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(0.1) * 0.1;
    var b = 0.5;
    var i = 1 - e * 4;
    var sig = HarmonicOsc.ar(
        freq: 440 * [0,-5,3,7,12,19].midiratio.wrapExtend(16),
        firstharmonic: floor((0..16)*0.125),
        amplitudes: [
            b, i, e, 1, e, a, 0, e,
            1, b, a, a, i, b, 0, 0
        ]
    );
    sig = sig.sum;
    // sig[1] = sig[1];
    // sig[0].size.poll;
    // sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 2000 * e + 100, 0, 1);
    // sig = MiVerb.ar(sig,);
    sig * 0.05 * Line.kr(0,1,0.125) ! 2;
}.play;
)