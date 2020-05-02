(
var att = 0.125;
var atts = Pseries(0.125, -0.0125 * 0.53, 16).asStream.nextN(16).mirror2;
y.free;
y = {
    var pulse = 7.5 * 0.75 * 0.5;
    // var atk = att;
    var trig = Impulse.kr(pulse);
    var freqShift = Demand.kr(trig, 0, Dseq([5, 0], inf));
    // var freq = 50 + 12 - 9 - 5 + 12 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 4, 7, 11, 14, 16, 19, 26, 28].reverse.stutter(2), inf));
    var freq = 50 + 12 - 9 - 5 + 12 - 3 + Demand.kr(trig, 0, Dseq([7, 12, 14, 16].stutter(2).reverse, inf));
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var harmDem = Demand.kr(trig, 0, Dseq([0.25, 0.5].stutter(16), inf));
    var engine = 2, harm = harmDem, timbre = 0.5, morph = 0.95, decay = 0.45;
    var dem = Demand.kr(trig, 0, Dseq([0.1, -0.1], inf));
    // var att = Demand.kr(trig, 0, Dseq([9, 12, 14, 16].reverse.stutter(2), inf));
    var atk = Demand.kr(trig, 0, Dseq(atts.stutter(4), inf));
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
    var pre = [sig1[0], sig2[0]] * amp * 0.25;

/*    var lfo2 = SinOsc.kr(0.1).range(0.75, 0.75);
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
    var pre = [risig[0], risig2[1]] * 0.1 + sig * 0.5;*/
    var del = CombC.ar(in: pre,
    maxdelaytime: 0.6,
    delaytime: [0.5, 0.5],
    decaytime: 10,
    mul: 1, add: 0);
    // pre = pre + LPF.ar(del * 0.5, 2900);
    MiVerb.ar(pre, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75;
}.play;
)




b.free;
(
b = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    // var trig = SinOsc.kr(0.5).round;
    var trig = Impulse.kr(7.5 * 0.75 * 0.25);
    var amp = Demand.kr(trig, 0, Dseq(Pseries(1, -1/16, 16).asStream.nextN(16), inf));
    var amp2 = EnvGen.kr(Env.new([0.0, 0.2, 0.0], [0.2, 0.8], [7, 2]), trig);
    // var amp3 = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [0.5, 0.8], [7, 2]), trig);
    var sig = MiElements.ar(
        gate: trig,
        pit: 32 + 12 + 12 + 12 + 5 + 12 - -5,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1 * amp2,
        mallet: 0.5,
        bow_timb: 0.5,
        bright: 0.5,
        damp: 0.4,
        geom: 0.85,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.7,
        model: 1
    );
    sig * 16;
}.play;
)
(
z.free;
z = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    // var trig = SinOsc.kr(0.5).round;
    var trig = Impulse.kr(7.5 * 0.75 * 0.25);
    var amp = Demand.kr(trig, 0, Dseq(Pseries(1, -1/16, 16).asStream.nextN(16), inf));
    var sig = MiElements.ar(
        gate: trig,
        pit: 32 + 12 + 12 + 12 + 2,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1 * amp,
        mallet: 0.5,
        bow_timb: 0.5,
        bright: 0.5,
        damp: 0.4,
        geom: 0.85,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.7,
        model: 1
    );
    [sig[1], sig[0]] * 4;
}.play;
)
