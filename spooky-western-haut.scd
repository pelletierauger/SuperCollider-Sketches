(
v.free;
v = {
    var t = Impulse.kr(0.5);
    var e = EnvGen.kr(Env([0, 1, 0], [2, 2 - 0.1]/2, [4, -8, 'lin']), t).lag(0.125);
    // var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2), inf));
    var d = Demand.kr(t, 0, Dseq([6, 5, 8, 9].stutter(1), inf));
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
        freq: (26+24+12).midicps * 1 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 4,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ] * 0.5
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
    sig = ~v.(sig, 3000,0,5);
    sig = sig + (CombC.ar(sig, 1, ~toFreq.("E0").reciprocal * 4, 6)*0.25);
    // sig = sig + CombC.ar(sig, 1, ~toFreq.("E0").reciprocal * 2, 1);
    // sig = ~v.(sig, 2000,0,5);
    sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 0.5,
        algo: 2, timb: 0.2, osc:2, freq: ~toFreq.("E0"), easteregg:1);
    sig * 1.6*6 * 4 * 4 * Line.kr(0,1,0.125);
}.play;
)



(
v.free;
v = {
    var t = Impulse.kr(0.5);
    var e = EnvGen.kr(Env([0, 1, 0], [2, 2 - 0.1]/2, [4, -8, 'lin']), t).lag(0.125);
    // var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2), inf));
    var d = Demand.kr(t, 0, Dseq([13, 12, 13, 10, 13, 12, 17, 15].stutter(1), inf));
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
        freq: (26+24+0).midicps * 1 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 6,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ] * 0.5
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
    sig = ~v.(sig, 3000,0,5);
    sig = sig + (CombC.ar(sig, 1, ~toFreq.("E0").reciprocal * 4, 6)*0.25);
    // sig = sig + CombC.ar(sig, 1, ~toFreq.("E0").reciprocal * 2, 1);
    // sig = ~v.(sig, 2000,0,5);
    sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 0.5,
        algo: 2, timb: 0.2, osc:3, freq: ~toFreq.("E0"), easteregg:1);
    sig = ~v.(sig, 1000,0,5);
    sig * 1.6*6 * 4 * 8 * 1 * Line.kr(0,1,0.125);
}.play;
)



(
v.free;
v = {
    var t = Impulse.kr(0.5);
    var e = EnvGen.kr(Env([0, 1, 0], [2, 2 - 0.1]/2, [4, -8, 'lin']), t).lag(0.125);
    // var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2), inf));
    var d = Demand.kr(t, 0, Dseq([13, 12, 13, 10, 13, 12, 17, 15].stutter(1), inf));
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
        freq: (26+12+0).midicps * 1 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 6,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ] * 0.5
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
    sig = ~v.(sig, 3000,0,5);
    sig = sig + (CombC.ar(sig, 1, ~toFreq.("E0").reciprocal * 4, 6)*0.25);
    // sig = sig + CombC.ar(sig, 1, ~toFreq.("E0").reciprocal * 2, 1);
    // sig = ~v.(sig, 2000,0,5);
    sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 0.5,
        algo: 2, timb: 0.2, osc:3, freq: ~toFreq.("E0"), easteregg:1);
    sig = ~v.(sig, 3000,0,1);
    sig * 1.6*6 * 4 * 2 * 1 * Line.kr(0,1,0.125);
}.play;
)