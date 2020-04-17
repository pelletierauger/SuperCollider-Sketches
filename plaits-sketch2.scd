(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
    {
    var trig = Impulse.ar(0.1);
    var sig = MiPlaits.ar(31 + 4 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.01,
        lpg_colour: 0,
        mul: 6);
        // sig * SinOsc.kr([3, 3.1]);
    HPF.ar(sig * Line.kr(1, 0, 2), 440);
    }.play;
)