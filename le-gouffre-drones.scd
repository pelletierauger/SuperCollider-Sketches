(
var f = ~toMidi.("Db3");
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 11;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 1 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, 1000, 0, 3) * 3.6 * Line.kr(0, 1, 10);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)


(
var f = ~toMidi.("Db4");
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 11;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 1 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, 1000, 0, 3) * 3.6 * Line.kr(0, 1, 10);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)


(
var f = ~toMidi.("Db5");
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 11;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 1 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, 1000, 0, 3) * 3.6 * Line.kr(0, 1, 10);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)



(
var f = ~toMidi.("Db3");
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 6;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 1 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, 1000, 0, 3) * 3.6 * Line.kr(0, 1, 10);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)

(
var f = ~toMidi.("Db3");
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 16;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 1 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, 3000, 0, 5) * 0.6 * Line.kr(0, 1, 10);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)