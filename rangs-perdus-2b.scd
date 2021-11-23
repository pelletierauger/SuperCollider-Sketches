(
    z.set(\gate, 0, \fadeTime, 0.1);
    z = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t0 = Impulse.kr(4);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 1, 0, 1, 1, 0, 0], inf));
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2].stutter(4), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, -4, -4, 2], inf));
    var fuzz = Demand.kr(t, 0, Dseq([0.25, 0.25, 0.75, 0.25], inf));
    var fuzz2 = Demand.kr(t, 0, Dseq((0.5!3) ++ (0.5!1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + -7 - 12 + [0, 0.1],
            fm1: e.pow(3) * fuzz,
            fm2: e.pow(3) * fuzz,
            xfb: min(e * dd * 0.5, 1)) * 0.4 * e;
        // sig.poll;
    sig = [sig[0][0], sig[1][0]];
        sig = Sanitize.ar(sig);
    sig = Decimator.ar(sig, 2000, 12);
    sig = VadimFilter.ar(sig, 2900, 0, 1) * 2;
    // sig = (sig * 1000).clip(-1, 1) * 0.01;
    sig = VAKorg35.ar(sig, freq: 1900, res: 0.1, overdrive: 0.05) * 0.5;
}.play;
v.free;
    v = {
        var trig = Impulse.ar(1);
        var dem = Demand.ar(trig, 0, Dseq([0.95, 0.75].stutter(4), inf)).lag(2);
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var sig = MiElements.ar(
            gate: 1,
            pit: 75 - 12 - 12 + 24,
            contour: 0.65,
            bow_level: 1,
            bow_timb: 0.25 + (1 - dem * 0.5),
            geom: dem,
            bright: 0.4,
            damp: 0.4,
            space: 1,
            model: 1
        );
        sig = VadimFilter.ar(sig * 8 * 1.5, 200, 0, 5) * 4 * 6;
        sig = [sig[1], sig[0]] * 0.125 * 1;
    }.play(fadeTime: 2);
)




(
    z.set(\gate, 0, \fadeTime, 0.1);
    z = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t0 = Impulse.kr(4);
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 1, 0, 1, 1, 0, 0], inf));
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2].stutter(4), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0.5, 0.25].stutter(8), inf));
        var dddd = Demand.kr(t, 0, Dseq([-4, -4, -4, 2], inf));
    var fuzz = Demand.kr(t, 0, Dseq([0.25, 0.25, 0.75, 0.25], inf));
    var fuzz2 = Demand.kr(t, 0, Dseq((0.5!3) ++ (0.5!1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + -7 - 12 + [0, 0.1],
            fm1: e.pow(3) * fuzz,
            fm2: e.pow(3) * fuzz,
            xfb: min(e * dd * ddd, 1)) * 0.4 * e;
        // sig.poll;
    sig = [sig[0][0], sig[1][0]];
        sig = Sanitize.ar(sig);
    sig = Decimator.ar(sig, 2000, 12);
    sig = VadimFilter.ar(sig, 2900, 0, 1) * 2;
    // sig = (sig * 1000).clip(-1, 1) * 0.01;
    sig = VAKorg35.ar(sig, freq: 1900, res: 0.1, overdrive: 0.05) * 0.5;
}.play;
    x.set(\gate, 0, \fadeTime, 0.1);
    // 0.5.wait;
    x = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t0 = Impulse.kr(1);
    var t = t0 * Demand.kr(t0, 0, Dseq(
        ((1!1) ++ (0!3)).wrapExtend(12) ++ (1!4)
        , inf));
        var d = Demand.kr(t, 0, Dseq([0, -2, 1, 3, 1, 3, 5].stutter(1), inf));
    var dd = Demand.kr(t, 0, Dseq((0!3) ++ (0.125!4), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 2]), t);
        var sig = MiOmi.ar(pit: 75 - 12 + d, fm1: dd.lag(3) * e, xfb: 0.5) * 0.4;
        // sig.poll;
        sig = Sanitize.ar(sig);
        sig = VadimFilter.ar(sig, 1400, 0, 5) * 4 * 2;
    VadimFilter.ar(sig, 8500, 0, 1) * 0.5;
    }.play;
)

s.record;
s.stopRecording;