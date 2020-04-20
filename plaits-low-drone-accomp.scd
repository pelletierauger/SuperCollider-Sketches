(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
e =    {
        var i = 0.75;
    var trig = Impulse.ar(i) + Impulse.ar(i, 0.15) + Impulse.ar(i, 0.25);
    MiPlaits.ar(31 + 24 + -12 + [0, 0.1],
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
e.free;
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
f.free;
f =    {
    var trig = Impulse.ar(0.75);
    MiPlaits.ar(31 + 24 + 2 + [0, 0.1],
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
g.free;
g =    {
    var trig = Impulse.ar(0.75);
    MiPlaits.ar(31 + 24 + 2 + 10 + [0, 0.1],
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