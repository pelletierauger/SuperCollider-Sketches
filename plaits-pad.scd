(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
var key = 31 + 5 + 24 - 5;
TempoClock.default.sched(1, {
    {
    var trig = Impulse.ar(0.0125);
    var sig = MiPlaits.ar(key + 0 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.95,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 0,
        mul: 6);
    sig * Line.kr(0, 1, 12);
    }.play;
    {
    var trig = Impulse.ar(0.0125);
    var sig = MiPlaits.ar(key + 0 + 16 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.95,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 0,
        mul: 6);
    sig * Line.kr(0, 1, 12);
    }.play;
        {
    var trig = Impulse.ar(0.0125);
    var sig = MiPlaits.ar(key + 0 + 12 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.95,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 0,
        mul: 6);
    sig * Line.kr(0, 1, 12);
    }.play;
    nil;
});
)