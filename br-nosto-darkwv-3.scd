(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    [~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});

    // ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLow = {
        var trig = Impulse.ar(~nT.tempo * 0.5);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(16), inf));
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
            decim: 2,
            bits: 3,
            ws: 0.75
        );
        // sig = VadimFilter.ar(sig, 4000, 0, 1);
        sig = VadimFilter.ar(sig, 2300, 0, 5) * 4;
        sig = VAKorg35.ar(sig, freq: 5000, res: 0, overdrive: 0.5);
        sig.reverse * 0.02;
    }.play(fadeTime: 0.1);
    // });

    [~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

    // ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLowB = {
        var trig = Impulse.ar(~nT.tempo * 0.5);
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
            timbre: 0.25,
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
            pit: 36 + 2 + 7 + 2 - 2 - 24 * [1, 1.005],
            struct: 0.5,
            bright: 0.25,
            // pos: 0,
            damp: 0.1,
            model: 4
        ) * 0.1;
        [sig[1], sig[0] * 4] * 0.75 * 16;
    }.play(fadeTime: 1);
});
)