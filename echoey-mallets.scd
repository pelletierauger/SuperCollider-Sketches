
Server.local.options.sampleRate = 48000;

(
var ver = 1;
var i = 4;
m.free;
m = {
    var freq = 31 + 12 + 24 + -5 + -5;
    var trig = Impulse.ar(i, 0.1);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.25;
    var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 6] ++ [3, 5, 8, 10]).stutter(16), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/10, 16).asStream.nextN(16).reverse, inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig1 = MiPlaits2.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * dem2;
    // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
    // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), amount: 0.125, diff: 0.95, damp: 0.75, mul: 0.125 * ver);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 2000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.125;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
)

~toMidi.("A#3")

(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3");
f = 62 + 3 - 7;
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2, pi).range(0.025, 0.85);
    var sig = MiBraids.ar(f - 12 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f + 12 * [1, 1.001], lfo, lfo2, 3, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    sig = LPF.ar(sig, 1000);
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)
~drone.free;

Pseries(0.125, 1/64, 48).asStream.nextN(48)[47]
(
var ver = 1;
var i = 8;
o.free;
o = {
    var freq = 31 + 12 + 24 + -5 + -5;
    var trig = Impulse.ar(i, 0.1);
    var dec = Demand.ar(trig, 0, Dseq(Pseries(0.125, 1/64, 48).asStream.nextN(48), inf));
    var engine = 2, harm = 0.65, timbre = 0.5, morph = 0.45, decay = dec;
    var dem = Demand.ar(trig, 0, Dseq(([8, 10, 12, 10]).stutter(48), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/10, 48).asStream.nextN(48).reverse, inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig1 = MiPlaits2.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * dem2;
    // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
    // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), amount: 0.125, diff: 0.95, damp: 0.75, mul: 0.125 * ver);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 9000) * Line.kr(0, 1, 0.01) * 0.125 * 0.125;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
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
        contour: 0.75,
        bow_level: 0.0,
        strike_level: 0.1 * amp,
        mallet: 0.5,
        bow_timb: 0.5,
        bright: 0.5,
        damp: 0.4,
        geom: 0.15,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.7,
        model: 1
    );
    [sig[1], sig[0]] * 4;
}.play;
)



(
y.free;
y = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    // var trig = SinOsc.kr(0.5).round;
    var trig = Impulse.kr(7.5 * 0.75 * 0.5);
    var amp = Demand.kr(trig, 0, Dseq(Pseries(1, -1/16, 16).asStream.nextN(16), inf));
    var sig = MiElements.ar(
        gate: trig,
        pit: 46,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1 * amp,
        mallet: 0.5,
        bow_timb: 0.5,
        bright: 0.0,
        damp: 0.3,
        geom: 0.125,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.7,
        model: 1
    );
    LPF.ar([sig[0], sig[1]], 46.midicps * 4) * 32;
}.play;
)


(
x.free;
x = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    // var trig = SinOsc.kr(0.5).round;
    var trig = Impulse.kr(7.5 * 0.75 * 0.5);
    var amp = Demand.kr(trig, 0, Dseq(Pseries(1, -1/16, 16).asStream.nextN(16), inf));
    var sig = MiElements.ar(
        gate: trig,
        pit: 46 + 7,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1 * amp,
        mallet: 0.5,
        bow_timb: 0.5,
        bright: 0.0,
        damp: 0.3,
        geom: 0.125,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.7,
        model: 1
    );
    LPF.ar([sig[0], sig[1]], 46.midicps * 4) * 32;
}.play;
)

s.record;
s.stopRecording;