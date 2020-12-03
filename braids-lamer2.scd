(
x.free;
x = {
    var trig = Impulse.kr(0.25);
    var notes = Demand.kr(trig, 0,
        Dseq(32 - [0, 0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.75], inf));
    var lfo = SinOsc.kr(0.5).range(0.125, 0.75);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 4]), gate: trig);
    var model = 22;
    var freeze = Line.kr(0, 1, 2).round;
    var sig = MiBraids.ar(
        pitch: notes * [1, 1.001],
        timbre: 0.1 + (env * dem2),
        color: env * 0.25,
        model: model,
        resamp: 1);
    sig = sig + (MiBraids.ar(
        pitch: notes + 12 * [1, 1.001],
        timbre: 0.1 + (env * dem2),
        color: env * 0.25,
        model: model,
        resamp: 1));
    sig = LPF.ar(sig, 1500);
    sig = sig * 0.75 * env * 0.125;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    sig * 0.75 * 2;
    // MiVerb.ar(sig, time: 0.7, drywet: 0.5, diff: 0.7, damp: 0, freeze: freeze) * 1 * XLine.kr(0.001, 1, 0.5) * 1.5;
}.play;
)

s.record;
s.stopRecording;

(
x.free;
x = {
    var trig = Impulse.kr(0.125);
    var notes = Demand.kr(trig, 0,
        Dseq(32 - [0, 5] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig, 0, Dseq([0, 0.25], inf));
    var lfo = SinOsc.kr(0.5).range(0.125, 0.75);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 4]), gate: trig);
    var sig = MiBraids.ar(
        pitch: notes * [1, 1.001],
        timbre: 0.1 + (env * dem2),
        color: env * 0.25,
        model: 3,
        resamp: 1);
    sig = sig + (MiBraids.ar(
        pitch: notes + 12 * [1, 1.001],
        timbre: 0.1 + (env * 0),
        color: env * 0.25,
        model: 3,
        resamp: 1));
    sig = LPF.ar(sig, 500);
    sig = sig * 0.75 * env * 0.5;
    // sig = sig + (LPF.ar(sig, 200) * 16);
    MiVerb.ar(sig, time: 0.7, amount: 0.125, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)