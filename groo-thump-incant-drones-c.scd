
(
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    var fff = 37 + 1 - 0 + 0;

    if(~noise0.isPlaying, {~noise0.set(\gate, 0, \fadeTime, 0.1)});

    ~noise0 = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        var notes = Demand.ar(trig * block, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig * block, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0.99], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: fff + [0, 0.01],
            timbre: 0.45 + lfo,
            color: 0.0 + dem2,
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = LPF.ar(sig, 2000);
        sig * 0.65625 * 3 * 2;
    }.play(fadeTime: 0.01).register;

    if(~noise1.isPlaying, {~noise1.set(\gate, 0, \fadeTime, 0.1)});

    ~noise1 = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        var notes = Demand.ar(trig * block, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig * block, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0.8], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: fff + 12 + 12 + [0, 0.01],
            timbre: 0.01 + lfo,
            color: 0.0 + dem2,
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0.4
        );
        sig = HPF.ar(sig, 1000);
        sig * 0.065625 * 3 * 2;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    [~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLowB = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
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
        sig * 0.75 * 0.5 * 0.4 * 8 * 4;
    }.play(fadeTime: 0.1).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiPlaits.ar(26,
            engine: 13,
            harm: 0.2,
            timbre: 0.4,
            morph: 0.8,
            trigger: trig,
            decay: 0.1
        )[0]!2 * 8;
    }.play(fadeTime: 0).register;
});
)
