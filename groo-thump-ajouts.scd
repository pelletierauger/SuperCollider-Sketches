
(
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(q.isPlaying, {q.set(\gate, 0, \fadeTime, 0.1)});

    q.free;
    q = {
        var trig = Impulse.ar(~nT.beatDur.reciprocal * 8);
        var sig = MiPlaits.ar(31 + 28 + 0 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 0.9,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 3.2;
    }.play.register;

    if(t.isPlaying, {t.set(\gate, 0, \fadeTime, 0.1)});

    t = {
        var trig = Impulse.ar(~nT.beatDur.reciprocal * 8, pi * 0);
        var sig = MiPlaits.ar(28 + 24 + 5 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 0.9,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 3.2;
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
    ~pul3.free;
    ~pul3 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, 42 + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3);
        sig = HPF.ar(sig, 400);
        sig = sig * 1.5 * 2;
        sig[1]!2;
    }.play(fadeTime: 0).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(~hat2.isPlaying, {~hat2.set(\gate, 0, \fadeTime, 0.1)});

    ~hat2 = {
        var trig = Impulse.kr(1 / (~nT.beatDur) * 4);
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq([1, 0, 0, 0].rotate(0), inf));
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [0.005, 0.35 * 0.125, 0.005]), gate: dem);
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
        sig = LPF.ar(sig, 4000) * 0.075 * env * 64 * 1.5;
        sig = CombN.ar(sig, 0.025, 0.025 * 0.25, decaytime: 4);
        sig = Decimator.ar(sig, rate: 1000, bits: 12) * 0.125;
        // sig = HPF.ar(sig, 200);
        // sig = LPF.ar(sig, 1000) * 2;
    }.play(fadeTime: 0.0).register;
});
)