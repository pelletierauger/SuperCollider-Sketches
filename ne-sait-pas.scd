(
var att = 0.0125;
y.free;
y = {
    var pulse = 7.5 * 0.75 * 2;
    var atk = att;
    var trig = Impulse.kr(pulse);
    var freqShift = Demand.kr(trig, 0, Dseq([5, 0], inf));
    var freq = 50 + 12 - 9 - 5 + 12 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 4, 7, 11, 14, 16, 19, 26, 28].reverse.stutter(2), inf));
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var engine = 2, harm = 0.25, timbre = 0.95, morph = 0.95, decay = 0.45;
    var dem = Demand.kr(trig, 0, Dseq([0.1, -0.1], inf));
    var amp = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [atk, 1 / pulse - atk], [7, 2]), trig);
    var sig1 = MiPlaits2.ar(freq,
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
    var sig2 = MiPlaits2.ar(freq + dem,
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
    var sig = [sig1[0], sig2[0]] * amp * 0.25;

    var lfo2 = SinOsc.kr(0.1).range(0.2, 0.75);
    var risig = MiRings.ar(sig[0],
            0,
            pit: freq,
            struct: 0.15,
            bright: 0.2,
            damp: lfo2,
            pos: 0.8,
            bypass: 0);
    var risig2 = MiRings.ar(sig[1],
            0,
            pit: freq,
            struct: 0.15,
            bright: 0.2,
            damp: lfo2,
            pos: 0.8,
            bypass: 0);
[risig[0], risig2[1]] * 0.1 + sig;
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9);
}.play;
)