// Le tempo très rapide, frénétique.

~nT = TempoClock.new(3.5).permanent_(true);
~nT.tempo;
~nT.tempo = 3.5;


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback
    ~basse.set(\relGate, 3, \trigGate, 0);
    ~basse = {
        | trigGate = 1, relGate = 0 |
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(8), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));
        var dec = Demand.kr(t, 0, Dseq(Dseries(0.1, 1/16, 16), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t).lag(0.1);
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(0.95);
        var sig = MiOmi.ar(
            pit: 76 - 36 + d,
            level1: 0.5,
            level2: 1,
            detune: 0.25,
            // detune: Demand.kr(t, 0, Dseq([0.25, 0.5, 0.25, 0.995].stutter(2), inf)),
            fm1: e * 0.125 * d5,
            fm2: 0.25,
            // filter_mode: 0.75,
            cutoff: 0.5 * (d5 / 8),
            xfb: min(e * dd * 0.25, 1),
            space: 1
        ) * 0.8 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        // sig = GVerb.ar(sig) * 0.1;

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
        sig = VadimFilter.ar(sig, 3400, 0, 1) * 1.5 * 0.5 * amp;
        Out.ar(0, sig);
    }.play(fadeTime: 0).register;   // cross feedback
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback
    ~basse.set(\relGate, 3, \trigGate, 0);
    ~basse = {
        | trigGate = 1, relGate = 0 |
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(8), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));
        var dec = Demand.kr(t, 0, Dseq(Dseries(0.1, 1/16, 16), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t).lag(0.1);
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(0.95);
        var sig = MiOmi.ar(
            pit: 76 - 36 + d + [0, 12],
            level1: 0.5,
            level2: 1,
            detune: 0.25,
            // detune:[0.25, 0.995],

            // detune: Demand.kr(t, 0, Dseq([0.25, 0.5, 0.25, 0.995].stutter(2), inf)),
            fm1: e * 0.125 * d5,
            fm2: 0.25,
            // filter_mode: 0.75,
            cutoff: 0.5 * (d5 / 8),
            xfb: min(e * dd * 0.25, 1),
            space: 1
        ) * 0.8 * e;
        sig = [sig[0][0] + sig[1][0], sig[1][0] + sig[1][1]];
        // sig.poll;
        sig = Sanitize.ar(sig);
        // sig = GVerb.ar(sig) * 0.1;

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
        sig = VadimFilter.ar(sig, 3400, 0, 1) * 1.5 * amp;
        Out.ar(0, sig);
    }.play(fadeTime: 0).register;   // cross feedback
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback
    ~basse.set(\relGate, 3, \trigGate, 0);
    ~basse = {
        | trigGate = 1, relGate = 0 |
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(8), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));
        var dec = Demand.kr(t, 0, Dseq(Dseries(0.1, 1/16, 16), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, dddd]), t).lag(0.1);
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(1.5);
        var sig = MiOmi.ar(
            pit: 76 - 36 - 12 + d,
            level1: 0.5,
            level2: 1,
            detune: 0.995,
            ratio1: 0.5,
            ratio2: 0.5,
            // detune: Demand.kr(t, 0, Dseq([0.25, 0.5, 0.25, 0.995].stutter(2), inf)),
            fm1: e * 0.125 * d5,
            fm2: 0.5,
            // filter_mode: 0.75,
            cutoff: 0.5 * (d5 / 8),
            xfb: min(e * dd * 0.25, 1),
            space: 1
        ) * 0.8 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);
        // sig = GVerb.ar(sig) * 0.1;

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
        sig = VadimFilter.ar(sig, 1400, 0, 1) * 1.5 * 0.5 * amp;
        Out.ar(0, sig);
    }.play(fadeTime: 0).register;   // cross feedback
});
)