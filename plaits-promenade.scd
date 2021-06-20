(
y.set(\gate, 0, \fadeTime, 1);
y = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.1, 4 - 0.2], ['lin', 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([2, -5], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + [0, 0.01],
        engine: 2,
        harm: 0.0,
        timbre: 1,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, SinOsc.ar(6).range(1400, 4400)) * 0.5;
    sig;
}.play;
)

(
g.set(\gate, 0, \fadeTime, 1);
g = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.1, 4 - 0.2], ['lin', 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([2, 0], inf));
    var sig = MiPlaits.ar(
        pitch: 60 - 48 + note + [0, 0.01],
        engine: 0,
        harm: 0.0,
        timbre: 1,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, SinOsc.ar(6).range(1400, 4400)) * 0.5;
    sig;
}.play;
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