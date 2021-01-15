(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 10)});

~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
    ~noLow = {
        var trig = Impulse.kr(1 / (~nT.beatDur * 5));
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 48 - 36,
            timbre: dem2 * 0.5,
            color: 0.0 + dem2 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = LPF.ar(sig, 4000);
        sig * 0.75 * 0.5 * 0.4 * 12;
    }.play(fadeTime: 0.1);
});
)


(
[~noLow2].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.25 + (~nT.beatDur * 0), {
    ~noLow2 = {
        var trig = Impulse.kr(1 / (~nT.beatDur * 5));
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 48 - 36 + 12,
            timbre: dem2 * 0.5,
            color: 0.0 + dem2 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = HPF.ar(sig, 1000);
        sig = LPF.ar(sig, 2000);
        sig * 0.75 * 0.5 * 0.4 * 8;
    }.play(fadeTime: 0.1);
});
)




(
[~noLow2].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.25 + (~nT.beatDur * 0), {
    ~noLow2 = {
        var trig = Impulse.kr(1 / (~nT.beatDur * 5));
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0.5, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 12,
            timbre: dem2 * 0.5,
            color: 0.0 + dem2 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = HPF.ar(sig, 500);
        sig = LPF.ar(sig, 3000);
        sig * 0.75 * 0.5 * 0.4 * 4;
    }.play(fadeTime: 0.1);
});
)

(
[x].do({|i| i.set(\gate, 0, \fadeTime, 1)});
// x.free;
x = {
    var trig = Impulse.kr(0.5);
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.1);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 48 - 36,
        timbre: 0.5 + lfo,
        color: 0.0 + dem2 + [0, 0.01],
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 4,
        ws: 0
    );
    sig = HPF.ar(sig, 4000);
    sig = LPF.ar(sig, 8000);
    // sig = LPF.ar(sig, 2000) * env;
    // sig = sig + (LPF.ar(CombL.ar(sig, 0.05, (notes + 0).midicps.reciprocal, 4), 1000) * 0.4);
    sig * 0.75 * 0.5 * 0.4 * 2;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play(fadeTime: 1);
)