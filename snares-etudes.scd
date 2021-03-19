(
v.free;
v = {
    var trig, env, amp, fil, sig, dem;
    trig = Impulse.ar(4);
    // trig = trig + Impulse.ar(1!2, 0.25);
    dem = Demand.ar(trig, 0, Dseq([1, 1, 1, 8] / 10, inf));
    trig = trig * Demand.ar(trig, 0, Dseq([1, 0, 0, 1, 1, 0, 1, 0], inf));
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
    sig = MiPlaits.ar(32 + 48 + (dem * 0),
        engine: 15,
        harm: 0.5,
        timbre: 0.85,
        morph: 0,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 2 * amp * 2);
    sig = sig[0]!2 * 1;
    // LPF.ar(sig, 1000) * 8;
}.play;
)

(
w.free;
w = {
    var trig, env, amp, fil, sig, dem;
    trig = Impulse.ar(2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    dem = Demand.ar(trig, 0, Dseq([1, 8] / 10, inf));
    trig = trig * Demand.ar(trig, 0, Dseq([1], inf));
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
    sig = MiPlaits.ar(32 + 48 + (dem * 0) + 0,
        engine: 15,
        harm: 0.75,
        timbre: 0.85,
        morph: dem,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 2 * amp * 2);
    sig = sig[0]!2 * 0.25;
    // LPF.ar(sig, 1000) * 8;
}.play;
)

(
w.free;
w = {
    var trig, env, amp, fil, sig;
    trig = Impulse.ar(1);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
    sig = MiPlaits.ar(31 + 24 + 0 + -11 - 19,
        engine: 14,
        harm: 0.25,
        timbre: env,
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 0,
        mul: 2 * amp * 4) * 8;
    sig[0]!2;
}.play;
)