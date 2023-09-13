(
u.free;
u = {
    var t = Impulse.kr(0.25);
    var t2 = Impulse.kr(1);
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
    sig * 0.05 * Line.kr(0,1,0.125)*1 + (K2A.ar(t2)*0);
}.play;

~met.free;
~met = {
    var b = Impulse.kr(3);
    var t = b * Demand.kr(b, 0, Dseq([1, 0, 1, 1, 1, 0], inf));
    var d = Demand.kr(t, 0, Dseq([1, 0.5].reverse, inf));
    var d2 = Demand.kr(t, 0, Dwhite(0.2, 0.7, inf));
    var d3 = Demand.kr(t, 0, Dseq([0, 0.5].stutter(16), inf));
    var d4 = Demand.kr(b, 0, Dseq([0.2, 0.4].stutter(24), inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.001, 12*d], [2, -16]), t);
    var sig = PinkNoise.ar() * e;
    var scra;
    sig = ~v.(sig, 100, 0, 5);
    sig = MiWarps.ar(sig, sig,
        lev1: 0.75, lev2: 0.75,
        algo: 2, timb: 0.25,
        osc:0, easteregg:0
    )[0] * 1 * 1;
    scra = sig;
    sig = (sig*0.25) + MiRings2.ar(sig, pit: ~toMidi.("E2"), struct: d4, damp: d2, pos: 1-d2, model:4) * 0.4;
    sig = ~v.(sig, 1000) * 16 + (scra * 0.25) + sig;
    sig = sig + CombC.ar(~v.(sig,4000), 4, 1/8, 4);
    sig * 0.5 ! 2;
}.play;
)