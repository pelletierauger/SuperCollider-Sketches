(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -12, -10, -17], inf));
    var morph = Demand.kr(t, 0, Dseq([0.2, 0.7], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 24,
        engine: 2,
        harm: 0.25,
        timbre: env * 0.35,
        morph: morph
    ) * 0.5 * env;
    sig[1]!2;
}.play;
u.set(\gate, 0, \fadeTime, 0.1);
u = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-2, -5], inf));
    var morph = Demand.kr(t, 0, Dseq([0.2, 0.2], inf));
    var panA = Demand.kr(t, 0, Dseq([1, 1.001], inf));
    var panB = Demand.kr(t, 0, Dseq([1, 1.001].reverse, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 24 * [panA, panB],
        engine: 2,
        harm: 0.25,
        timbre: env * 0.35,
        morph: morph
    ) * 0.5 * env;
    [sig[0][1], sig[1][1]] * 0.25;
}.play;
v.set(\gate, 0, \fadeTime, 0.1);
v = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-10, -9, -7, -9], inf));
    var morph = Demand.kr(t, 0, Dseq([0.2, 0.2], inf));
    var panA = Demand.kr(t, 0, Dseq([1, 1.001], inf));
    var panB = Demand.kr(t, 0, Dseq([1, 1.001].reverse, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 24 * [panA, panB],
        engine: 2,
        harm: 0.25,
        timbre: env * 0.35,
        morph: morph
    ) * 0.5 * env;
    [sig[0][1], sig[1][1]] * 0.25;
}.play;

y.set(\gate, 0, \fadeTime, 0.1);
y = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -12, -10, -17], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.2
    ) * 0.5 * env;
    sig[1]!2;
}.play;
)