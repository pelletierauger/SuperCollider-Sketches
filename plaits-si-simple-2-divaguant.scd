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
x.set(\gate, 0, \fadeTime, 0.1);
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
y.set(\gate, 0, \fadeTime, 10);
y = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -10], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 400) * 2;
    sig;
}.play;
)


(
z.set(\gate, 0, \fadeTime, 10);
z = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, 2], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 400) * 2;
    sig;
}.play;
)

(
e.set(\gate, 0, \fadeTime, 10);
e = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([4], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 400) * 2;
    sig;
}.play;
)

(
f.set(\gate, 0, \fadeTime, 10);
f = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([7], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 400) * 0.5;
    sig;
}.play;
)


(
n.set(\gate, 0, \fadeTime, 1);
n = {
    var freq = 24;
    var trig = Impulse.kr(2);
    var dem = Demand.kr(trig, 0, freq + Dseq(([0, 3, 1, 0] ++ [-5, -2, 3, 0]).stutter(1), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var dem3 = Demand.kr(trig, 0, Dseq([16, 8].stutter(2), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.1, 2], [-8, -8]), trig);
    var sig = MiPlaits.ar(dem + [0, 0.1],
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: 0,
        decay: 0.25
    ) * amp;
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    var dec = Integrator.ar(sig, 0.9, FSinOsc.ar(dem.midicps * 16), 0);
    // Integrator
    sig = sig + (dec * 0.1);
    sig = [sig[0][0], sig[1][0]];
    sig = LPF.ar(sig, 3000) * 0.5;
    sig * (Line.kr(0, 1, 0.01).floor);
}.play;
)


(
m.set(\gate, 0, \fadeTime, 1);
m = {
    var freq = 61 - 12;
    var trig = Impulse.ar(0.5);
    var dem = Demand.ar(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).reverse.stutter(4), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.07, 2], [-8, -8]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        // trigger: trig,
        decay: 0.25
    ) * amp.lag(0.01);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][1], sig[1][1]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 100 + (pow(amp, 1) * 3000)) * lfo * 0.5;
}.play;
)


(
o.set(\gate, 0, \fadeTime, 1);
o = {
    var freq = 61 + 12;
    var trig = Impulse.kr(7.5, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(8), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem,
        engine: 2,
        harm: 0.65,
        timbre: 0.5,
        morph: 0.45,
        trigger: trig,
        decay: 0.5
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.2;
}.play;
)