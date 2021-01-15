
(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
// a.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.25 + (t.beatDur * 0), {
    a.set(\gate, 0, \fadeTime, 0.5);
    [~noLow, z, h, ~pul2, ~pul3].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
    ~sPA.stop;
    ~sPC.stop;
    u.free;
    a = {
        var trig = Impulse.ar(1 / (~nT.beatDur * 5));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, 5, -2, 3].stutter(1), inf));
        var note2 = Demand.ar(trig, 0, ff + 12 + Dseq([0, 5].stutter(1), inf));
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
            struct: 0.9,
            bright: 0.4 - ((note2 - ff - 12) * 0.2 * 0.5),
            damp: 0.65 + ((note2 - ff - 12) * 0.2 * 0.25),
            pos: 2,
            bypass: 0);
        sig = sig * 0.125;
    }.play(fadeTime: 0);
});
// c.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.25 + (t.beatDur * 0), {
    c.set(\gate, 0, \fadeTime, 0.5);
    c = {
        var trig = Impulse.ar(1 / (~nT.beatDur * 5));
        var note = Demand.ar(trig, 0, 30 + 12 + Dseq([0, -5, -2, -7].stutter(1), inf));
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
            pit: note - 12,
            struct: 0.9,
            bright: 0.4,
            damp: 0.65,
            pos: 2,
            bypass: 0);
        sig = sig * 0.25;
    }.play(fadeTime: 0.01);
});
/*~bee.stop;
~bee = Pbind(
// \instrument, \samplerBee,
\instrument, Pseq([\samplerBee, \samplerBeeFlip], inf),
// \dur, 8 / (122/60),
\dur, 5 * 4,
\spos, 0.0125,
// \rel, 0.1,
\atk, 0.001,
\susT, y.duration - 3,
\rel, 2,
\rate, 1,
\amp, 0.35,
\pan, 0,
\out, 0,
\buf, y
).play(~nT, quant: [5, 0]);*/
/*~shimmer.stop;
~shimmer = Pbind(
\instrument, \sampler,
// \dur, 8 / (122/60),
\dur, 8,
\spos, 0,
\rel, 0.1,
\atk, 0.001,
\susT, b.duration,
\rel, 0.001,
\rate, 1,
\amp, 1,
\pan, 0,
\out, 0,
\buf, b
).play(t, quant: [8, 0]);*/
/*~hit.stop;
~hit = Pbind(
\instrument, \sampler,
// \dur, 8 / (122/60),
// \dur, Pseq([Rest(8*2), Rest(3.5), 1, Rest(3.5), Rest(8)], inf),
\dur, Pseq([Rest(8), Rest(3.5), 1, Rest(3.5)], inf),
\spos, 0,
\rel, 0.1,
\atk, 0.001,
\susT, 1,
\rel, 0.001,
\rate, 1,
\amp, 0.8,
\pan, 0,
\out, 0,
\buf, ~oneHit
).play(t, quant: [8, 0]);*/
)

t.timeToNextBeat(quant: 8)
(
q.free;
q = {
    var trig = Impulse.ar(8);
    var sig = MiPlaits.ar(31 + 23 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
        // morph: 0.5,
        trigger: trig,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1.25);
    HPF.ar(sig, 5000);
    // sig;
}.play;
)

(
t.free;
t = {
    var trig = Impulse.ar(8);
    var sig = MiPlaits.ar(31 + 23 + 5 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
        // morph: 0.5,
        trigger: trig,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1.25);
    HPF.ar(sig, 5000);
    // sig;
}.play;
)

(
[a, b, q, t].do({|i| i.set(\gate, 0, \fadeTime, 10)});
)