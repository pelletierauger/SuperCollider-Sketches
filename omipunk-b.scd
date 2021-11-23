(   // cross feedback
{



    y.free;
    y = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(2);
        var d = Demand.kr(t, 0, Dseq([0, -5].stutter(2), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 2].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + d - 12, fm1: 0, xfb: min(e * e * e * dd, 1)) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 400, 0, 1) * 8.9 + VadimFilter.ar(sig, 2000, 0, 5) * 4;
    }.play;   // cross feedback
    0.25.wait;
    x.free;
    x = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(2);
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
        var sig = MiOmi.ar(pit: 75 - 12, fm1: 0, xfb: e) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 1400, 0, 5) * 0.49 * 4;
    }.play;
    // 0.25.wait;
}.fork;

)


(   // cross feedback
{



    y.free;
    y = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(2);
        var d = Demand.kr(t, 0, Dseq([0, -2, 0, 1].stutter(2), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 2].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + d - 12, fm1: 0, xfb: min(e * e * e * dd, 1)) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 400, 0, 1) * 8.9 + VadimFilter.ar(sig, 2000, 0, 5) * 4;
    }.play;   // cross feedback
    0.25.wait;
    x.free;
    x = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(2);
        var d = Demand.kr(t, 0, Dseq([0, 12].stutter(8), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
        var sig = MiOmi.ar(pit: 75 - 12 + d, fm1: 0, xfb: e) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 1400, 0, 5) * 0.49 * 4;
    }.play;
    // 0.25.wait;
}.fork;

)


(   // cross feedback
{
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(1);
        var d = Demand.kr(t, 0, Dseq([0, -2, 0, 1].stutter(2), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 2].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + d - 12, fm1: 0, xfb: min(e * dd, 1)) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 400, 0, 1) * 8.9 + VadimFilter.ar(sig, 2000, 0, 5) * 4;
    }.play;   // cross feedback
    x.set(\gate, 0, \fadeTime, 0.1);
    // 0.5.wait;
    x = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(4);
        var d = Demand.kr(t, 0, Dseq([0, 12].stutter(16).rotate(-2), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
        var sig = MiOmi.ar(pit: 75 - 12 + d, fm1: 0, xfb: e) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 1400, 0, 5) * 0.49 * 4;
    }.play;
    // 0.25.wait;
}.fork;
)


(   // cross feedback
{
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(1);
        var d = Demand.kr(t, 0, Dseq([0, -2, 0, 1].stutter(2), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 2].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + d - 12, fm1: 0, xfb: min(e * dd * 0.5, 1)) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 1400, 0, 1) * 4.9 * 1;
    }.play;   // cross feedback
    x.set(\gate, 0, \fadeTime, 0.1);
    // 0.5.wait;
    x = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(4);
        var d = Demand.kr(t, 0, Dseq([0, -2].stutter(32).rotate(-2), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
        var sig = MiOmi.ar(pit: 75 - 12 + d, fm1: 0, xfb: e) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 400, 0, 5) * 0.49 * 2;
    }.play;
    // 0.25.wait;
}.fork;
)

(
    x.set(\gate, 0, \fadeTime, 0.1);
    y.set(\gate, 0, \fadeTime, 0.1);
)


(   // cross feedback
{
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(1);
        var d = Demand.kr(t, 0, Dseq([0, -2, 0, 1].stutter(2), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + d - 12, fm1: 0, xfb: min(e * dd * 0.5, 1)) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 1400, 0, 1) * 4.9 * 1;
    }.play;   // cross feedback
    x.set(\gate, 0, \fadeTime, 0.1);
    // 0.5.wait;
    x = {
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(4);
        var d = Demand.kr(t, 0, Dseq([0, 0].stutter(32).rotate(-2), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1]), t);
        var sig = MiOmi.ar(pit: 75 - 12 + d, fm1: 0, xfb: e) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        VadimFilter.ar(sig, 1400, 0, 5) * 0.49 * 2;
    }.play;
    // 0.25.wait;
}.fork;
)