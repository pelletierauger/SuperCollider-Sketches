

~nT = TempoClock.new(1.39).permanent_(true);


// Encore plus intense


(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul2.free;
~pul3.free;
a.free;
c.free;
~sPA.stop;
~sPC.stop;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.0 + (~nT.beatDur * 0), {
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
    )[0]!2 * 2;
}.play(fadeTime: 10).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.0 + (~nT.beatDur * 0), {

    ~pul2 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36 + 24,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3);
        /*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
        // sig = LPF.ar(sig, 10000);
        sig = HPF.ar(sig, 200);
        sig = sig * 0.8;
        sig[1]!2;
    }.play(fadeTime: 10).register;
});

h.free;
z.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.0 + (~nT.beatDur * 0), {
    z = {
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
            pitch: 30 + [0, 0.01],
            timbre: 0.45 + lfo,
            color: 0.0 + dem2,
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = LPF.ar(sig, 2000);
        sig * 0.65625 * 2;
    }.play(fadeTime: 2).register;

    h = {
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
            pitch: 42 + 12 + [0, 0.01],
            timbre: 0.01 + lfo,
            color: 0.0 + dem2,
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0.4
        );
        sig = HPF.ar(sig, 1000);
        sig * 0.065625 * 2;
    }.play(fadeTime: 2).register;
});
)

[~kick, ~pul2, z, h].do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 30)})});
