(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3");
~drone = {
    var lfo = SinOsc.kr(0.1).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2, pi).range(0.025, 0.85);
    var sig = MiBraids.ar(f - 12 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)
~drone.free;
(
~shimmerE.stop;
~shimmerE = Pbind(
    \instrument, \guitare,
    \dur, 0.0625,
    \spos, Pseq([0.43].stutter(8), inf)
    + Pseq(Pseries(0, 0.0001, 32).asStream.nextN(32).mirror2, inf)
    - (0.0025 * 0.75),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1],
    \amp, 0.45,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)




(
var att = 0.05;
v.free;
v = {
    var pulse = 7.5 * 0.75 * 1;
    var atk = att;
    var trig = Impulse.kr(pulse);
    var freqShift = Demand.kr(trig, 0, Dseq([5, 0], inf));
    // var freq = 50 + 12 - 9 - 5 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 4, 7, 11, 14, 16, 19, 26, 28], inf));
    var freq = 50 + 36 - 9 - 8 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 4, 7], inf));
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var harmDem = Demand.kr(trig, 0, Dseq([0.25, 0.5, 0.75].stutter(10), inf));
    var engine = 2, harm = harmDem, timbre = 0.25, morph = 0.5, decay = 0.5;
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
    sig;
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9);
}.play;
)


(
var att = 0.05;
w.free;
w = {
    var pulse = 7.5 * 0.75 * 0.5;
    var atk = att;
    var trig = Impulse.kr(pulse);
    var freqShift = Demand.kr(trig, 0, Dseq([5, 0], inf));
    // var freq = 50 + 12 - 9 - 5 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 4, 7, 11, 14, 16, 19, 26, 28], inf));
    var freq = 50 + 24 - 9 - 8 + Demand.kr(trig, 0, Dseq([-12, -5, 2, 4, 7], inf));
    var env = EnvGen.kr(Env.new([0.45, 0.5, 0.45], [0.1, 1.2]), trig);
    var harmDem = Demand.kr(trig, 0, Dseq([0.25, 0.5, 0.75].stutter(10), inf));
    var engine = 2, harm = harmDem, timbre = 0.25, morph = 0.5, decay = 0.5;
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
    sig;
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9);
}.play;
)
