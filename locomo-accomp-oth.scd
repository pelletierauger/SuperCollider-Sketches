(
~input.free;
~input = {
    var in = LocalIn.ar(2);
    var t = Impulse.kr(2);
    var d = Demand.kr(t, 0, Dseq([0, 0, 3, 2, 0, 0, 3, 5].stutter(2), inf) + Dseq([0, 0].stutter(8), inf));
    var env = EnvGen.kr(Env([0,1,0], [0.05, 0.25], [16, -16]), gate: t);
    var sig = MiBraids.ar(pitch: ~toMidi.("A2") + d, timbre: 0.125, color: 0.15, model: 14);
    var filteredSig = ~v.(sig, 3000 * env + 400) + in;
    var filteredDelayedSig = DelayN.ar(filteredSig * 0.9, 1, 0.05 * [1, 1.01]);
    filteredDelayedSig = ~v.(filteredDelayedSig, 3500, 0);
    LocalOut.ar(filteredDelayedSig);
    sig = VAKorg35.ar(filteredSig, 2000, 0.5, 0.5, 0);
    Out.ar(0, sig * 0.05);
}.play;
)


(
~input.free;
~input = {
    var in = LocalIn.ar(2);
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([0, 0, 3, 2, 0, 0, 3, 5].stutter(2), inf) + Dseq([0, 0].stutter(8), inf));
    var env = EnvGen.kr(Env([0,1,0], [0.001, 2], [16, -16]), gate: t);
    var sig = MiBraids.ar(
        pitch: ~toMidi.("A3") + d, timbre: 0.125, color: 0.15, model: 14);
    var filteredSig = ~v.(sig, 5000 * env + 400) + in;
    var filteredDelayedSig = DelayN.ar(filteredSig * 0.9, 1, 1/8 * [1, 1.01]);
    filteredDelayedSig = ~v.(filteredDelayedSig, 3500, 0);
    LocalOut.ar(filteredDelayedSig);
    sig = VAKorg35.ar(filteredSig, 1000, 0.5, 1, 1);
    sig = ~v.(sig, 2000);
    Out.ar(0, sig * 0.05);
}.play;
)



(
~input.free;
~input = {
    var in = LocalIn.ar(2);
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([0, 0, 3, 2, 0, 0, 3, 5].stutter(2), inf) + Dseq([0, 0].stutter(8), inf));
    var env = EnvGen.kr(Env([0,1,0], [0.001, 2], [16, -16]), gate: t);
    var sig = MiBraids.ar(
        pitch: ~toMidi.("A4") + d, timbre: 0.5, color: 0.15, model: 4);
    var filteredSig = ~v.(sig, 5000 * env + 400) + in;
    var filteredDelayedSig = DelayN.ar(filteredSig * 0.9, 1, 1/8 * [1, 1.01]);
    filteredDelayedSig = ~v.(filteredDelayedSig, 3500, 0);
    LocalOut.ar(filteredDelayedSig);
    sig = VAKorg35.ar(filteredSig, 2000, 0.5, 1, 1);
    sig = ~v.(sig, 4000, 0, 3) * 8;
    Out.ar(0, sig * 0.05);
}.play;
)



(
~input.free;
~input = {
    var in = LocalIn.ar(2);
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([0, 0, 3, 2, 0, 0, 3, 5].stutter(2), inf) + Dseq([0, 0].stutter(8), inf));
    var env = EnvGen.kr(Env([0,1,0], [0.001, 0.5], [16, -16]), gate: t);
    var sig = MiBraids.ar(
        pitch: ~toMidi.("A5") + d, timbre: 0.125, color: 0.15, model: 14);
    var filteredSig = ~v.(sig, 5000 * env + 400) + in;
    var filteredDelayedSig = DelayN.ar(filteredSig * 0.9, 1, 1/8 * [1, 1.01]);
    filteredDelayedSig = ~v.(filteredDelayedSig, 3500, 0);
    LocalOut.ar(filteredDelayedSig);
    sig = VAKorg35.ar(filteredSig, 1000, 0.5, 1, 1);
    sig = ~v.(sig, 1000) * 4;
    Out.ar(0, sig * 0.05);
}.play;
)


(
u.free;
u = {
    var t = Impulse.kr(0.25);
    var e = EnvGen.kr(Env([0, 1, 0], [0.9, 8 - 0.1], [2, -8, 'lin']), t).lag(0.125);
    var d = Demand.kr(t, 0, Dseq([-7,-5].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq((0..15), inf));
    var a = ~lfo.(8 * e) * 8;
    var b = [0.5, 1.5];
    var i = 1 - e * 4;
    var sig = HarmonicOsc.ar(
        freq: 220 * 0.25 * [1,1.01].dup * (d+7).midiratio.lag(0.1),
        firstharmonic: [0, 4].dup + [[0,0],[3,3]] + 0,
        amplitudes: [
            b, i, e, 1, e, a, 2, e,
            1, b, a, a, i, b, 1, 2
        ]
    );

    // sig[1] = sig[1];
    // sig[0].size.poll;
    sig = [sig[0][0] + sig[0][1], sig[1][0] + sig[1][1]];
    sig = ~v.(sig, 500 * e + 100, 0.5, 1);
    // sig = MiVerb.ar(sig,);
    sig = [sig[0]+(sig[1]*0.5),sig[1]+(sig[0]*0.5)]*0.75;
    sig * 0.05 * Line.kr(0,1,0.125);
}.play;
)
