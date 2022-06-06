(
~nT.schedAbs(~nT.nextBar + 0.5 - 0.12, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [3, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 24 + 24 + d + 24 + ( [0, 6, 12, 18, 24, 30, 36] * 0.1 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: 0, color: 0.5, model: 0
        );
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 1500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 10);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)


// Les voix aigües et fantomatiques

(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 24 + 24 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.025, color: 0.5, model: 21
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        Out.ar(0, sig * 4 * 8);
    }.play;
});
)


(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 24 + 12 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.027, color: 0.25, model: 4
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 8);
    }.play;
});
)

(
y.free;
y = {
    var f = 24;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    [sig1[0], sig2[0]] * 0.5;
}.play;
)

// https://subscription.packtpub.com/book/application-development/9781783289677/1/ch01lvl1sec08/plotting-audio-numerical-datasets-and-functions

(
a = Plotter("the plot", Rect(50, 200, 1200, 450));
a.superpose_(true);
~notes = (0..6) * 6;
~notes = ~notes ++ (~notes + 1) ++ (~notes + 2);
// a.value = (0..1000).normalize(0, 14pi).curdle(0.01).scramble.sin;
a.value = ~notes.collect({
    |i| Env(
        i * [0, 1, 0].wrapExtend(3 * 4) * 0.1 + [0, 3, 6, 3].stutter(3) + 48,
        [3, 24, 0].wrapExtend(3 * 4),
        [-8, -2, 0].wrapExtend(3 * 4)).asSignal(length: 400);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [3, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 24 + 24 + d + 0 + (((0..6) * 2) * 0.1 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: 0.25  + 0.5, color: 0.25, model: 22
        );
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 10);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4 * 4);
    }.play;
});
)







(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [3, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 24 + 24 + d + 24 + ( [0, 6, 12, 18, 24, 30, 36] * 0.1 * e);
        var sig = note ++ (note + (shift * e))  ++ (note + (shift + 1 * e));
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        // sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
    // sig = DelayN.ar(sig, 4, (1..21).scramble / 10);
        // sig = Splay.ar(sig.scramble);
        // sig = sig * Line.kr(0, 1, 1);
        // Out.ar(0, sig * 0.4);
    // sig[0];
    note + (shift * e);
    }.plot(3);
// });
)




