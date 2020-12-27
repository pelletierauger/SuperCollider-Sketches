(
// h.free;
h.set(\gate, 0, \fadeTime, 1);
h = {
    var trig = Impulse.kr(0.5);
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.8], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.5);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 36!2 + -12,
        timbre: 0.0 + lfo,
        color: 0,
        model: 2,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0.0
    );
    // sig = HPF.ar(sig, 4500);
    sig = LPF.ar(sig, 1000);
    // sig = sig + (LPF.ar(CombL.ar(sig, 0.05, (notes + 0).midicps.reciprocal, 4), 1000) * 0.4);
    sig * 0.75 * 0.5 * 0.1 * 0.5 * 2 * 4;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)