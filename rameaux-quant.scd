~t = TempoClock.new(80/60).permanent_(true);

(
~t.sched(~t.timeToNextBeat(quant: 2), {
    z.set(\gate, 0, \fadeTime, 1);
    z = {
        var t = Impulse.kr(~t.beatDur.reciprocal * 0.25);
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
        var note = Demand.kr(t, 0, 57 + Dseq([-2, 0], inf));
        var sig = MiPlaits.ar(
            pitch: note + [0, 0.01],
            engine: 2,
            harm: 0.5,
            timbre: SinOsc.ar(0.1).range(0.25, 0.5),
            // timbre: 0.35,
            morph: 0.5
        ) * 0.5 * env;
        sig = [sig[0][0], sig[1][0]];
        // sig = [sig[0][1], sig[1][1]] * 0.5 + [sig[0][0], sig[1][0]];
        // sig = LPF.ar(sig, 500) * 4;
        sig = sig * 0.25;
        sig;
    }.play;
});
)

(
~t.sched(~t.timeToNextBeat(quant: 1), {
    u.set(\gate, 0, \fadeTime, 1);
    u = {
        var t = Impulse.kr(~t.beatDur.reciprocal * 0.125);
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 16 - 0.2], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-2, 7], inf));
        var sig = MiPlaits.ar(
            pitch: 57 + note + [0, 0.01],
            engine: 2,
            harm: 0.5,
            timbre: SinOsc.ar(6).range(0.25, 0.5),
            timbre: 0.25,
            morph: 0.5
        ) * 0.5 * env;
        sig = [sig[0][1], sig[1][1]] * 0.5 + [sig[0][0], sig[1][0]];
        sig = LPF.ar(sig, 13200) * 0.5;
        sig;
    }.play;
});
)

(
~t.sched(~t.timeToNextBeat(quant: 2), {
    w.set(\gate, 0, \fadeTime, 1);
    w = {
        var t = Impulse.kr(~t.beatDur.reciprocal * 0.25);
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 9 - 0.2], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, 57 + Dseq([-4, -2], inf));
        var sig = MiPlaits.ar(
            pitch: note + [0, 0.01],
            engine: 2,
            harm: 0.5,
            timbre: SinOsc.ar(6).range(0.25, 0.5),
            morph: 0.5
        ) * 0.5 * env;
        sig = [sig[0][1], sig[1][1]] * 0.5 + [sig[0][0], sig[1][0]];
        sig = LPF.ar(sig, 13200) * 0.25;
        sig;
    }.play;
});
)


(
~t.sched(~t.timeToNextBeat(quant: 2), {
    x.set(\gate, 0, \fadeTime, 1);
    x = {
        var t = Impulse.kr(~t.beatDur.reciprocal * 0.25);
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
        var note = Demand.kr(t, 0, 57 + 3 + Dseq([-5, -12], inf));
        var sig = MiPlaits.ar(
            pitch: note,
            engine: 2,
            harm: 0.25,
            timbre: 0.0,
            morph: 0.2
        ) * 0.5 * env;
        sig!2;
    }.play;
});
)

(
a.set(\gate, 0, \fadeTime, 1);
a = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.25, 6 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-7, -12], inf));
    var sig = MiPlaits.ar(
        pitch: 57 + note + [0, 0.02],
        engine: 2,
        harm: 0.0,
        timbre: SinOsc.ar(0.5 + env * 0.5).range(0.25, 0.5),
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 400) * 1;
    sig;
}.play;
)

[z, u, w, v, n, m, o, ~noLowB, x].do({|i| i.set(\gate, 0, \fadeTime, 10)});