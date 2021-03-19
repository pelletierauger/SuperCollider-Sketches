(
var att = 0.05;
x.free;
x = {
    var pulse = 7.5 * 0.25;
    var atk = att;
    var trig = Impulse.kr(pulse);
    var freqShift = Demand.kr(trig, 0, Dseq([5, 0], inf));
    var freq = 50 + 12 - 9 - 5 - 12 + -12 + Demand.kr(trig, 0, Dseq([12, 10].stutter(8), inf));
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var engine = Demand.kr(trig, 0, Dseq([1, 3].stutter(2), inf));
    var harm = Demand.kr(trig, 0, Dseq([1, 2].stutter(1) / 2, inf)), timbre = 0.5, morph = 0.5, decay = 0.25;
    var dem = Demand.kr(trig, 0, Dseq([0.1, -0.1], inf));
    var amp = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [atk, 1 / pulse - atk], [7, 2]), trig);
    var sig1 = MiPlaits.ar(freq,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + dem,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * amp * 0.5;
    var delTime = 0.025;
    var del = Demand.kr(trig, 0, Dseq([0, -12].stutter(16), inf));
    var vol = Demand.kr(trig, 0, Dseq([0.25, 1].stutter(16), inf));
    var delSig = DelayC.ar(sig.lag(0.001) * 0.991, delTime, delTime);
    	delSig = sig * 4 + (CombC.ar(in: sig,
        maxdelaytime: 0.5,
        delaytime: ((freq + del).midicps).reciprocal,
        decaytime: 20,
        mul: 1, add: 0) * vol);
    delSig;
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9);
}.play;
/*
y.free;
y = {
    var pulse = 7.5 * 0.125;
    var atk = att;
    var trig = Impulse.kr(pulse, 0.5);
    var freqShift = Demand.kr(trig, 0, Dseq([5, 0], inf));
    var freq = 50 + 12 - 9 - 0;
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var engine = 2, harm = 0.65, timbre = 0.5, decay = 0.3;
    var dem = Demand.kr(trig, 0, Dseq([0.1, -0.1], inf));
    var amp = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [atk, 1 / pulse - atk], [7, 2]), trig);
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
    var sig = [sig1[0], sig2[0]] * amp * 0.25;
    sig;
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9);
}.play;*/
)

x.free;
(
{
    var trig = Impulse.kr(1);
    var env = EnvGen.kr(Env.new([0.5, 1.0, 0.5], [0.1, 0.1], [7, 2]), trig);
    env;
}.plot(4);
)



(
z.free;
z = {
    var pulse = 7.5 * 0.0625 * 0.5;
    var atk = 0.25;
    var trig = Impulse.kr(pulse);
    var freqShift = Demand.kr(trig, 0, Dseq([2, 0], inf));
    var freq = 50 + 12 - 9 - 14 - 0 - 7 + freqShift;
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var engine = 5, harm = 0.65, timbre = 0.5, decay = 0.3;
    var dem = Demand.kr(trig, 0, Dseq([0.1, -0.1], inf));
    var amp = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [atk, 1 / pulse - atk], [7, 2]), trig);
    var sig1 = MiPlaits.ar(freq,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        // morph: 0.5,
        // trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + dem,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: env,
        // morph: Line.kr(0.5, 1, 4),
        // morph: 0.5,
        // trigger: trig,
        // usetrigger: 1,
        // morph_mod: 0.5,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * 0.125;
    sig * Line.kr(0, 1, 3);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9);
}.play;
)