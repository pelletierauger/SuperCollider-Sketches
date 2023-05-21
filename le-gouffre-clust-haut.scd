(
~nT.schedAbs(~nT.nextBar + 0.5, {
    y.free;
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([6, 9, 8, 11].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 0.5, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3,0 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 26 + 24 + d + 12 + 24 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) - 0,
            timbre: (0..20).size * 0.025, color: 0.125, model: 21,
            resamp: 2, decim: 12 * e, bits: 2, ws: 0.5
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
        sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)



(
~nT.schedAbs(~nT.nextBar + 0.5, {
    y.free;
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([6, 9, 8, 11].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 0.5, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3,0 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 26 + 24 + d + 12 + 24 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) - 0,
            timbre: (0..20).size * 0.025, color: 0.125, model: 6,
            resamp: 2, decim: 12 * e, bits: 2, ws: 0.5
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
        sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 1);
    }.play;
});
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
    sig = VadimFilter.ar(sig, 1000, 0, 3) * 0.6 * Line.kr(0, 1, 10);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
}.play;
)