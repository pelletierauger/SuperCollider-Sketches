(
// 3:SINE_TRIANGLE
var f = ~toMidi.("G3"); //55
~drone.free;
~drone = {
    var model = 1;
    var lfo = SinOsc.kr(0.1).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2, pi).range(0.025, 0.85);
    var sig = MiBraids.ar(f - 12 * [1, 1.001], lfo, lfo2, model, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, model, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f + 12 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    sig = LPF.ar(sig, 1000);
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 8 * XLine.kr(0.001, 1, 3);
}.play;
)
~drone.free;




(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
e.free;
TempoClock.default.sched(0, {
e =    {
        var i = 0.75;
    var trig = Impulse.ar(i) + Impulse.ar(i, 0.15) + Impulse.ar(i, 0.25);
    var sig = MiPlaits.ar(31 + 24 + -12,
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 16);
    var sig2 = MiPlaits.ar(31 + 24 + -12 + 0.1,
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 16);
        [sig[0], sig2[0]];
    }.play;
    nil;
});
)
e.free;
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
f.free;
f =    {
    var trig = Impulse.ar(0.75);
    var sig = MiPlaits.ar(31 + 24 + 2,
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 8);
    sig[0]!2;
    }.play;
    nil;
});
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
g.free;
g =    {
    var trig = Impulse.ar(0.75);
    var sig = MiPlaits.ar(31 + 24 + 2 + 10,
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 8);
    sig[0]!2;
    }.play;
    nil;
});
)

// --------------------------------------

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
q.free;
q = {
    var trig = Impulse.ar(10);
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
        mul: 2);
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
    var trig = Impulse.ar(10);
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
        mul: 2);
        HPF.ar(sig, 5000);
        // sig;
    }.play;
)


// En G Mixolydien
// Capo 3ième frette

 G         Am     B#m
 I         ii     iii
------3--------3------3-------------3--------3--------------------------------------------
-----3--------3------3-------------3--------3---------------------------------------------
----4--------5------7-------------7--------5----------------------------------------------
---3--------7------9-------------9--------7-----------------------------------------------
--5----------------------------10--------8-----------------------------------------------
-3---------5------7-----------3---------3-------------------------------------------------