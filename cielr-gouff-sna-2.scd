(
var f = ~toMidi.("Db3");
~drone2.free;
~drone2 = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0] ++
        [0, 0, 0, 0, 1, 0, 0, 0], inf));
    var ek = Demand.kr(b, 0, Dseq([3000, 5000].stutter(2), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, 2], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 43;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek, 0, 3) * sig * 80 * e * Line.kr(0, 1, 1);
}.play;
)



(
var f = ~toMidi.("Db1");
~drone2.free;
~drone2 = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0] ++
        [0, 0, 0, 0, 1, 0, 0, 0], inf));
    var ek = Demand.kr(b, 0, Dseq([3000, 5000].stutter(2), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, 4], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 43;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek, 0, 3) * 4 * e * Line.kr(0, 1, 1);
}.play;
)



(
var f = ~toMidi.("Db0");
~drone2.free;
~drone2 = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0] ++
        [0, 0, 0, 0, 1, 0, 0, 0], inf));
    var ek = Demand.kr(b, 0, Dseq([3000, 5000].stutter(2), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, 4], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 43;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek, 0, 3) * 4 * e * Line.kr(0, 1, 1);
}.play;
)



(
var f = ~toMidi.("Db5");
~drone2.free;
~drone2 = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0] ++
        [0, 0, 1, 0, 0, 0, 0, 0], inf));
    var ek = Demand.kr(b, 0, Dseq([3000, 5000].stutter(2), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, 4], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125) * 0;
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65) * 0;
    var model = 42;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek, 0, 1) * 8 * e * Line.kr(0, 1, 1);
}.play;
)


(
var f = ~toMidi.("Db5");
~drone2.free;
~drone2 = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0] ++
        [0, 0, 1, 0, 0, 0, 0, 0], inf));
    var ek = Demand.kr(b, 0, Dseq([3000, 5000, 8000, 11000].mirror2.stutter(2), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, 6], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125) * 0;
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65) * 0;
    var model = 0;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek, 0, 3) * 2 * e * Line.kr(0, 1, 1);
}.play;
)