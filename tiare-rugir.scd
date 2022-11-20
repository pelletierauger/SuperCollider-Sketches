(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = ~toMidi.("D1") + 24 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.025, color: 0.5, model: 21
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        var sig2, sig3;
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig, 0.75, 0.75, algo: 4, timb: 0.2)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig, 0.75, 0.75, algo: 4, timb: 0.2)[0]);
    sig = [sig2, sig3];
        // sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)



(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = ~toMidi.("D1") + 24 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.025, color: 0.5, model: 21
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        var sig2, sig3;
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig, 0.75, 0.75, algo: 2, timb: 0.2)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig, 0.75, 0.75, algo: 2, timb: 0.2)[0]);
    sig = [sig2, sig3];
        sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)


(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = ~toMidi.("D1") + 24 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.025, color: 0.5, model: 21
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        var sig2, sig3;
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 100, 0, 5) * 0.1;
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig, 0.75, 0.75, algo: 1, timb: 0.9)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig, 0.75, 0.75, algo: 1, timb: 0.9)[0]);
    sig = [sig2, sig3] * 0.025;
        // sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)



(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = ~toMidi.("D1") + 12 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.025, color: 0.5, model: 21
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        var sig2, sig3;
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 100, 0, 5) * 0.1;
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig, 0.75, 0.75, algo: 1, timb: 0.9)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig, 0.75, 0.75, algo: 1, timb: 0.9)[0]);
    sig = [sig2, sig3] * 0.025;
        sig = VadimFilter.ar(sig, 5000, 0, 1);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)




(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = ~toMidi.("D1") + 12 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.025, color: 0.5, model: 0
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        var sig2, sig3;
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 100, 0, 5) * 0.1;
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig, 0.75, 0.75, algo: 1, timb: 0.9)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig, 0.75, 0.75, algo: 1, timb: 0.9)[0]);
    sig = [sig2, sig3] * 0.025;
        sig = VadimFilter.ar(sig, 5000, 0, 1);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)



(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = ~toMidi.("D1") + 12 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.025, color: 0.5, model: 37
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        var sig2, sig3;
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 100, 0, 5) * 0.1;
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig, 0.75, 0.75, algo: 1, timb: 0.9)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig, 0.75, 0.75, algo: 1, timb: 0.9)[0]);
    sig = [sig2, sig3] * 0.025;
        sig = VadimFilter.ar(sig, 3000, 0, 5);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)