(
w.free;
w = {
    var trig, env, amp, fil;
    trig = Impulse.ar(1!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
    MiPlaits.ar(31 + 24 + 0 + -11 - 19 + [0, 0.1],
        engine: 13,
        harm: 0.25,
        timbre: env,
        morph: 0.1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 0,
        mul: 2 * amp * 4);
}.play;
)
(
v.free;
v = {
    var trig, env, amp, fil;
    trig = Impulse.ar(1!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
    MiPlaits.ar(31 + 24 + 0 + -11 - 19 + -24 + [0, 0.1],
        engine: 14,
        harm: 0.1,
        timbre: env,
        morph: 0.4,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 0,
        mul: 2 * amp * 2);
}.play;
)