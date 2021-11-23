(
    x.set(\gate, 0, \fadeTime, 0.1);
    // 0.5.wait;
    x = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
    var t = Impulse.kr(0.25);
        var d = Demand.kr(t, 0, Dseq([0, -2, 0, 1].stutter(1).rotate(0), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 5]), t) * 0.5;
        var sig = MiOmi.ar(
        // gate: t,
        // detune: 0.75,
        pit: 75 - 24 - 5 + d,
        fm1: 1, fm2: 1,
        ratio1: 0, ratio2: 0,
        cutoff: e,
        xfb: e - 0.2,
        reson: 0.25
    ) * 0.4 * e;
        // sig.poll;
    // sig = sig;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 2400, 0, 1) * 0.49 * 4;
    }.play;
    y.set(\gate, 0, \fadeTime, 0.1);
    // 0.5.wait;
    y = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(4);
        var d = Demand.kr(t, 0, Dseq([0, 3].stutter(16).rotate(-2), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
        var sig = MiOmi.ar(pit: 75 - 12 + d, fm1: 0, xfb: e) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 1400, 0, 5) * 0.49 * 0.25;
    }.play;
)



(   // cross feedback
y.free;
y = {
    var xfb = LFTri.kr(0.05).range(0.5,1);
    var sig = MiOmi.ar(pit: 43 - 12, xfb: xfb) * 0.4;
    sig.poll;
    sig = Sanitize.ar(sig);
    VadimFilter.ar(sig, 2000, 0, 5) * 0.4;
}.play;
)
