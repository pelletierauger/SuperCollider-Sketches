(
d.free;
d = {
    var ds;
    var t = Impulse.kr(0.35);
    var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 16], [2, -8, 'lin']), t * bl);

    var note0 = Demand.kr(t * bl, 0, Dseq([0, 0, -4], inf));
    var note1 = Demand.kr(t * bl, 0, Dseq([5, 3, 3], inf));
    var sig = MiBraids.ar(
        pitch: 50 + [note0, note1],
        timbre: 0.9,
        color: 0.1,
        model: 4,
        resamp: 0,
        decim: 10,
        bits: 0,
        ws: 1
    ) * env;
    sig = sig + (MiBraids.ar(
        pitch: 50 + [note0, note1] - 12,
        timbre: 0.7,
        color: 0.1,
        model: 4,
        resamp: 0,
        decim: 10,
        bits: 0,
        ws: 1
    ) * env * 0.25);
    sig = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
    // sig = sig * SinOsc.kr(6).range(0.25, 1);
    sig = (LPF.ar(MiVerb.ar(sig, 0.9, 1) * 8, 500));
 /*   ds = Decimator.ar(sig, 10000, 2) * 1;
    ds = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
    sig = sig + (ds * 4);*/
    sig * 0.25 * 2;
}.play;
)

(
e.free;
e = {
    var ds;
    var t = Impulse.kr(0.35);
    var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
            var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));

    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t * bl);

    var note2 = Demand.kr(t * bl, 0, Dseq([-2, 0, -4], inf));
    var sig = MiBraids.ar(
        pitch: 60 - 5 - 12 - 7 + note2 + [0, SinOsc.kr(1).range(-0.01, 0.01)],
        timbre: 0.9,
        color: 0.1,
        model: 43,
        // trig: t,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig = LPF.ar(sig, 40 + (SinOsc.kr(0.2).unipolar * 1400));
    ds = Decimator.ar(sig, 10000, 2) * 1;
    ds = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
    // sig = sig + (ds * 2);
    // sig = sig + (MiVerb.ar(sig) * 12);
    sig * 0.25 * 2;
}.play;
)


(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
q.free;
q = {
    var trig = Impulse.ar(4);
    var sig = MiPlaits.ar(31 + 28 + -1 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 1,
        mul: 1.25);
        HPF.ar(sig, 5000) * 0.2;
        // sig;
    }.play;
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});

)

(
t.free;
t =
    {
    var trig = Impulse.ar(4);
    var sig = MiPlaits.ar(28 + 24 + 5 + -2 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 1,
        mul: 1.25);
        HPF.ar(sig, 5000) * 0.2;
        // sig;
    }.play;
)
