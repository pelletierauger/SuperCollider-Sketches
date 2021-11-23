(
    x.free;
x = {
    var xfb = LFTri.kr(0.05).range(0.5,1);
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([0, 12].stutter(8), inf));
    var t0 = t * Demand.kr(t, 0, Dseq([1, 0].stutter(8), inf));
    var t1 = t * Demand.kr(t, 0, Dseq([0, 1].stutter(8), inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.04, 0.75], [0, 2]), [t0, t1]);
    var sig = MiOmi.ar(pit: 75 - 12 + [0, 12], fm1: 0, xfb: e * 0.5) * e * 0.4!2;
    // sig.poll;
    sig = Sanitize.ar(sig);
    sig = VadimFilter.ar(sig, 1400, 0, 5) * 0.49 * 4;
    // VadimFilter.ar(sig, 4000, 0, 1);
}.play;
)

(   // cross feedback
y.free;
y = {
    var xfb = LFTri.kr(0.05).range(0.5,1);
    var sig = MiOmi.ar(pit: 43 - 12 + [0, 0.1], xfb: xfb * 1) * 0.4;
    // sig.poll;
    sig = [sig[0][0], sig[1][0]];
    sig = Sanitize.ar(sig);
    VadimFilter.ar(sig, 2000, 0, 5) * 0.4 * 8;
}.play;
)