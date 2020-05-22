y.free;
(
y = {
    var trig = Impulse.kr(4);
    var notes = Demand.kr(trig, 0,
        Dseq(42 + 5 + 12 + 0 + [-15, -5, 0, -5, -12, 2] + 0, inf)
    + Dseq([0, -5].stutter(6 * 4), inf));
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0.25, 0.75], inf));
    var lfo = SinOsc.kr(0.5).range(0.125, 0.75);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.001, 0.1]), gate: trig);
    var sig = MiBraids.ar(notes * [1, 1.001], dem, dem2, 1, resamp: 1, mul: 0.3);
    sig = RLPF.ar(sig, 100 + (500 * env)) * XLine.kr(0.001, 1, 3);
    // sig;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)

(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3");
f = 62 + 3 - 7 + -7;
~drone.free;
~drone = {
        var trig = Impulse.ar(0.1);
    var notes = Demand.ar(trig, 0, Dseq([0, -2], inf));
    var lfo = SinOsc.kr(0.1).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2, pi).range(0.025, 0.85);
    var ff = f + notes;
    var sig = MiBraids.ar(ff - 12 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 7 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(ff + 12 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    sig = LPF.ar(sig, 1000);
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 6 * XLine.kr(0.001, 1, 3);
}.play;
)
~drone.free;




y.free;
(
var f = 2;
x = {
    var trig = Impulse.kr(f);
    var notes = Demand.kr(trig, 0,
        Dseq(42 + 5 + 12 + 0 + [-15, -5, 0, -5, -12, 2] + 0, inf)
    + Dseq([0, -5].stutter(6 * 4), inf));
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0.25, 0.75], inf));
    var lfo = SinOsc.kr(0.5).range(0.125, 0.75);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.001, 0.1]), gate: trig);
    var sig = MiBraids.ar(notes * [1, 1.001], dem, dem2, 1, resamp: 1, mul: 0.3);
    sig = RLPF.ar(sig, 100 + (500 * env)) * XLine.kr(0.001, 1, 3);
    // sig;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;


TempoClock.default.sched(0.125 * 1, {
    y = {
    var trig = Impulse.kr(f);
    var notes = Demand.kr(trig, 0,
        Dseq(42 + 5 + 12 + 12 + [-15, -5, 0, -5, -12, 2].reverse + 0, inf)
    + Dseq([0, -5].stutter(6 * 4), inf));
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0.25, 0.75], inf));
    var lfo = SinOsc.kr(0.5).range(0.125, 0.75);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.001, 0.1]), gate: trig);
    var sig = MiBraids.ar(notes * [1, 1.001], dem, dem2, 1, resamp: 1, mul: 0.3);
    sig = RLPF.ar(sig, 100 + (500 * env)) * XLine.kr(0.001, 1, 3);
    // sig;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
            nil;
});
)