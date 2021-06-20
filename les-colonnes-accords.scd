(
    if(~colo.isPlaying, {~colo.set(\gate, 0, \fadeTime, 0.1)});
~colo = {
    |trigGate = 1|
    var ds;
    var t = Impulse.kr(~nT.beatDur.reciprocal * 0.25) * trigGate;
    var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 16], [2, -8, 'lin']), t * bl);

    var note0 = Demand.kr(t * bl, 0, Dseq([0, 0, -4], inf));
    var note1 = Demand.kr(t * bl, 0, Dseq([4, 3, 3], inf));
    var note2 = Demand.kr(t * bl, 0, Dseq([7, 0, -4] - 12, inf));
    var note3 = Demand.kr(t * bl, 0, Dseq([4, 3, 1] - 12, inf));
    var sig = MiBraids.ar(
        pitch: 50 + [note0, note1, note2, note3],
        timbre: [0.9, 0.9].stutter(2),
        color: 0.1,
        model: 4,
        resamp: 0,
        decim: 10,
        bits: 0,
        ws: 1
    ) * env;
    sig = [sig[0] + (sig[2] * 0.25), sig[1] + (sig[3] * 0.25)];
    sig = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
    // sig = sig * SinOsc.kr(6).range(0.25, 1);
    sig = (LPF.ar(MiVerb.ar(sig, 0.9, 1) * 8, 500));
 /*   ds = Decimator.ar(sig, 10000, 2) * 1;
    ds = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
    sig = sig + (ds * 4);*/
    sig * 0.25 * 2 * 4;
}.play.register;
)

~colo.set(\trigGate, 0, \gate, 0, \fadeTime, 30);


(
d.free;
d = {
    var ds;
    var t = Impulse.kr(~nT.beatDur.reciprocal * 0.25);
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
    sig * 0.25 * 8;
}.play;
)


~nT.beatDur.reciprocal
~nT.tempo