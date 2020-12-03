(
var f = 220 * 10.midiratio;
a.free;
a = {
        var trig = Impulse.ar(2);
    var note = Demand.ar(trig, 0, 55 + 12 + Dseq([0, 4, -5, 7, 2].stutter(8), inf));
    var sig = MiPlaits.ar(note + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);
    sig = (sig * 0.15) + MiRings.ar(sig,
        0,
        pit: 55,
        struct: 0.5,
        bright: 0.2,
        damp: 0.25,
        pos: 2,
        usetrigger: 0,
        bypass: 0);
    sig = sig * 0.5;
}.play;
)

(
var f = 220 * 10.midiratio;
b.free;
b = {
        var trig = Impulse.ar(0.5);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.25, 1]), trig);
    var note = Demand.ar(trig, 0, 55 + 0 + Dseq([0, 4, -5, 7, 2].stutter(2), inf));
    var sig = MiPlaits.ar(note + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);
    sig = sig * env;
    sig = (sig * 0.15) + MiRings.ar(sig,
        0,
        pit: note,
        struct: 0.5,
        bright: 0.2,
        damp: 0.65,
        pos: 2,
        usetrigger: 0,
        bypass: 0);
    sig = sig * 16;
}.play(fadeTime: 0);
)


(
var f = 220 * 10.midiratio;
c.free;
c = {
        var trig = Impulse.ar(0.5);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.25, 1]), trig);
    var note = Demand.ar(trig, 0, 55 + -12 + Dseq([0, 4, -5, 7, 2].stutter(2), inf));
    var sig = MiPlaits.ar(note + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);
    sig = sig * env;
    sig = (sig * 0.15) + MiRings.ar(sig,
        0,
        pit: note,
        struct: 0.5,
        bright: 0.2,
        damp: 0.65,
        pos: 2,
        usetrigger: 0,
        bypass: 0);
    sig = sig * 16;
}.play(fadeTime: 0);
)


(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
q.free;
q = {
    var trig = Impulse.ar(8);
    var sig = MiPlaits.ar(31 + 24 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1.25);
        HPF.ar(sig, 5000);
        // sig;
    }.play;
)
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
t.free;
t =
    {
    var trig = Impulse.ar(8);
    var sig = MiPlaits.ar(31 + 24 + 5 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1.25);
        HPF.ar(sig, 5000);
        // sig;
    }.play;
)


// --------------------------------------------------------------------------
// Drones
// --------------------------------------------------------------------------

(
y.free;
y = {
    var f = 55 - 12;
    var lfo = SinOsc.kr(1).range(0.1, 0.2);
    var lfo2 = SinOsc.kr(1, pi).range(0.1, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2;
    LPF.ar(sig, 1000 + (lfo2 * 10000));
}.play;
)

(
z.free;
z = {
    var f = 55 - 12 - 12;
    var lfo = SinOsc.kr(0.125).range(0.1, 0.2);
    var lfo2 = SinOsc.kr(0.125, pi).range(0.1, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2;
    LPF.ar(sig, 1000 + (lfo2 * 10000));
}.play;
)

c.set(\gate, 0, \fadeTime, 2);