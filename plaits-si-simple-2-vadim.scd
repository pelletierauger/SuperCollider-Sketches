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
x.free;
x = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
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
~nT.sched(~nT.timeToNextBeat(quant: 2) + ~nT.beatDur, {
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    var t = Impulse.kr(~nT.tempo * 0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [0.5, 4 - 0.2], [2, 'lin', 'lin']), t);
    var env2 = EnvGen.kr(Env([-2, 0, 0], [0.5, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -3] + -8, inf));
    var lfo = SinOsc.kr(3).range(0.25, 0.5);
    var sig = MiPlaits.ar(
        pitch: 60 + note - 12 - 19 - 2 + [0, 0.01] + lfo,
        engine: 2,
        harm: 0.75,
        timbre: 0.75,
        morph: 1 - (lfo * 0.35)
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = VadimFilter.ar(sig, 2200 + (1000 * env), 0, 1) * 2;
    sig;
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
z.set(\gate, 0, \fadeTime, 0.1);
z = {
    var t = Impulse.kr(~nT.tempo * 0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -5] + 2, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    // sig = LPF.ar(sig, 400) * 2;
    sig = VadimFilter.ar(sig, 1200, 0, 1) * 2;
    sig;
}.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

{e.set(\gate, 0, \fadeTime, 10);
e = {
    var t = Impulse.kr(~nT.tempo * 0.125);
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
    sig = VadimFilter.ar(sig, 1200, 0, 1) * 2;
    // sig = LPF.ar(sig, 400) * 2;
    sig;
}.play;
        (~nT.beatDur * 2).wait;
        z.set(\gate, 0, \fadeTime, 0.1);
z = {
    var t = Impulse.kr(~nT.tempo * 0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -3] + 2, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    // sig = LPF.ar(sig, 400) * 2;
    sig = VadimFilter.ar(sig, 1200, 0, 1) * 2;
    sig;
}.play;
    }.fork;
});
)

// la salive qui monte
(
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.5, 4 - 0.2], [2, 'lin', 'lin']), t);
    var env2 = EnvGen.kr(Env([-2, 0, 0], [0.5, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -3, -12, -7] + -8, inf));
    var lfo = SinOsc.kr(3).range(0.25, 0.5);
    var sig = MiPlaits.ar(
        pitch: 60 + note - 12 - 19 - 2 + 8 + [0, 0.01] + lfo,
        engine: 2,
        harm: 0.95,
        timbre: 0.75,
        morph: 1 - (lfo * 0.35)
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = VadimFilter.ar(sig, 2200 + (1000 * env), 0, 1) * 2;
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
    var freq = 61;
    var trig = Impulse.kr(8 * 1, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(16), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem + 2,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: trig,
        decay: 0.25
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.25;
}.play(fadeTime: 10);
m.set(\gate, 0, \fadeTime, 0.1);
m = {
    var freq = 61 - 12;
    var trig = Impulse.kr(8, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).reverse.stutter(4), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem + 2,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: trig,
        decay: 0.25
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.25;
}.play(fadeTime: 10);
)


(
o.set(\gate, 0, \fadeTime, 0.1);
o = {
    var freq = 61 + 12;
    var trig = Impulse.kr(8, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(16), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem + 2,
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


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
x.set(\gate, 0, \fadeTime, 10.1);
x = {
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5);
        var d = Demand.kr(t, 0, Dseq([0, 4], inf));
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var sig = MiPlaits.ar(
        pitch: 31 - 0 + [0, 0.1],
        engine: 5,
        harm: lfo,
        morph: 0
    );
    sig = [sig[0][0], sig[1][0]] * 0.4;
    sig = sig * 0.5 + (VadimFilter.ar(sig, 500, 0.25, 1) * 4) * 2;
}.play(fadeTime: 10.1);
});
)
