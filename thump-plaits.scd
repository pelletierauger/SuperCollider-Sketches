(
{
    var trig, env, amp, fil;
    trig = Impulse.ar(0.5!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.2, 0.3]), trig);
    MiPlaits.ar(31 + 24 + 0 + -12 + [0, 0.1],
        engine: 6,
        harm: 0.5,
        timbre: env,
        morph: 0.1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 0,
        mul: 2 * amp * 1);
}.play;
)
(
{
    var trig, env, amp, fil;
    trig = Impulse.ar(0.5!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.2, 0.9]), trig);
    MiPlaits.ar(31 + 24 + 0 + -12 + [0, 0.1],
        engine: 6,
        harm: 0.5,
        timbre: env,
        morph: 0.3,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 0,
        mul: 2 * amp * 1);
}.play;
)
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
    {
    var trig = Impulse.ar(1);
    MiPlaits.ar(31 + 24 + 0 + -12 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 15)
    }.play;
    nil;
});
)

~key = "G0"