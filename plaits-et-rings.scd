(
y.free;
y = {
    var trig, env, amp, fil, sig;
    trig = Impulse.ar(1!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 0.1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.002, 0.3]), trig);
    sig = MiPlaits.ar(31 + 24 + 0 + 12 + [0, 0.1],
        engine: 12,
        harm: 0.75,
        // harm: SinOsc.ar(0.1).range(0.5, 0.75),
        timbre: env,
        morph: 0.1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 2 * amp * 1);
    MiRings.ar(sig,
        trig,
        pit: 50 + 7,
        struct: 0.1,
        bright: 0.2,
        damp: 0.1,
        pos: 0.9,
        use_trig: 0,
        bypass: 0) * 2;
}.play;
x.free;
x = {
    var trig, env, amp, fil, sig, dem;
    trig = Impulse.ar(8!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    dem = Demand.ar(trig[0], 1, Dseq([1, 0.0625], inf));
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 0.1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.002, 0.3]), trig);
    sig = MiPlaits.ar(31 + 24 + 0 + 12 + [0, 0.1],
        engine: 12,
        harm: 0.75,
        // harm: SinOsc.ar(0.1).range(0.5, 0.75),
        timbre: env,
        morph: 0.1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 2 * amp * 1);
    MiRings.ar(sig,
        trig,
        pit: 50 + 7 + 5,
        struct: 0.1,
        bright: 0.2,
        damp: 0.1,
        pos: 0.9,
        use_trig: 0,
        bypass: 0) * 2;
}.play;
)