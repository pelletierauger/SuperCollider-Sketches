
(   // some bowing
~nT.sched(~nT.timeToNextBeat(quant: 8), {
{
    | trigGate = 1, relGate = 0 |
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var t = Impulse.kr(~nT.tempo * 0.125) * trigGate;
    var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));

    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, 0]), t).lag(0.95);

    var sig = MiElements.ar(
        gate: 1,
        pit: 28 + 12 + d.lag(1.5),
        contour: 0.5,
        bow_level: e,
        bow_timb: 0.5,
        geom: 0.25,
        bright: 0.75,
        damp: 0.2,
        pos: 0.4,
        space: 0.3,
        model: 1
    );
    sig = sig * 8;
    sig;
}.play;
});
)


//  Le chateau

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
x.free;
x = {
        var t = Impulse.kr(~nT.tempo * 1);
    var d = Demand.kr(t, 0, Dseq([
            7, 7, 8, 8, 7, 7, 5, 5,
            3, 3, 5, 5, 2, 3, 7, 5

        ].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq([0,-5].stutter(16), inf));

    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.25], [-8, 0]), t).lag(0.95);

        var sig = MiBraids.ar(28 + [d2, d + 12] + 12, [0.25, 0.5], 1 - e * 0.25, model: 14);
    sig = sig[0] + sig[1];
    sig = VadimFilter.ar(sig,  500 + (1500 * e), 0, 1);
    sig = sig * 0.2!2;
    sig;
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    // var ff = Impulse.kr(0.01).range(1, 4);
    var t0 = Impulse.kr(~nT.tempo * 0.5 * 4);
       var t = t0 * Demand.kr(t0, 0, Dseq(
            [
       //       |     ;     |     ;
                1, 0, 0, 0, 0, 0, 1, 0,
                0, 0, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 1, 0,
                0, 0, 1, 0, 1, 0, 0, 1

        ], inf));
    var dem = Demand.kr(t, 0, Dseq((0.125)!3 ++ (0.75!1), inf));
    var dem2 = Demand.kr(t, 0, Dseq((0)!3 ++ (1000!1), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5], [-8, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, 2, -5].rotate(2).reverse, inf));
    var in = MiBraids.ar(
        48, timbre: 0.75, color: 0.5, model: 34, trig: t,
            resamp: 0, decim: 16, bits: 5, ws: 1 - env.lag(0.5) * 0.125
        );
        cutoff = 5 + (8000 * env.lag(0.5));
    VadimFilter.ar(
        input: in,
        freq: cutoff,
        resonance: 0,
        type: 1
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2!2 * 0.4;
    // LPF.ar(in, cutoff)!2;
}.play(fadeTime: 0);
});
)







(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
x.free;
x = {
        var t = Impulse.kr(~nT.tempo * 1);
    var d = Demand.kr(t, 0, Dseq([
            7, 7, 8, 8, 7, 7, 5, 5,
            3, 3, 5, 5, 2, 3, 7, 5

        ].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq([0,-5].stutter(16), inf));

    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.25], [-8, 0]), t).lag(0.95);

        var sig = MiBraids.ar(
            28 + [d2, d + 12] + 24, [0.25, 0.25], 1 - e * 0.5 + 0.2,
            model: 21);
    sig = sig[0] + sig[1];
        // sig = VadimFilter.ar(sig,  4500 + (4500 * e), 0, 1);
    sig = sig * 0.4!2;
    sig;
}.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
y.free;
y = {
        var t = Impulse.kr(~nT.tempo * 1);
    var d = Demand.kr(t, 0, Dseq([
            7, 7, 8, 8, 7, 7, 5, 5,
            3, 3, 5, 5, 2, 3, 7, 5

        ].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq([0,-5].stutter(16), inf));

    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.25], [-8, 0]), t).lag(0.95);

        var sig = MiBraids.ar(
            28 + [d2, d + 12] + 12, [0.25, 0.25], 1 - e * 0.5 + 0.2,
            model: 21);
    sig = sig[0] + sig[1];
        // sig = VadimFilter.ar(sig,  4500 + (4500 * e), 0, 1);
    sig = sig * 0.4!2;
    sig;
}.play;
});
)