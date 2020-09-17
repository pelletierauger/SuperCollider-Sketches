
(
var f = 55 + 12 - 5;
{
    var sig;
    var lfo = SinOsc.kr(0.1 * 1).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(2, pi).range(0.025, 0.5);
    sig = MiBraids.ar(f - 5 * [1, 1], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1) * 4;
    sig = sig + (MiBraids.ar(f - 12 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1) * 4);
    sig = sig + (MiBraids.ar(f + 2 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1) * 4);
    sig = sig + (MiBraids.ar(f + 4 * [1, 1.001], lfo, lfo2, 3, resamp: 0, decim: 2, ws: 0.6, mul: 0.1) * 4);
    sig = LPF.ar(sig, 600) * 0.25;
}.play;
)

