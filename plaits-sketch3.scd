(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(1, {
    {
    var trig = Impulse.ar(0.25);
    MiPlaits.ar(31 + 0 + 12 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.95,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 0,
        mul: 1)
    }.play;
    nil;
});
)