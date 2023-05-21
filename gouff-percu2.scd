(
var f = ~toMidi.("Db3");
~droneW.free;
~droneW = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq([0, 0, 1, 0, 0, 0, 1, 0], inf));
    var ek = Demand.kr(t, 0, Dseq([3000, 5000].stutter(8), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, 4], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 43; var resamp = 0;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: resamp, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: resamp, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: resamp, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: resamp, decim: 2, ws: 0.6, mul: 0.025);
    // sig = sig * e;
    sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() + sig[0] * e, 0.75, 0.5, algo: 4, timb: 1)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() + sig[1] * e, 0.75, 0.5, algo: 4, timb: 1)[0]);
    sig = VadimFilter.ar(sig, ek + (1-e*7000), 0, 5) * dd.lag(0.025) * Line.kr(0, 1, 1);
    sig * dd.lag(0.025) * 0.5;
}.play;
)


(
var f = ~toMidi.("Db3");
~drone.free;
~drone = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [1, 0, 0, 1, 0, 0, 0, 0] ++
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [1, 0, 1, 0, 0, 0, 1, 0]
        , inf));
    var ek = Demand.kr(b, 0, Dseq((3000!9)++(4000!2), inf));
    var rel = Demand.kr(t, 0, Dseq([5, 8, 5, 8].stutter(8), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, rel], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 16;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);

    sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.95, algo: 3, timb: 0.8)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.95, algo: 3, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek - 2500 * e + 10, 0, 1) * 0.4 * e * Line.kr(0, 1, 1);
}.play;
)

// Le moment sacré

(
var f = ~toMidi.("Db5");
~drone.set(\trigGate, 0, \gate, 1, \fadeTime, 10);
~drone = {
| trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = (tr[1] * dd);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [1, 0, 0, 1, 0, 0, 1, 0] ++
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [1, 0, 1, 0, 0, 0, 1, 0]
        , inf));
    var ek = Demand.kr(b, 0, Dseq((3000!10)++(4000!2) - 2500, inf)).lag(0.5);
    var rel = Demand.kr(t, 0, Dseq([5, 8, 5, 8].stutter(8), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, rel], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 5;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);

    sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.95, algo: 3, timb: 0.8)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.95, algo: 3, timb: 0.8)[0]);
    sig = VadimFilter.ar(sig, ek * e + 10, 0, 1) * 0.4 * e * Line.kr(0, 1, 1);
    sig * dd.lag(0.001);
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
    var b = t * Demand.kr(t, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    var ek = Demand.kr(t, 0, Dseq([3000, 5000].stutter(8), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.01, 1], ['lin', -8]), gate: b);
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 16;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + -2 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, ek, 0, 5) * 2 * e * Line.kr(0, 1, 1);
    sig[0] = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
    sig[1] = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 4, timb: 0.8)[0]);
}.play;
)