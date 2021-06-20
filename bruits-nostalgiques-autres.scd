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



// Très doux, feutré

(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLowB = {
        var trig = Impulse.ar(1);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0], inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0], inf));
        var pitch = Demand.ar(trig * block, 0, Dseq([0, -5].stutter(2), inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 24 + 7 - 12 + 7 + pitch - 2,
            timbre: 0.5,
            color: 0.0 + [0, 0.01],
            model: 0,
            resamp: 2,
            decim: 32,
            bits: 16,
            ws: 0
        );
        // sig = LPF.ar(sig, 4000);
        sig = sig * 0.6;
        sig = MiRings.ar(sig,
            pit: 36 + 2 + 7 + 2 - 2 - 12 * [1, 1.005],
            struct: 0.4,
            bright: 1,
            // pos: 0,
            model: 1
        ) * 0.1;
        [sig[1], sig[0]] * 0.75 * 1;
    }.play(fadeTime: 1);
// });
)




(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLowB = {
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
            model: 11,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
    sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 300);
        sig * 0.75 * 0.5 * 0.4 * 8 * 0.5;
    }.play(fadeTime: 0.1);
// });
)

s.record;
s.stopRecording;


[~noLowB, x, k, ~noLow].do({|i| i.set(\gate, 0, \fadeTime, 30)});