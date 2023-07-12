// sainte agathe
(
x.free;
x = {
    var t0 = Impulse.kr(b.duration.reciprocal/3);
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*4);
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.001], ['lin', -2]), gate: t)*(e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori;
    var mel = Demand.kr(t, 0, Dseq([2, 3, 2, 0].stutter(3*4), inf));
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/128), lev1: 0.25*e, lev2: 0.5*e,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 8;
    sig = sig + DelayN.ar(
        MiBraids.ar(~toMidi.("E5") +mel, timbre: 0.5, color: 0.5, model: 4)*e.pow(5), 12, b.duration/2);
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5, lev2: 0.5,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;

    // sig;
}.play(fadeTime: 0);
)



// sainte agathe
(
x.free;
x = {
    var t0 = Impulse.kr(b.duration.reciprocal/3);
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*4);
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.001], ['lin', -2]), gate: t)*(e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori;
    var mel = Demand.kr(t, 0, Dseq([2, 3, 2, 0].stutter(3*4), inf));
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/128), lev1: 0.25*e, lev2: 0.5*e,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 8;
    sig = sig + DelayN.ar(
        MiBraids.ar(~toMidi.("E4") +mel, timbre: 0.5, color: 0.5, model: 4)*e.pow(5), 12, b.duration/2);
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.85,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;

    // sig;
}.play(fadeTime: 0);
)



// sainte agathe
(
x.free;
x = {
    var t0 = Impulse.kr(b.duration.reciprocal/3);
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*4);
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.001], ['lin', -2]), gate: t)*(e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori;
    var mel = Demand.kr(t, 0, Dseq([2, 3, 2, 5].stutter(3*4), inf));
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/128), lev1: 0.25*e, lev2: 0.5*e,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 8;
    sig = sig + DelayN.ar(
        MiBraids.ar(~toMidi.("E4") +mel, timbre: 0.5, color: 0.5, model: 4)*e.pow(5)*1.5, 12, b.duration/2);
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.25, lev2: 0.25,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 8;
    sig = ~v.(sig, 500, 0, 5);
    // sig;
}.play(fadeTime: 0);
)