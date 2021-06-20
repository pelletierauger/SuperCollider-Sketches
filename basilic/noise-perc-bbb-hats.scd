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
        sig = LPF.ar(sig, 6000);

    sig * 0.125 * 2;
}.play(fadeTime: 0);
~u3.free;
~u3 = {
    var t = Impulse.kr(2 * 1.5);
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 8], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 72 + 140 - 24,
        timbre: 0.7,
        color: 0.1 + [0, 0.01],
        model: 43,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
        sig = LPF.ar(sig, 6000);

    sig * 0.125 * 0.125 * 2;
}.play(fadeTime: 0);
)

(
[~haa].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
    ~haa = {
        var trig = Impulse.kr(1);
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..2) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [0.005, 0.35 * 0.5, 0.005]), gate: trig);
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
        sig = LPF.ar(sig, 4000) * 0.075 * env * 4;
    }.play(fadeTime: 0.0);
// });
)


(
[~haa2].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
    ~haa2 = {
        var trig = Impulse.kr(2);
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..2) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [0.005, 0.35 * 0.125, 0.005]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 48 - 36,
            timbre: 0.1 * 0.5,
            color: 0.0 + 0.1 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 16,
            bits: 4,
            ws: 0
        );
        sig = LPF.ar(sig, 4000) * 0.075 * env * 4;
    }.play(fadeTime: 0.0);
// });
)