(
z.free;
z = {
    var trig = Impulse.kr(0.5);
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.99], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 48!2 - 36 + 24,
        timbre: 0.45 + lfo,
        color: 0.0 + dem2,
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    );
    sig = LPF.ar(sig, 2000);
    // sig = LPF.ar(sig, 2000) * env;
    // sig = sig + (LPF.ar(CombL.ar(sig, 0.05, (notes + 0).midicps.reciprocal, 4), 1000) * 0.4);
    sig * 0.75 * 0.5 * 0.4 * 2.5;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)

(
x.free;
x = {
    var f = 54 - 24 - 5;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    [sig1[0], sig2[0]] * 2.5;
}.play;
)


(
h.free;
h = {
    var trig = Impulse.kr(0.5);
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.8], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 48!2 + 12,
        timbre: 0.01 + lfo,
        color: 0.0 + dem2,
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0.4
    );
    sig = HPF.ar(sig, 1000);
    // sig = LPF.ar(sig, 2000) * env;
    // sig = sig + (LPF.ar(CombL.ar(sig, 0.05, (notes + 0).midicps.reciprocal, 4), 1000) * 0.4);
    sig * 0.75 * 0.5 * 0.1;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)
