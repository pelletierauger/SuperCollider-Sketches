(
x.free;
x = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0.5, 1, 0.5], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 36,
        timbre: 0.5,
        color: 0.7 + [0, 0.01],
        model: 42,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * env;
    sig * 0.5;
}.play;
)


(
y.free;
y = {
    var t = Impulse.kr(0.5);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 36 + 12 + 12,
        timbre: 0.5,
        color: 0.7 + [0, 0.01],
        model: 42,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig * 0.125;
}.play;
)

(
z.free;
z = {
    var t = Impulse.kr(0.5);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 36 + 12 + 12,
        timbre: 0.5,
        color: 0.7 + [0, 0.01],
        model: 42,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig * 0.125 * 0.125;
}.play;
)



(
y.free;
y = {
    var t = Impulse.kr(2);
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 36 + 12,
        timbre: 0.5,
        color: 0.7 + [0, 0.01],
        model: 42,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig * 0.125;
}.play;
)

(
u.free;
u = {
    var t = Impulse.kr(2);
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 36 + 12 + 24,
        timbre: 0.1,
        color: 0.1 + [0, 0.01],
        model: 42,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig * 0.125 * 2;
}.play;
)

(
d.free;
d = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.2
    ) * 0.0625 * env;
    sig!2;
}.play;
)


(
~u2.free;
~u2 = {
    var t = Impulse.kr(2);
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 72 + 140,
        timbre: 0.7,
        color: 0.1 + [0, 0.01],
        model: 43,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig * 0.125 * 0.125;
}.play(fadeTime: 0);
)

(
v.free;
v = {
    var t = Impulse.kr(2);
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 72 + 14,
        timbre: 0.7,
        color: 0.1 + [0, 0.01],
        model: 43,
        resamp: 2,
        decim: 12,
        bits: 6,
        ws: 1
    ) * env;
    sig * 0.125 * 0.25;
}.play;
)