(
~eq8 = {
  | sig, f0 = 1, f1 = 1, f2 = 1, f3 = 1, f4 = 1, f5 = 1, f6 = 1, f7 = 1 |
    var amps = [f0, f1, f2, f3, f4, f5, f6, f7];
    var midFreqs = [64, 128, 256, 1000, 2000, 4000];
    var output = ~v.(sig, midFreqs[0], 0, 0) * amps[0];
    output = output + midFreqs.collect({|item, index| ~v.(sig, item, 0, 3) * amps[index]}).sum;
    output = output + ~v.(sig * amps[7], 8000, 0, 5);
    output;
};
)

(
    var midFreqs = [64, 128, 256, 1000, 2000, 4000];
// var output = ~v.(sig, f0);
    midFreqs.collect({|i| i.postln});
)



(
x.free;
x = {
    var t0 = Impulse.kr(b.duration.reciprocal/3);
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*16);
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*0.125*0.5], ['lin', -2]), gate: t)*(1-e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori;
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/32), lev1: 0.85, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 1;
/*    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1 * e0, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);
    sig * 0.5 + ori;
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
        MiBraids.ar(~toMidi.("E5") +mel, timbre: 0.5, color: 0.5, model: 4)*e.pow(5), 12, b.duration/2);
/*    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1 * e0, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);
    sig * 0.5 + ori;
    // sig;
}.play(fadeTime: 0);
)




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
        MiBraids.ar(~toMidi.("E6") +mel, timbre: 0.75, color: 0.125, model: 4)*e.pow(5), 12, b.duration/2);
/*    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1 * e0, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);
    sig * 0.5 + ori;
    // sig;
}.play(fadeTime: 0);
)



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
        MiBraids.ar(~toMidi.("E6") +mel, timbre: 0.25, color: 0.125, model: 4)*e.pow(5), 12, b.duration/2);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5, lev2: 0.5*e,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
/*    sig = sig +
    (MiBraids.ar(~toMidi.("E1") +[2,3], timbre: 0.85*e, color: 0.25, model: 4,
        resamp: 2, decim: 22, bits: 2)
    *0.1);*/

/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/12*0), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);

    // sig;
}.play(fadeTime: 0);
)


(
~droo3.free;
~droo3 = {
    var x = 0.479251; // MouseX.kr(0, 1);
    var y = 0.861758; // MouseY.kr(0, 1);
    var lfo = SinOsc.kr(0.1);
    var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);
    var sig = MiPlaits.ar(
        ~toMidi.("C1") + 8 + 24 + 2 + [0, 0.01 * lfo] + xx,
        engine: 0,
        harm: x, timbre: 1 - y, morph: y
    );
    sig = [sig[0][1], sig[1][1]];
    // y.poll;
    sig = VadimFilter.ar(
        sig,
        1000 * lfo.unipolar + 100,
        0.25,
        1
    ) * 0.2 * Line.kr(0,1,15);
}.play;
)

(
~droo4.free;
~droo4 = {
    var x = 0.479251; // MouseX.kr(0, 1);
    var y = 0.861758; // MouseY.kr(0, 1);
    var lfo = SinOsc.kr(0.1);
    var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);
    var sig = MiPlaits.ar(
        ~toMidi.("C1") + 8 + 24 + 2 + 14 + [0, 0.01 * lfo] + xx,
        engine: 0,
        harm: x, timbre: 1 - y, morph: y
    );
    sig = [sig[0][1], sig[1][1]];
    // y.poll;
    sig = VadimFilter.ar(
        sig,
        1000 * lfo.unipolar + 100,
        0.25,
        1
    ) * 0.2 * Line.kr(0,1,15);
}.play;
)


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
        MiBraids.ar(~toMidi.("E6") +mel, timbre: 0.25, color: 0.125, model: 4)*0.5*e.pow(5), 12, b.duration/2);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/64), lev1: 0.5, lev2: 0.5,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
/*    sig = sig +
    (MiBraids.ar(~toMidi.("E1") +[2,3], timbre: 0.85*e, color: 0.25, model: 4,
        resamp: 2, decim: 22, bits: 2)
    *0.1);*/

/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/12*0), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);

    // sig;
}.play(fadeTime: 0);
)


