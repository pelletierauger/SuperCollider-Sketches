(
x = {
    var freq = 50 + 12 + 0;
    var trig = Impulse.kr(1);
    var env = EnvGen.kr(Env.new([0.5, 0.85, 0.5], [0.1, 1.2]), trig);
    var engine = 2, harm = 0.5, timbre = 0.5, decay = 0.7;
    var dem = Demand.kr(trig, 0, Dseq([0.1, -0.1], inf));
    var amp = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [0.01, 0.8], [7, 2]), trig);
    var sig1 = MiPlaits2.ar(freq,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        // morph: 0.5,
        trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + dem,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        // morph: 0.5,
        trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * amp;
    // sig;
    MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9);
}.play;
)

x.free;
(
{
    var trig = Impulse.kr(1);
    var env = EnvGen.kr(Env.new([0.5, 1.0, 0.5], [0.1, 0.1], [7, 2]), trig);
    env;
}.plot(4);
)