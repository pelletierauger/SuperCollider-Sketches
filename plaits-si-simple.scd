MiPlaits

(
// x.free;
x = {
    var env = EnvGen.kr(Env.circle([0, 1, 0], [0.015, 2, 0], ['lin', -8, 'lin']));
    var sig = MiPlaits.ar(
        pitch: 60 - 12,
        engine: 2,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.2
    ) * 0.5 * env;
    sig!2;
}.play;
)

(
x.free;
x = {
    var env = EnvGen.kr(Env.circle([0, 1, 0], [0.015, 2, 0], ['lin', -8, 'lin']));
    var sig = MiPlaits.ar(
        pitch: 60 - 5,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 0.25
    ) * 0.5 * env;
    sig = LPF.ar(sig, 400) * 2;
    sig!2;
}.play;
)


(
// x.free;
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
    ) * 0.5 * env;
    sig!2;
}.play;
)


(
y.free;
y = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -10], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    var sig2 = MiPlaits.ar(
        pitch: 60 + note + 0.01,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0], sig2[0]];
    sig = LPF.ar(sig, 400) * 1.5;
    sig;
}.play;
)


(
z.free;
z = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, 2], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    var sig2 = MiPlaits.ar(
        pitch: 60 + note + 0.01,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0], sig2[0]];
    sig = LPF.ar(sig, 400) * 2;
    sig;
}.play;
)

(
e.free;
e = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([4], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    var sig2 = MiPlaits.ar(
        pitch: 60 + note + 0.01,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0], sig2[0]];
    sig = LPF.ar(sig, 400) * 2;
    sig;
}.play;
)

(
f.free;
f = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([7], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    var sig2 = MiPlaits.ar(
        pitch: 60 + note + 0.01,
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0], sig2[0]];
    sig = LPF.ar(sig, 400) * 2;
    sig;
}.play;
)


(
n.free;
n = {
    var freq = 61;
    var trig = Impulse.kr(7.5, 0.1);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.25;
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(16), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        decay: decay
    );
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        decay: decay
    );
    var sig = [sig1[0], sig2[0]];
    // var verb = MiVerb.ar(sig * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.5);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.5;
}.play;
)


(
m.free;
m = {
    var freq = 61 - 12;
    var trig = Impulse.kr(7.5, 0.1);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.25;
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).reverse.stutter(4), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        decay: decay
    );
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        decay: decay
    );
    var sig = [sig1[0], sig2[0]];
    // var verb = MiVerb.ar(sig * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.5);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.5;
}.play;
)


(
o.free;
o = {
    var freq = 61 + 12;
    var trig = Impulse.kr(7.5, 0.1);
    var engine = 2, harm = 0.65, timbre = 0.5, morph = 0.45, decay = 0.5;
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(8), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    // var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        decay: decay
    );
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        decay: decay
    );
    var sig = [sig1[0], sig2[0]];
    // var verb = MiVerb.ar(sig * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.5);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.2;
}.play;
)