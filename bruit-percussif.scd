(
v.free;
v = {
    var trig, sig;
    trig = Impulse.kr(2);
    sig = MiPlaits.ar(55 - 24 + 2,
        engine: 13,
        harm: 0.5,
        timbre: 0.2,
        morph: 0.5,
        trigger: trig,
        decay: 0.1
    );
    sig = LPF.ar(sig, 1000);
    sig = sig[0]!2 * 1.25;
}.play;
)


(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 10)});

// ~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
    ~noLow = {
        var trig = Impulse.kr(1);
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [0.005, 0.35, 0.005]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 48 - 36,
            timbre: 0.1 * 0.5,
            color: 0.0 + 0.1 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = LPF.ar(sig, 4000) * 0.075 * env * 2;
    }.play(fadeTime: 0.0);
// });
)

(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 10)});

// ~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
    ~noLowB = {
        var trig = Impulse.kr(1);
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.005, 0.1, 0.1]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 48 - 36 + 12,
            timbre: 0.1 * 0.5,
            color: 0.0 + 0.1 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 1,
            ws: 0
        );
        sig = LPF.ar(sig, 4000) * 0.075 * env;
    }.play(fadeTime: 0.0);
// });
)

(
[~noLowC].do({|i| i.set(\gate, 0, \fadeTime, 10)});

// ~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
    ~noLowC = {
        var trig = Impulse.kr(1);
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.005, 0.1, 0.1]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 48 - 36 + 12 + 24,
            timbre: 0.1 * 0.5,
            color: 0.0 + 0.1 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 10,
            bits: 1,
            ws: 0
        );
        sig = LPF.ar(sig, 4000) * 0.075 * env;
    }.play(fadeTime: 0.0);
// });
)


(
[~noLowD].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
    ~noLowD = {
        var trig = Impulse.kr(2);
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.005, 0.1, 0.1]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 60 - 24,
            timbre: 0.1 * 0.5,
            color: 0.0 + 0.1 + [0, 0.01],
            model: 11,
            resamp: 2,
            decim: 5,
            bits: 1,
            ws: 0
        );
        sig = LPF.ar(sig, 4000) * 0.075 * env;
    }.play(fadeTime: 0.0);
// });
)