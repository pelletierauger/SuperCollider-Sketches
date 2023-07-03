
(
x.free;
x = {
    var t = Impulse.kr(4 * -5.midiratio);
    var t2 = t * Demand.kr(t, 0, Dseq((1!1) ++ (0!15), inf));
    var melo = Demand.kr(t, 0,
        Dseq([3,  3, -1, -1,  1,  1, -4, -4,
              4,  4,  3,  3, -1, -1,  2,  2].stutter(8), inf)
    );
    var melo2 = Demand.kr(t2, 0,
        Dseq([10, 11, 16, 15,
              11, 10, 11, 2], inf)
    );
    var melo3 = Demand.kr(t2, 0,
        Dseq([-6,  2, -5, -1,
              -5, -6,  2,  5], inf)
    );
    var melo4 = Demand.kr(t2, 0,
        Dseq([5, 6, 7, 8,
            6, 5, 6, 8].stutter(1), inf)
    );
    var col = Demand.kr(t, 0,
        Dseq([0, 0.2, 0, 0.2].stutter(1), inf)
    );
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1] * 7.midiratio, [0, -12]), gate: t);
    var e2 = EnvGen.kr(Env([0,1,0],[2, 7] * 7.midiratio, [0, -12]), gate: t2);
    var fil = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0].stutter(1), inf));
    var sig = MiBraids.ar(
        pitch: ~toMidi.("D2") - 5 + melo + [0, 12],
        timbre: 0.5 * e * 0.1 + [0.1, 0.2],
        color: 0.5 + col + (fil * 0.1 *e),
        model: [1, 14]
    ).sum;
    var haut = (MiBraids.ar(
        pitch: ~toMidi.("D5") - 5 + [melo2, melo3, melo4 - 12].lag(0.01),
        timbre: 0.5 * e2 * 1,
        color: 0.5 * e2,
        model: [4]
    ) * [1, 1, 4]).sum * e2 * 0.5;
    haut = [haut, DelayC.ar(haut, 0.5, 0.01)];
    haut = MiVerb.ar(haut * 0.25, drywet: 0.5);
    haut = MiWarps.ar(
        haut, haut, lev1: 0.5, lev2: 0.5,
        algo: 2, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0);
    haut = ~v.(haut, 5000 * ~lfo.(4*1.5) + 4000);
    sig = ~v.(sig, 1000 * e + 100 + (fil * 500 * e));
    sig = sig * 0.125 ! 2 + (haut*2);
    sig * 0.5;
}.play;
)

// ----------------------------------------------------------
// L’écorce de bouleau.
// ----------------------------------------------------------
(
w.free;
w = {
    var t = Impulse.kr(0.125);
    var e = EnvGen.kr(Env([0, 1, 0], [0.9, 8 - 0.1] * 2, [2, -8, 'lin']), t).lag(0.125);
    var d = Demand.kr(t, 0, Dseq([0,-4].stutter(2), inf));
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
        freq: 110 * 3.midiratio * 0.5 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 0,
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

    // sig = MiVerb.ar(sig,);
    sig = ~v.(sig, 500,0,5) * 0.5;
    sig = MiWarps.ar(sig, sig, 0.5, 1, 2, 1, osc:0, easteregg:1)[0];
    // sig = MiVerb.ar(sig,0.7, 0.5);
    sig * 1.6*4 * Line.kr(0,1,0.125);
}.play;
)



// ----------------------------------------------------------
// Les billes sur les rayons des roues de vélo.
// ----------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    q.free;
    q = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(31 + 28 + 0 + 12 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.75),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.4;
    }.play;
    t.free;
    t =
    {
        var trig = Impulse.ar(~nT.tempo * 8);
        var sig = MiPlaits.ar(28 + 24 + 5 + -1 + 12 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.75),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.4;
    }.play;
});
)



// ----------------------------------------------------------
// Les billes sur les rayons des roues de vélo, légère disto.
// ----------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    q.free;
    q = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(71 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.75),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        var trig2 = Impulse.ar(~nT.tempo * 8);
        var sig2 = MiPlaits.ar(68 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.75),
            trigger: trig2,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = ~v.(sig2 + sig, 3000, 0, 5) * 0.4;
            sig = MiWarps.ar(
            sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5, lev2: 0.85,
        algo: 3, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 4;
    }.play;
});
)

~toNote.(71)

// ----------------------------------------------------------
// Les billes sur les rayons des roues de vélo, moyenne disto.
// ----------------------------------------------------------



(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    q.free;
    q = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(71 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        var trig2 = Impulse.ar(~nT.tempo * 8);
        var sig2 = MiPlaits.ar(68 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig2,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = ~v.(sig2 + sig, 3000, 0, 5) * 0.4;
            sig = MiWarps.ar(
            sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5, lev2: 0.85,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 4;
    }.play;
});
)

// ----------------------------------------------------------
// Les billes sur les rayons des roues de vélo, forte disto.
// ----------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    q.free;
    q = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(71 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        var trig2 = Impulse.ar(~nT.tempo * 8);
        var sig2 = MiPlaits.ar(68 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig2,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = ~v.(sig2 + sig, 3000, 0, 5) * 0.4;
            sig = MiWarps.ar(
            sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.85,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    }.play;
});
)