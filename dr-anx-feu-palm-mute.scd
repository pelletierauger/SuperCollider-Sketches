~nT.tempo = 3.614;
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 1);
        var d = Demand.kr(t, 0, Dseq([0, -2, 0, 1].stutter(2), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 0 + d - 12,
            fm1: e.pow(3) * 0.5,
            fm2: e.pow(3) * 2,
            xfb: min(e * dd * 0.5, 1)) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
    sig = sig * 1 + (VadimFilter.ar(sig, 8400, 0, 5) * 84) * 1;
    // VadimFilter.ar(sig, 1500, 0, 1);
    }.play;   // cross feedback
    z.set(\gate, 0, \fadeTime, 0.1);
    z = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2);
        var d = Demand.kr(t, 0, Dseq([0, -2, 0, 1].stutter(2), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, -4].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + d - 12 + [0, 0.1],
            fm1: e.pow(3) * 0.5,
            fm2: e.pow(3) * 0,
            xfb: min(e * dd * 0.5, 1)) * 0.4 * e;
        // sig.poll;
    sig = [sig[0][0], sig[1][0]];
        sig = Sanitize.ar(sig);
    sig = sig * 1 + (VadimFilter.ar(sig, 8400, 0, 5) * 84) * 2;
    // VadimFilter.ar(sig, 1500, 0, 1);
    }.play;   // cross feedback
    x.set(\gate, 0, \fadeTime, 0.1);
    // 0.5.wait;
    x = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(8);
        var d = Demand.kr(t, 0, Dseq([0, 0].stutter(32).rotate(-2), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5]), t);
        var sig = MiOmi.ar(pit: 75 - 12 + d, fm1: 0, xfb: e) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        sig = VadimFilter.ar(sig, 1400, 0, 5) * 0.49 * 2;
    VadimFilter.ar(sig, 4500, 0, 1) * 0.5 * 4;
    }.play;
});
)