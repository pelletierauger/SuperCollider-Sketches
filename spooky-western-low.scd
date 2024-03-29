(
w.free;
w = {
    var t = Impulse.kr(0.25 * 0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [0.9, 8 - 0.1] * 4, [2, -8, 'lin']), t).lag(0.125);
    // var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2), inf));
    var d = Demand.kr(t, 0, Dseq([6, 5, 3, 2].stutter(1), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 1;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var sig2, sig3;
    var scr = Demand.kr(t!2, 0, Dwhite(0.5, 1.00, inf)).lag(2);
    var sta = Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
    var sto = Demand.kr(sta, 0, Dwrand([0, 1], [0.1, 0.9], inf));
    var si = 1 - sto * 0.5;

    var sig = HarmonicOsc.ar(
        freq: (26+ -12).midicps * 1 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ] * 0.1
    );
    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 2000 * e + 100, 0.5, 1);
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25 + (si*0.7), algo: 4, timb: 0.2 + si)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25 + (si*0.7), algo: 4, timb: 0.2 + si)[0]);
    sig3 = [sig2, sig3] * 0.5;
    sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 0, 0, 3) * 1;
    sig = sig * 0 + (sig3 * Demand.kr(t!2, 0, Dwhite(0.50, 1.00, inf)).lag(1));

    // sig = MiVerb.ar(sig,);
    sig = ~v.(sig, 2000,0,1);
    sig = sig + CombC.ar(sig, 1, ~toFreq.("E0").reciprocal * 4, 6);
    // sig = ~v.(sig, 5000,0,1);
    sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 1,
        algo: 1, timb: 0.4, osc:1, freq: ~toFreq.("E0"), easteregg:1);
    // sig = ~v.(sig, 1000,0,1);
    sig * 1.6*2 * Line.kr(0,1,0.125) * 1;
}.play;
)



(
w.free;
w = {
    var t = Impulse.kr(0.25 * 0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [0.9, 8 - 0.1] * 4, [2, -8, 'lin']), t).lag(0.125);
    // var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2), inf));
    var d = Demand.kr(t, 0, Dseq([6, 5, 3, 2].stutter(1), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 1;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var sig2, sig3;
    var scr = Demand.kr(t!2, 0, Dwhite(0.5, 1.00, inf)).lag(2);
    var sta = Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
    var sto = Demand.kr(sta, 0, Dwrand([0, 1], [0.1, 0.9], inf));
    var si = 1 - sto * 0.5;

    var sig = HarmonicOsc.ar(
        freq: (26+ -12).midicps * 1 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ] * 0.1
    );
    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 2000 * e + 100, 0.5, 1);
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25 + (si*0.7), algo: 4, timb: 0.2 + si)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25 + (si*0.7), algo: 4, timb: 0.2 + si)[0]);
    sig3 = [sig2, sig3] * 0.5;
    sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 0, 0, 3) * 1;
    sig = sig * 0 + (sig3 * Demand.kr(t!2, 0, Dwhite(0.50, 1.00, inf)).lag(1));

    // sig = MiVerb.ar(sig,);
    sig = ~v.(sig, 2000,0,1);
    sig = sig + CombC.ar(sig, 1, ~toFreq.("E0").reciprocal * 4, 6);
    // sig = ~v.(sig, 5000,0,1);
    sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 1,
        algo: 1, timb: 0.4, osc:1, freq: ~toFreq.("E0"), easteregg:1);
    sig = ~v.(sig, 1000,0,1);
    sig * 1.6*2 * Line.kr(0,1,0.125) * 1;
}.play;
)