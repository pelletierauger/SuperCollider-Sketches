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
)


(
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

(
z.set(\gate, 0, \fadeTime, 0.1);
z = {
    var t = Impulse.kr(0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [2, 6], [2, 2, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -10], inf));
    var morph = Demand.kr(t, 0, Dseq([0.2, 0.7], inf));
    var panA = Demand.kr(t, 0, Dseq([0, 0.01], inf));
    var panB = Demand.kr(t, 0, Dseq([0.01, 0], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 24 + 24 + [panA, panB],
        engine: 2,
        harm: 0.8,
        timbre: env * 0.75,
        morph: morph
    );
    // sig = LPF.ar(sig, SinOsc.ar(3).range(5000, 8000));
    [sig[0][1], sig[1][1]] * 0.125 * env;
}.play;
)

(
z.free;
z = {
    var t = Impulse.kr(0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [2, 6], [2, 2, 'lin']), t);
    env;
}.plot(10);
)


(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLow = {
        var trig = Impulse.ar(1);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0.2, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 2,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 1,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
    sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 300);
        sig * 0.75 * 0.5 * 0.4 * 8 * 0.125;
    }.play(fadeTime: 0.1);
// });
)



(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLow = {
        var trig = Impulse.ar(1);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0.2, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 55,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 5,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
    sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 300);
        sig * 0.75 * 0.5 * 0.4 * 4 * 0.125;
    }.play(fadeTime: 0.1);
// });
)
