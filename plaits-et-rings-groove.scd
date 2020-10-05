(
y.free;
y = {
    var trig, env, amp, fil, sig;
    trig = Impulse.kr(0.5!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 0.1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.002, 0.3]), trig);
    sig = MiPlaits.ar(31 + 24 + 0 + 12 + [0, 0.1] - 12,
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
        pit: 50 + 7 - 12,
        struct: 0.1,
        bright: 0.2,
        damp: 0.1,
        pos: 0.9,
        use_trig: 0,
        bypass: 0) * 8;
}.play;
x.free;
x = {
    var trig, env, amp, fil, sig, dem;
    trig = Impulse.ar(4!2);
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
        pit: 50 + 7 + 5 + 12,
        struct: 0.1,
        bright: 0.2,
        damp: 0.1,
        pos: 0.9,
        use_trig: 0,
        bypass: 0) * 2;
}.play;
)


(
x.free;
x = {
    var trig, env, amp, fil, sig, dem, dem2, del;
    trig = Impulse.ar(2!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    dem = Demand.ar(trig[0], 1, Dseq([24, 0, 12, 0], inf));
    dem2 = Demand.ar(trig[0], 1, Dseq([0.05, 0.1, 0.1, 0.1], inf));
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 0.1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.002, 0.3]), trig);
    sig = MiPlaits.ar(31 + 24 + 0 + 12 + [0, 0.1] + dem - 12,
        engine: 12,
        harm: 0.75,
        // harm: SinOsc.ar(0.1).range(0.5, 0.75),
        timbre: env,
        morph: dem2,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 2 * amp * 1);
    sig = MiRings.ar(sig,
        trig,
        pit: 50 + 7 + 5 + -5,
        struct: 0.1,
        bright: 0.1,
        damp: 0.3,
        pos: 0.1,
        use_trig: 0,
        bypass: 0) * 10;
    del = SinOsc.ar(0.1).range(1, 0.8);
    sig = sig + CombC.ar(sig, maxdelaytime: [0.2, 0.5], delaytime: [0.2, 0.21]);
    HPF.ar(sig, 1000) * 50;
}.play;
)


(
x.free;
x = {
    var trig, env, amp, fil, sig, dem, dem2, dem3, del;
    trig = Impulse.ar(1!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    dem = Demand.ar(trig[0], 1, Dseq([24, 0, 12, 0], inf));
    dem2 = Demand.ar(trig[0], 1, Dseq([0.05, 0.1, 0.1, 0.1], inf));
    dem3 = Demand.ar(trig[0], 1, Dseq([1, 1, 1, 0], inf));
    trig = trig * dem3;
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 0.1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.002, 0.3]), trig);
    sig = MiPlaits.ar(31 + 24 + 0 + 12 + [0, 0.1] + dem - 12,
        engine: 12,
        harm: 0.75,
        // harm: SinOsc.ar(0.1).range(0.5, 0.75),
        timbre: env,
        morph: dem2,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 2 * amp * 1);
    sig = MiRings.ar(sig,
        trig,
        pit: 50 + 7 + 5 + -5,
        struct: 0.1,
        bright: 0.1,
        damp: 0.3,
        pos: 0.1,
        use_trig: 0,
        bypass: 0) * 10;
    del = SinOsc.ar(0.1).range(1, 0.8);
    sig = sig + (CombC.ar(sig,
        maxdelaytime: [0.2, 0.5],
        delaytime: [0.2, 0.21] * 0.2,
        decaytime: 4
    ) * 0.75);
    HPF.ar(sig, 1000) * 10;
}.play;
)

(
y.free;
y = {
    var trig, env, amp, fil, sig, dem, dem2, del;
    trig = Impulse.ar(1!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    dem = Demand.ar(trig[0], 1, Dseq([24, 0, 12, 0], inf));
    dem2 = Demand.ar(trig[0], 1, Dseq([0.05, 0.1, 0.1, 0.1], inf));
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 0.1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.002, 0.3]), trig);
    sig = MiPlaits.ar(31 + 24 + 0 + 12 + [0, 0.1] + dem - 12 - 12,
        engine: 12,
        harm: 0.75,
        // harm: SinOsc.ar(0.1).range(0.5, 0.75),
        timbre: env,
        morph: dem2,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 2 * amp * 1);
    sig = MiRings.ar(sig,
        trig,
        pit: 50 + 7 + 5 + -5,
        struct: 0.1,
        bright: 0.1,
        damp: 0.3,
        pos: 0.1,
        use_trig: 0,
        bypass: 0) * 10;
    del = SinOsc.ar(0.1).range(1, 0.8);
    sig = sig + (CombC.ar(sig,
        maxdelaytime: [0.2, 0.5],
        delaytime: [0.2, 0.21],
        decaytime: 4
    ) * 0.5);
    sig * 10;
    // HPF.ar(sig, 1000) * 50;
}.play;
)