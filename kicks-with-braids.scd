(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    // var ff = Impulse.kr(0.01).range(1, 4);
    var t = Impulse.kr(0.25 * 4);
    var dem = Demand.kr(t, 0, Dseq((0.125)!3 ++ (0.75!1), inf));
    var dem2 = Demand.kr(t, 0, Dseq((0)!3 ++ (1000!1), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.05, 2.5], [-8, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, 2, -5].rotate(2).reverse, inf));
    var in = MiBraids.ar(48 * env + 12, timbre: 0.25, color: 0.5, model: 12);
        cutoff = 5 + (2000 * env);
    VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2!2 * 0.5 * env.pow(3);
    // LPF.ar(in, cutoff)!2;
}.play;
)


(
z.set(\gate, 0, \fadeTime, 0.1);
z = {
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    // var ff = Impulse.kr(0.01).range(1, 4);
    var t = Impulse.kr(0.25 * 4);
    var dem = Demand.kr(t, 0, Dseq((0.125)!3 ++ (0.75!1), inf));
    var dem2 = Demand.kr(t, 0, Dseq((0)!3 ++ (1000!1), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.5, 0.5], [-8, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, 2, -5].rotate(2).reverse, inf));
    var in = MiBraids.ar(12 * env + 12 + 12, timbre: 0.5, color: 0.25, model: 29);
        cutoff = 5 + (9000 * env);
    VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2!2 * 0.5 * env.pow(3);
    // LPF.ar(in, cutoff)!2;
}.play;
)