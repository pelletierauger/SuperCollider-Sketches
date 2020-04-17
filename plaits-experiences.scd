// basics
x = { MiPlaits.ar(39 - 0 + [0, 0.1], 5, harm: Line.kr(0, 0.25, 12), mul: 0.2) }.play
// basics
x = { MiPl""aits.ar(39 + -2 + [0, 0.1], 5, harm: Line.kr(0.1, 0.25, 12), morph: 0, mul: 0.2) }.play;
x.free

// Mouse control
{ MiPlaits.ar(48, 6, MouseX.kr(0, 1),  MouseY.kr(0,1), mul: 0.5) }.play

// some talking
{ MiPlaits.ar(MouseY.kr(24,72), 7, MouseX.kr(0, 1),  0.5, LFSaw.ar(0.11, 0, 0.5, 0.5), mul: 0.5) }.play

more:
(
{
    var trigger = Dust.ar( LFNoise2.ar(0.1).range(0.1, 7) );
    var harmonics = SinOsc.ar(0.03, 0, 0.5, 0.5).range(0.0, 1.0);
    var timbre = LFTri.ar(0.07, 0, 0.5, 0.5).range(0.0, 1.0);
    var morph = LFTri.ar(0.11, 0, 0.5, 0.5).squared;

    var pitch = Latch.ar(WhiteNoise.ar(12, 36), trigger).round;
    var engine = Latch.ar(WhiteNoise.ar(8,8), trigger).round;
    var sub = SinOsc.ar(pitch.midicps, 0, 0.2);
    var mi = MiPlaits.ar( pitch, engine, harmonics, timbre, morph,
        trigger: trigger, usetrigger: 1, decay: 0.8, lpg_colour: 0.2);
    mi + sub
}.play
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(1, {
    {
    var trig = Impulse.ar(0.25);
    MiPlaits.ar(31 + 0 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.95,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 0,
        mul: 6)
    }.play;
    nil;
});
)

Server.local.options.sampleRate = 96000;
Server.local.options.sampleRate = 192000;
96000 * 2
Server.local.options.sampleRate = 44100;
Server.local.options.sampleRate = 48000;
Server.local.options.sampleRate
s.options.sampleRate
s.sampleRate
s.boot;
s.record;
s.stopRecording;


(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
    {
    var trig = Impulse.ar(1);
    MiPlaits.ar(31 + 24 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3)
    }.play;
    nil;
});
)
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
    {
    var trig = Impulse.ar(4);
    MiPlaits.ar(39 + 24 + 16 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 2)
    }.play;
    nil;
});
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
    {
    var trig = Impulse.ar(1);
    MiPlaits.ar(88 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 2)
    }.play;
    nil;
});
)
~toMidi.("E6")
x = { MiPlaits.ar(38 + -7 + [0, 0.1], 5, harm: SinOsc.kr(0.1).range(0.1, 0.25), morph: 0, mul: 0.2) }.play;



(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
    {
    var trig = Impulse.ar(0.125);
    MiPlaits.ar(88 - 12 + [0, 0.1],
        engine: 9,
        harm: 0.75,
        timbre: 0.05,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.95,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 0,
        mul: 2)
    }.play;
    nil;
});
)