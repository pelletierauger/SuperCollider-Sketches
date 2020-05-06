(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
u.free;
u = {
    var trig = Impulse.ar(0.75);
    var sig = MiPlaits2.ar(55 + -24,
        engine: 13,
        harm: 0.95,
        timbre: 0.25,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.85,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1);
    [sig[1], sig[1]] * 2;
    // HPF.ar(sig, 5000);
        // sig;
    }.play;
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
v.free;
v = {
    var trig = Impulse.ar(0.75 * 4);
    var sig = MiPlaits2.ar(55 + -24,
        engine: 13,
        harm: 0.95,
        timbre: 0.05,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.85,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1);
    sig = [sig[1], sig[1]];
    HPF.ar(sig, 2200) * 80;
        // sig;
    }.play;
)



(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
d.free;
d = {
    var trig = Impulse.ar(0.75 * 2) + Impulse.ar(0.75 * 1, 0.25);
    var dem = Demand.ar(trig, 0, Dseq([0.15, 0.15, 0.7], inf));
    var sig = MiPlaits2.ar(55 + -24,
        engine: 15,
        harm: 0.95,
        timbre: 0.85,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: dem,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 0.5);
    sig = [sig[1], sig[1]];
    // HPF.ar(sig, 5000);
        // sig;
    MiRings2.ar(sig, pit: 31 + 12) * 4;
    }.play;
)





(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
u.free;
u = {
    var trig = Impulse.ar(0.75 * 24);
    var dem = Demand.ar(trig, 0, Dseq([3, 5, 7, 10, 12, 14, 16, 19, 24].stutter(1), inf));
    var sig = MiPlaits2.ar(55 + -24 + dem,
        engine: 13,
        harm: 0.95,
        timbre: 0.05,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.85,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1);
    sig = [sig[1], sig[1]];
    HPF.ar(sig, 2200) * 40;
        // sig;
    }.play;
)



    ;

Nes2Noise

{Nes2Noise.ar(Impulse.kr(2), 1, MouseX.kr(0, 1), MouseY.kr(0, 15))}.play
{Nes2Noise.ar(Impulse.kr(10), 0, 1, 10, MouseX.kr(0, 1), MouseY.kr(0, 15))}.play
~nes = {Nes2Noise.ar(Impulse.kr(2), 0, 0, 10, 0, MouseX.kr(0, 15), MouseY.kr(0, 31))!2}.play
~nes.free;
~nes = {Nes2Noise.ar(Impulse.kr(4), SinOsc.kr([11, 8], 0, 0.5, 0.5)>SinOsc.kr(0.2, 0, 0.5, 0.5), 0, SinOsc.kr(0.1, pi, 0.5, 0.5)>0.1, 1, SinOsc.kr(0.25, 0, 20, 20).round(5)+1, 31)!2}.play

~nes = {Nes2Noise.ar(Dust.kr(30), 0, 0, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup * 0.5}.play


MiRings2
x.free;
(
x = {
    var sig = Nes2Noise.ar(Dust.kr(30), 0, 0, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup * 0.5;
    MiRings2.ar(sig, pit: 31);
}.play;
)