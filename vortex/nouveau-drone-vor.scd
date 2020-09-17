(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3");
f = 62 + 3 - 7;
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 0.25).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 0.25, pi).range(0.025, 0.85);
    var sig = MiBraids.ar(f - 12 * [1, 1.001], 0.4, 0.8, 37, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig * 0;
    // sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    // sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + (MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 6);
    // sig = sig + (MiBraids.ar(f - 36 * [1, 1.001], lfo, lfo2, 12, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 24);
    // sig = sig + (MiBraids.ar(f * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 2);
    // sig = LPF.ar(sig, 1000);
    // sig = sig + (MiBraids.ar(f + 12 + 12 * [1, 1.001], lfo, lfo2, 4, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 1);
    sig = sig + (MiBraids.ar(f + 0 + 12 * [1, 1.001], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25 * 0.25);
    sig = sig + (MiBraids.ar(f + 2 + 12 * [1, 1.001], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25 * 0.25);
    sig = sig + (MiBraids.ar(f + 4 + 12 * [1, 1.001], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25 * 0.25);
    // sig = sig + (MiBraids.ar(f - 3 + 12 * [1, 1.001], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25 * 0.25);
    sig = sig + (MiBraids.ar(f + -1 + 12 * [1, 1.001], lfo, lfo2, 5, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25 * 0.25);
    sig = sig + (MiBraids.ar(f + 4 + 12 * [1, 1.001], lfo, lfo2, 4, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25 * 2);
    sig = sig + (MiBraids.ar(f - 1 + 12 * [0.998, 1], lfo, lfo2, 4, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25 * 2);
    sig = sig + (MiBraids.ar(f - 3 + 12 * [1.002, 1], lfo, lfo2, 4, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25);
    sig = sig + (MiBraids.ar(f - 3 + 12 * [1.001, 1.004] * 2, lfo, lfo2, 4, resamp: 0, decim: 2, ws: 0.6, mul: 0.025) * 0.25);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)


(
var freq = 55 * 36.midiratio * [1, 1.01];
~grillon2.free;
~grillon2 = {
    var f = 0.125;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 32;
    var trig = Impulse.ar(f);
    // var trig2 = Impulse.ar(f * 0.25);
    // var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.0625, dec, 4.75 - 0.0625 - dec]), gate: trig);
    var env = SinOsc.ar(0.05).range(0.125, 1) * 0.1;
    var modIndex = Line.ar(1, 2, 120);
    var lfo = SinOsc.ar(0.1).range(0.25, 1.0);
    var op4 = SinOsc.ar(freq * 0.125) * 1700;
    var op3 = SinOsc.ar(freq * 2, op4 % 2pi) * 7;
    var op2 = SinOsc.ar(freq * 2, op3 % 2pi) * lfo * 1;
    var op1 = SinOsc.ar(freq, op2 * modIndex % 2pi);
    var sig = op1 * 0.125 * env;
    // (sig * 0.1) + MiRings2.ar(sig, pit: 15);
    HPF.ar(sig, 1600);
}.play;
)
