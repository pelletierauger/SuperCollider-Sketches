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
        var note = 40 + 24 + d + 48 + 12 + ((0..3) * 6 * 0.025);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.75, model: 37,
            resamp: 2, decim: 16, bits: 3, ws: 0.25
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


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    z.free;
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [2, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + 48 + 12 + ((0..3) * 6 * 0.025);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.75, model: 37,
            resamp: 2, decim: 16, bits: 3, ws: 0.25
        );
        sig = VadimFilter.ar(sig, 1500 * e + 200 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        // sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse.scramble - 1) / 10 * 1);
        sig = Splay.ar(sig);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    z.free;
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [3, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + 48 + 12 + ((0..3) * 6 * 0.025);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.75, model: 37,
            resamp: 2, decim: 2, bits: 6, ws: 0.5
        );
        sig = VadimFilter.ar(sig, 3500 * e + 20 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        // sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse.scramble - 1) / 10 * 0.5);
        sig = Splay.ar(sig);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    z.free;
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [3, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + 48 + 12 + ((0..3) * 6 * 0.025);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.75, model: 37,
            resamp: 2, decim: 2, bits: 6, ws: 0.5
        );
        sig = sig * e * VadimFilter.ar(sig, 3500 * e + 20 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        // sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse.scramble - 1) / 10 * 0.5);
        sig = Splay.ar(sig);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    z.free;
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5, 4, 1].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [3, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + -12 + 12 + ((0..3) * 6 * 0.025);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: SinOsc.kr(0.5).unipolar, model: 43,
            resamp: 2, decim: 2, bits: 6, ws: 0.5
        );
        sig = VadimFilter.ar(sig, 1500 * e + 20 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        // sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse.scramble - 1) / 10 * 0.5);
        sig = Splay.ar(sig);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
});
)