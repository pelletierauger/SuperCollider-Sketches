
(
x.free;
x = {
    var f = 31;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    sig2 = [sig1[0], sig2[0]] * 8 * Line.kr(0, 1, 1);
    VadimFilter.ar(sig2 * 1, 500, 0, 5);
}.play;
)




(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
e.free;
e =    {
        var i = 0.75;
    var trig = Impulse.ar(i) + Impulse.ar(i, 0.15) + Impulse.ar(i, 0.25);
    var sig = MiPlaits.ar(31 + 24 + -12,
        engine: 11,
        harm: 0.25,
        timbre: 0.1,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.4,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 16);
    var sig2 = MiPlaits.ar(31 + 24 + -12 + 0.1,
        engine: 11,
        harm: 0.25,
        timbre: 0.1,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.4,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 16);
        sig = [sig[0], sig2[0]];
    VadimFilter.ar(sig, 1000, 0, 1);
    }.play;

// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
{
    0.5.wait;
f.free;
f =    {
    var trig = Impulse.kr(0.75);
        var dem = Demand.kr(trig, 0, Dseq([0, 1, 3, 2].stutter(2), inf));
    var sig = MiPlaits.ar(31 + 24 + 2 + dem,
        engine: 11,
        harm: 0.25,
        timbre: 0.1,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.2,
        trigger: trig,
        usetrigger: 1,
        decay: 0.8,
        lpg_colour: 0,
        mul: 15);
    sig = sig[0];

    VadimFilter.ar(sig, 2000, 0, 1) * 1!2;
    }.play;
}.fork;
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
        mul: 4.25);
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
        mul: 4.25);
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