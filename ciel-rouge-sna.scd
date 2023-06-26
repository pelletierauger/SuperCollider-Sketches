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
    sig = VadimFilter.ar(sig, ek, 0, 3) * sig * 40 * e * Line.kr(0, 1, 1);
}.play;
)



(
var f = ~toMidi.("Db3");
~drone2.free;
~drone2 = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 0, 1, 0] ++ [0, 1, 0, 0], inf));
    var ek = Demand.kr(b, 0, Dseq([3000, 5000].stutter(2), inf));
    var ek2 = Demand.kr(b, 0, Dseq([2, 4].stutter(1), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, ek2], ['lin', -8]), gate: b);
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
var f = ~toMidi.("D3");
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
    var model = 14;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 2, decim: 22, ws: 0, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 2, decim: 22, ws: 0, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 2, decim: 22, ws: 0, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 2, decim: 22, ws: 0, mul: 0.025);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek, 0, 5) * sig * 80 *2 * e * Line.kr(0, 1, 1);
}.play;
)


(
var f = ~toMidi.("D5");
~drone2.free;
~drone2 = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [0, 0, 0, 0, 1, 0, 0, 0] ++
        [0, 0, 0, 0, 1, 0, 0, 0], inf));
    var ek = Demand.kr(b, 0, Dseq([3000, 5000].stutter(2) - 2000, inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, 2], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 43;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 22, ws: 0, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 22, ws: 0, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 22, ws: 0, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 22, ws: 0, mul: 0.025);
    // sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    // sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek, 0, 3) * sig * 8 *2 * e * Line.kr(0, 1, 1);
}.play;
)