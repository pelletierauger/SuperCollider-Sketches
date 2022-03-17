
(
~t.sched(~t.timeToNextBeat(quant: 6) + (~t.beatDur * 3), {
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        var t = Impulse.kr(~t.tempo * 0.25);
        var env = EnvGen.kr(Env([0, 1, 0], [0.1, 4 - 0.2], ['lin', 'lin', 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([0, -2], inf));
        var lfo = SinOsc.kr(~t.tempo * 2).range(1400, 4400);
        var sig = MiPlaits.ar(
            pitch: 60 + note + [0, 0.01],
            engine: 2,
            harm: 0.0,
            timbre: 1,
            morph: 1
        ) * 0.5 * env;
        sig = [sig[0][0], sig[1][0]];
        sig = VadimFilter.ar(sig, 2000 + lfo, 0, 1) * 0.5;
        sig;
    }.play;
});
)

(
~t.sched(~t.timeToNextBeat(quant: 6) + (~t.beatDur * 0), {
    g.set(\gate, 0, \fadeTime, 0.1);
    g = {
        var tempo = ~t.tempo * 2;
        var r = tempo.reciprocal;
        var trig = Impulse.kr(tempo);
        var t = trig * Demand.kr(trig, 0, Dseq([1] ++ (0!11), inf));
        var env = EnvGen.kr(Env([0.5, 1, 0.5], [0.01, r * 0.25 - 0.01], ['lin', 'lin', 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([0, -2, -5].stutter(4), inf));
        var note2 = Demand.kr(t, 0, Dseq([0, 1, 3], inf)).lag(0.05);
        var lfo = SinOsc.kr(~t.tempo * 4).range(1400, 4400);
        var lfo2 = SinOsc.kr(~t.tempo * 2).range(0, 1);
        var sig = MiPlaits.ar(
            pitch: 60 - 12 + 24 + note + [0, 0.01],
            engine: 2,
            harm: note2 / 3,
            timbre: note2 / 3,
            morph: (note2 / 3)
        ) * 0.5 * env;
        sig = [sig[0][0], sig[1][0]];
        sig = VadimFilter.ar(sig, 10 + (lfo + 4000 * env), 0, 1) * 0.5;
        sig;
    }.play;
});
)

(
h.set(\gate, 0, \fadeTime, 1);
h = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.1, 4 - 0.2], ['lin', 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([2, 0] - 24, inf));
    var sig = MiPlaits.ar(
        pitch: 60 - 12 + note + [0, 0.01],
        engine: 4,
        harm: 1,
        timbre: 0.25,
        morph: 0.95
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, SinOsc.ar(6).range(400, 14400)) * 2;
    sig;
}.play;
)


(
h.set(\gate, 0, \fadeTime, 1);
h = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.1, 4 - 0.2], ['lin', 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([2, 0] - 0, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + 12 + note + [0, 0.01],
        engine: 9,
        harm: 0.95,
        timbre: 0.5,
        morph: 0.9
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, SinOsc.ar(0.5).range(1400, 4400)) * 1;
    sig;
}.play;
)