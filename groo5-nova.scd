~nT = TempoClock.new(1.7).permanent_(true);

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;

~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
    ~pul2.free;
    ~pul2 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq(([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0]), inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36 + 24,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.9,
            lpg_colour: 0
        )[1]!2 * 3;
        sig = LPF.ar(sig, 6000);
        sig = HPF.ar(sig, 200);
        sig = sig * 0.5 * 0.8;
        sig * 0.9;
    }.play(fadeTime: 0.005);
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (~nT.beatDur * 0), {
~kick.free;
~kick = {
    var trig, sig, block;
    trig = Impulse.kr(1 / ~nT.beatDur);
    block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
    sig = MiPlaits.ar(26,
        engine: 13,
        harm: 0.5,
        timbre: 0.2,
        morph: 0.8,
        trigger: trig,
        decay: 0.1
    )[0]!2 * 1;
}.play;
});
)



// Bruit haut

(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    ~noLow = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
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
            pitch: 48 - 36,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = LPF.ar(sig, 4000);
        sig * 0.75 * 0.5 * 0.4 * 12 * 0.5;
    }.play(fadeTime: 0.1);
});
)

// Bruit bas

(
[~noLow2].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.25 + (~nT.beatDur * 0), {
    ~noLow2 = {
                var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        var notes = Demand.ar(trig * block, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig * block, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0.5, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 12,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = HPF.ar(sig, 500);
        sig = LPF.ar(sig, 3000);
        sig * 0.75 * 0.5 * 0.4 * 2;
    }.play(fadeTime: 0.1);
});
)