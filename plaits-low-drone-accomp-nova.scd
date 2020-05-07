(
// 3:SINE_TRIANGLE
var f = ~toMidi.("G3") + 0; //55
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
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 4 * XLine.kr(0.001, 1, 3);
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
    var trig = Impulse.ar(0.75 * 0.5);
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
        mul: 1.25);
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



// -----------------------
(
// t = TempoClock.new;
// t.tempo_(50/60);
// t.permanent = true;
~guitare2 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/0001\ 7-Audio.aif");
SynthDef(\guitare2, {
    arg buf = ~guitare2, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~guitare2, rate * BufRateScale.ir(buf), startPos: spos * 7144448);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


(
~shimmerD.stop;
~shimmerD = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 16,
    \spos, Pseq([0.2545].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * -2.midiratio,
    \amp, 16,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play();
)
// ambient : 0.382
(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare2,
    \dur, 1 / 16,
    \spos, Pseq([0.38].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * 3.midiratio * -5.midiratio * Pseq([-5, 0].stutter(4 * 16).midiratio, inf),
    \amp, Pseq([2, 2].stutter(4 * 16), inf) * 3,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play();
)