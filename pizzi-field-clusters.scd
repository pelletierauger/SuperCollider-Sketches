(
~c.schedAbs(~c.nextBar, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~c.tempo / 6) * trigGate;
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
        sig = MiRings.ar(
            sig, pit: 24 + 24 + d.lag(3), struct: 0.2, damp: 0.3, pos: 0.5, model: 3, poly: 1) * 2;
        Out.ar(0, sig * 4 * 1);
    }.play;
});
)


(
~c.schedAbs(~c.nextBar, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~c.tempo / 6) * trigGate;
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
        sig = MiRings.ar(
            sig, pit: 24 + 24 + d.lag(3), struct: 0.2, damp: 0.3, pos: 0.5, model: 3, poly: 1) * 2;
        Out.ar(0, sig * 4 * 1);
    }.play;
});
)


(
~c.schedAbs(~c.nextBar, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~c.tempo / 6) * trigGate;
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
        sig = MiRings.ar(
            sig, pit: 24 + -12 + d.lag(3), bright: 0.5, struct: 0.2, damp: 0.2, pos: 0.5, model: 1, poly: 1) * 2;

        sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 1);
    }.play;
});
)