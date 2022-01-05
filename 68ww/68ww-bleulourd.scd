(
~t.sched(~t.timeToNextBeat(quant: 6), {
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});


    ~noLowB = {
        var trig = Impulse.ar(~t.tempo);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0], inf));
        var pitch = Demand.ar(trig * block, 0, Dseq([-2, -5].stutter(2), inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 24 + 7 - 12 + 7 + 12 + pitch,
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
            pit: 24 - 12 * [1, 1.005],
            struct: 0.4,
            bright: 1,
            pos: 0,
            damp: 0.2,
            model: 1
        ) * 0.1;
        [sig[1], sig[0]] * 8 * 0.2;
    }.play(fadeTime: 0.1);
});
)

