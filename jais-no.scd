(
// 3:SINE_TRIANGLE
// ~toMidi.("F3")
var f = ~toMidi.("E3");
~drone.free;
~drone = {
    arg filterCutoff = 2000, decim = 2, bits = 0, ws = 0.6;
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 16;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: decim, bits: bits, ws: ws, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: decim, bits: bits, ws: ws, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: decim, bits: bits, ws: ws, mul: 0.025);
    sig = sig + MiBraids.ar(f + 1 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: decim, bits: bits, ws: ws, mul: 0.025);
    sig = VadimFilter.ar(sig, filterCutoff, 0, 3) * 1.6 * Line.kr(0, 1, 30);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)
~drone.set(\filterCutoff, 4000);
~drone.set(\decim, 2);
~drone.set(\ws, 0.9);
~drone.set(\bits, 0);

(
~droneMod.stop;
~droneMod = Task {
    {
        ~drone.set(\filterCutoff, [2,3,4,5].choose + 5 * 1000); ([1,2,3,4,6,8].choose/4).wait;
    }.loop;
}.start(~nT, quant: 8);
)
