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
v.free;
v = {
    var t = Impulse.kr(0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [0.9, 2 - 0.1].reverse, [2, -8, 'lin']), t).lag(0.125);
    var d = Demand.kr(t, 0, Dseq([0, -4].stutter(2), inf));
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
        freq: 110 * 0.5 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 12,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 2000 * e + 100, 0.5, 1);
            sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25 + (si*0.7), algo: 4, timb: 0.8 + si)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25 + (si*0.7), algo: 4, timb: 0.8 + si)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 0, 0, 3) * 1;
        sig = sig * 0 + (sig3 * Demand.kr(t!2, 0, Dwhite(0.5, 1.00, inf)).lag(1));

    // sig = MiVerb.ar(sig, time: 1, drywet: 1, damp: 0.7);
    sig = ~v.(sig, 2000,0,3);
    sig = MiWarps.ar(sig, sig, 0.5, 1, 2, 1, osc:0, easteregg:1);
    DelayN.ar(sig * 1.6*1 * Line.kr(0,1,0.125), 2, 1);
}.play;
~met.free;
~met = {
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([1, 0.5].reverse, inf));
    var d2 = Demand.kr(t, 0, Dwhite(0.2, 0.7, inf));
    var d3 = Demand.kr(t, 0, Dseq([0, 0.5].stutter(16), inf));
    var d4 = Demand.kr(t, 0, Dseq([0.2, 0.4].stutter(32), inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.001, 2*d], [2, -16]), t);
    var sig = PinkNoise.ar() * e;
    var scra;
    sig = ~v.(sig, 100, 0, 5);
    sig = MiWarps.ar(sig, sig,
        lev1: 0.75, lev2: 0.75,
        algo: 2, timb: 0.25,
        osc:0, easteregg:0
    )[0] * 16 * 4;
    scra = sig;
    sig = (sig*0.25) + MiRings2.ar(sig, pit: ~toMidi.("E2"), struct: d4, damp: d2, pos: 1-d2, model:4) * 0.4;
    sig = ~v.(sig, 1000) * 16 + (scra*0.25) + sig;
    sig = sig + CombC.ar(~v.(sig,4000), 4, 1/8, 4);
    sig * 0.1 ! 2;
}.play;
)





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
~met.free;
~met = {
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([1, 0.5].reverse, inf));
    var d2 = Demand.kr(t, 0, Dwhite(0.2, 0.7, inf));
    var d3 = Demand.kr(t, 0, Dseq([0, 0.5].stutter(16), inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.001, 2*d], [2, -16]), t);
    var sig = PinkNoise.ar() * e;
    sig = ~v.(sig, 100, 0, 5);
    sig = MiWarps.ar(sig, sig,
        lev1: 0.75, lev2: 0.75,
        algo: 2, timb: 0.25,
        osc:0, easteregg:0
    )[0] * 16 * 4;
    sig = (sig*0.25) + MiRings.ar(sig, pit: ~toMidi.("E3"), struct: 0, damp: d2, pos: 1-d2, model:1) * 0.4;
    sig * 0.1 ! 2;
}.play;
)
