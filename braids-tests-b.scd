(
var f = 60;
{
    var sig0 = MiBraids.ar(f, 0.5, 0.5, 24, resamp: 1, mul: 0.2)!2
    var sig1 = MiBraids.ar(f * 1.01, 0.5, 0.5, 24, resamp: 1, mul: 0.2)!2

}.play;
)

y.free;
y = { MiBraids.ar(52 + 7 * [1, 1.001], 0.025, 0.75, 3, resamp: 2, decim: 2, ws: 0.6, mul: 0.1)}.play
y = { MiBraids.ar(45 + 24 - 24 - 5 * [1, 1.01], 0.5, 0.5, 29, resamp: 1, mul: 0.2)}.play


(
{
    var trig = Impulse.kr(4);
    MiBraids.ar(45 + 12 + 24 + -5 * [1, 1.001], Line.kr(0.5, 0, 4), Line.kr(0, 0.5, 4), 4, trig: trig, resamp: 0, mul: 0.2);
}.play;
)
45.midicps

y.free;
(
y = {
    var trig = Impulse.kr(4);
    var notes = Demand.kr(trig, 0, Dseq(42 + 5 + 12 + 0 + [-15, -5, 0, -5, -12, 2] + 0, inf));
    var lfo = SinOsc.kr(0.5).range(0.125, 0.75);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var sig = MiBraids.ar(notes * [1, 1.001], 0.25, 0.5, 10, resamp: 0, mul: 0.3);
    sig = RLPF.ar(sig, notes.midicps * 2) * XLine.kr(0.001, 1, 5);
    sig;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    // MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)










y.free;
(
y = {
    var trig = Impulse.kr(4);
    var notes = Demand.kr(trig, 0, Dseq(62 + 5 + [-15, -5, 0, -5, -12, 2] + 0, inf));
    var lfo = SinOsc.kr(0.5).range(0.125, 0.75);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var sig = MiBraids.ar(notes * [1, 1.001], [lfo, lfo2], 0.15, 0, resamp: 0, mul: 0.3);
    sig = LPF.ar(sig, 1000 + lfo3);
    sig = sig + (LPF.ar(sig, 200) * 16);
    MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)


y.free;
(
y = {
    var trig = Impulse.kr(4);
    var notes = Demand.kr(trig, 0, Dseq(62 + 5 + 0 + [-15, -5, 0, -5, -12, 2] + 0, inf));
    var lfo = SinOsc.kr(0.5).range(0.125, 0.75);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var sig = MiBraids.ar(notes * [1, 1.001], [lfo, lfo2], 0.15, 0, resamp: 0, mul: 0.3);
    sig = LPF.ar(sig, 1000 + lfo3);
    sig = sig + (LPF.ar(sig, 200) * 16);
    MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)







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

(
// 3:SINE_TRIANGLE
var f = ~toMidi.("B3") + 0;
var m = 41;
~drone = {
    var lfo = SinOsc.kr(0.1).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2, pi).range(0.025, 0.85);
    var sig = MiBraids.ar(f - 12 * [1, 1.001], lfo, lfo2, m, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, m, resamp: 1, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, m, resamp: 1, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)