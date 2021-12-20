(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        | trigGate = 1 |
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 3, 1].stutter(8), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(0.5);
        var d6 = Demand.kr(t, 0, Dseq([0.5, 0.5].stutter(32), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, dddd]), t);
        var sig = MiOmi.ar(
            ratio1: 0.25,
            ratio2: 0.5,
            pit: 76 - 12 - 12 + d + 0 + [-12, -5],
            fm1: e * 0.25 * d5,
            fm2: 0.05,
            fb: 0.5,
            xfb: 0.5,
            rotate: 0,
            space: 0,
        ) * 0.4 * e!2;
        // sig.poll;
        // d5.poll;

        sig = Sanitize.ar(sig);

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
        VadimFilter.ar(sig, 7400, 0, 1) * 1 * 1;
    }.play;   // cross feedback

});
)