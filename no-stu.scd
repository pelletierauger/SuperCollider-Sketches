(
[~no].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~t.sched(~t.timeToNextBeat(quant: 1), {
    ~no = {
        var trig = Impulse.ar((1 / (~t.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0], inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 60,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = MiRings.ar(sig,
            pit: 36 + 12 * [1, 1.005],
            struct: 0.25,
            bright: 0.5,
            damp: 0.5,
            pos: 0.5,
            model: 2
        ) * 0.1;
        // sig = LPF.ar(sig, 4800);
        sig * 0.75 * 0.5 * 0.4 * 8;
    }.play(fadeTime: 0.1);
});
)
