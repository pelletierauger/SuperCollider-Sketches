
~nT = TempoClock.new(3.5).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [1, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 48 + [0, 6, 12, 18, 24, 30, 36];
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1),
            timbre: 0.5, color: 0.5, model: 1
        );
        sig = sig.sum;
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.1!2);
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [1, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 36 + [0, 6, 12, 18, 24, 30, 36];
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1),
            timbre: 0.5, color: 0.5, model: 9
        );
        // sig.size.poll;
        sig = DelayN.ar(sig, 1, (1..21).reverse / 10);
        sig = sig.sum;
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.1!2);
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [1, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 24 + [0, 6, 12, 18, 24, 30, 36];
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1),
            timbre: 0, color: 0.5, model: 14
        );
        // sig.size.poll;
        sig = DelayN.ar(sig, 1, (1..21).reverse / 10);
        sig = sig.sum * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.1!2);
    }.play;
});
)


// Stereo test

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [1, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 24 + [0, 6, 12, 18, 24, 30, 36];
        var sig = MiBraids.ar(
            pitch: [
                note ++ (note + shift)  ++ (note + shift + 1),
                note ++ (note + shift)  ++ (note + shift + 1) + 0.1
            ],
            timbre: 0, color: 0.5, model: 14
        );
        sig = [sig[0].sum, sig[1].sum];
        // Splay
        // sig.size.poll;
        sig = DelayN.ar(sig, 1, (1..21).reverse / 10);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.1);
    }.play;
});
)


// Bas, doux

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [1, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 24 + [0, 6, 12, 18, 24, 30, 36];
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1),
            timbre: 0, color: 0.5, model: 14
        );
        // sig = [sig[0].sum, sig[1].sum];
        sig = DelayN.ar(sig, 4, (1..21).reverse / 10);
        sig = Splay.ar(sig);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)


// Assez haut, mais doux.

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [1, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 48 + [0, 6, 12, 18, 24, 30, 36];
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1),
            timbre: 0, color: 0.5, model: 15
        );
        // sig = [sig[0].sum, sig[1].sum];
        sig = DelayN.ar(sig, 4, (1..21).reverse / 10);
        sig = Splay.ar(sig);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [4, 6], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 48 + [0, 6, 12, 18, 24, 30, 36];
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1),
            timbre: 0, color: 0.5, model: 17
        );
        // sig = [sig[0].sum, sig[1].sum];
        sig = DelayN.ar(sig, 4, (1..21) / 10);
        sig = Splay.ar(sig);
        // sig.size.poll;
        // sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)


// ----------------------------------------------------------------------------
// Escalier infernal
// ----------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 36 + 12 + ((0..3) * 6);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.1, model: 43
        );
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 2);
        sig = Splay.ar(sig);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)

// ----------------------------------------------------------------------------
// Jazzy
// ----------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.free;
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [1, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4], inf));
        var note = 36 + 24 + ((0..3) * 6);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.5, model: 37
        );
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 1);
        sig = Splay.ar(sig);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)


(0..10) + [0, 1, 2, 4]


// ----------------------------------------------------------------------------
// Fantômatique, nasal, shining-esque
// ----------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    z.free;
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5, 3, 7].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [2, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 40 + 12 + d + ((0..3) * 6 * 0.1);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.75, model: 37
        );
        sig = VadimFilter.ar(sig, 1500 * e + 200 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 1);
        sig = Splay.ar(sig);
        sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)


// ----------------------------------------------------------------------------
// Fantômatiques, le meilleur
// ----------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    z.free;
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5, 3, 7].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [2, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + ((0..3) * 6 * 0.025);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.75, model: 37,
            resamp: 2, decim: 16, bits: 3, ws: 0
        );
        sig = VadimFilter.ar(sig, 1500 * e + 200 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 1);
        sig = Splay.ar(sig);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)


// Bas, doux

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [1, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 24 + ( [0, 6, 12, 18, 24, 30, 36] * 0.1);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1),
            timbre: 0, color: 0.5, model: 14
        );
        // sig = [sig[0].sum, sig[1].sum];
        sig = DelayN.ar(sig, 4, (1..21).reverse / 10);
        sig = Splay.ar(sig);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)
