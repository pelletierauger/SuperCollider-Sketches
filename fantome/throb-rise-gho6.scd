(
var f = 220 * 9.midiratio;
var ff = 54 + -12 - 12;
w.free;
h.free;
z.free;
t.sched(t.timeToNextBeat(quant: 8) + 0.1, {
w = {
    var trig = Impulse.ar(122 / 60 * 0.125 * 16 * 2);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, -5, -2, -7].stutter(32), inf));
    var mod = Demand.ar(trig, 0, Dseq(((1..8)/10).stutter(2), inf));
    var sig = MiPlaits.ar(note + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);
    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.4,
        bright: mod,
        damp: 1 - mod,
        pos: 2,
        bypass: 0);
    sig = sig * 0.25;
}.play(fadeTime: t.beatDur * 32);
    z = {
    var trig = Impulse.kr(0.5);
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.99], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 48!2 - 36 + 24,
        timbre: 0.45 + lfo,
        color: 0.0 + dem2,
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    );
    sig = LPF.ar(sig, 2000);
    // sig = LPF.ar(sig, 2000) * env;
    // sig = sig + (LPF.ar(CombL.ar(sig, 0.05, (notes + 0).midicps.reciprocal, 4), 1000) * 0.4);
    sig * 0.75 * 0.5 * 0.4 * 2.5 * 1.75;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play(fadeTime: t.beatDur * 64);
    h = {
    var trig = Impulse.kr(0.5);
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.8], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 48!2 + 12,
        timbre: 0.01 + lfo,
        color: 0.0 + dem2,
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0.4
    );
    sig = HPF.ar(sig, 1000);
    // sig = LPF.ar(sig, 2000) * env;
    // sig = sig + (LPF.ar(CombL.ar(sig, 0.05, (notes + 0).midicps.reciprocal, 4), 1000) * 0.4);
    sig * 0.75 * 0.5 * 0.1 * 1.75;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play(fadeTime: t.beatDur * 64);
});
)

t.beatDur * 16

MiOmi

MiMu