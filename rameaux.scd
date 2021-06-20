(
z.set(\gate, 0, \fadeTime, 1);
z = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 6 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, 2], inf));
    var sig = MiPlaits.ar(
        pitch: 57 + note + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: SinOsc.ar(0.1).range(0.25, 0.5),
        morph: 0.5
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 3200) * 0.25;
    sig;
}.play;
)

(
u.set(\gate, 0, \fadeTime, 1);
u = {
    var t = Impulse.kr(0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 6 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-2, -2], inf));
    var sig = MiPlaits.ar(
        pitch: 57 + note + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: SinOsc.ar(0.1).range(0.25, 0.5),
        morph: 0.5
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 3200) * 0.25;
    sig;
}.play;
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

(
x.free;
x = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -12], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.2
    ) * 0.25 * env;
    sig!2;
}.play;
)
