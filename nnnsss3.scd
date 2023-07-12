d = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dirt-Samples-master/gretsch/020_snare.wav")
d.play;
(
x.free;
x = {
    var t0 = Impulse.kr(b.duration.reciprocal/3);
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*4);
    var t4 = Impulse.kr(b.duration.reciprocal*8/3);
    var t5 = Impulse.kr(b.duration.reciprocal*4/3);
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.001], ['lin', -2]), gate: t)*(e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori, drums;
    var mel = Demand.kr(t, 0, Dseq([2, 3, 2, 5].stutter(3*4), inf));
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    // sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/128), lev1: 0.25*e, lev2: 0.5*e,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 8;
    sig = sig + DelayN.ar(
        MiBraids.ar(~toMidi.("E6") +mel, timbre: 0.25, color: 0.125, model: 4)*0.5*e.pow(5), 12, b.duration/2);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/64), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:3, freq: ~toFreq.("E0"), easteregg:1) * 1;
/*    sig = sig +
    (MiBraids.ar(~toMidi.("E1") +[2,3], timbre: 0.85*e, color: 0.25, model: 4,
        resamp: 2, decim: 22, bits: 2)
    *0.1);*/
    sig = ~v.(sig, 9000);


        drums = (PlayBuf.ar(2, ~hits[22], rate: 1, trigger: t4, loop: 0)*0.75);
    // drums = drums + (PlayBuf.ar(2, ~kicks[5], rate: 1, trigger: t5, loop: 0)*0.35);
    drums = drums + (PlayBuf.ar(2, ~hats[13], rate: 2, trigger: t, loop: 0)*0.5);
        drums = MiWarps.ar(
        drums, DelayN.ar(drums, 1, b.duration/64), lev1: 0.65, lev2: 0.5,
        algo:2, timb: 1, osc:0, freq: ~toFreq.("E4"), easteregg:0) * 2;

    sig * 0.5 + (drums*0.5);
/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/12*0), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);

    // sig;
}.play(fadeTime: 0.02);
)



(
x.free;
x = {
    var t0 = Impulse.kr(b.duration.reciprocal/3);
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*4);
    var t4 = Impulse.kr(b.duration.reciprocal*8/3);
    var t5 = Impulse.kr(b.duration.reciprocal*4/3);
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.001], ['lin', -2]), gate: t)*(e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori, drums;
    var mel = Demand.kr(t, 0, Dseq([2, 3, 2, 5].stutter(3*4), inf));
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    // sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/128), lev1: 0.25*e, lev2: 0.5*e,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 8;
    sig = sig + DelayN.ar(
        MiBraids.ar(~toMidi.("E6") +mel, timbre: 0.25, color: 0.125, model: 4)*0.5*e.pow(5), 12, b.duration/2);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/64), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:3, freq: ~toFreq.("E0"), easteregg:1) * 1;
/*    sig = sig +
    (MiBraids.ar(~toMidi.("E1") +[2,3], timbre: 0.85*e, color: 0.25, model: 4,
        resamp: 2, decim: 22, bits: 2)
    *0.1);*/
    sig = ~v.(sig, 9000);


        drums = (PlayBuf.ar(2, ~hits[22], rate: 1, trigger: t4, loop: 0)*0.75);
    drums = drums + (PlayBuf.ar(2, ~kicks[21], rate: 1, trigger: t5, loop: 0)*0.35);
    drums = drums + (PlayBuf.ar(2, ~hats[13], rate: 2, trigger: t, loop: 0)*0.5);
        drums = MiWarps.ar(
        drums, DelayN.ar(drums, 1, b.duration/4*1.5+0.01), lev1: 0.25, lev2: 0.25,
        algo:5, timb: 1, osc:1, freq: ~toFreq.("E3"), easteregg:1) * 1 + (drums*0);

    sig * 1 + (drums*0.5);
/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/12*0), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);

    // sig;
}.play(fadeTime: 0.02);
)


(
x.free;
x = {
    var t0 = Impulse.kr(b.duration.reciprocal/3);
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*4);
    var t4 = Impulse.kr(b.duration.reciprocal*8/3);
    var t5 = Impulse.kr(b.duration.reciprocal*4/3);
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.001], ['lin', -2]), gate: t)*(e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori, drums;
    var mel = Demand.kr(t, 0, Dseq([2, 3, 2, 5].stutter(3*4), inf));
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    // sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/128), lev1: 0.25*e, lev2: 0.5*e,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 8;
    sig = sig + DelayN.ar(
        MiBraids.ar(~toMidi.("E6") +mel, timbre: 0.25, color: 0.125, model: 4)*0.5*e.pow(5), 12, b.duration/2);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/64), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:3, freq: ~toFreq.("E0"), easteregg:1) * 1;
/*    sig = sig +
    (MiBraids.ar(~toMidi.("E1") +[2,3], timbre: 0.85*e, color: 0.25, model: 4,
        resamp: 2, decim: 22, bits: 2)
    *0.1);*/
    sig = ~v.(sig, 9000);


        drums = (PlayBuf.ar(2, ~kicks[27], rate: 1, trigger: t4, loop: 0)*0.75);
    drums = drums + (PlayBuf.ar(2, ~hits[27], rate: 1, trigger: t5, loop: 0)*0.35);
    drums = drums + (PlayBuf.ar(2, ~hats[13], rate: 2, trigger: t, loop: 0)*0.5);
        drums = MiWarps.ar(
        drums, DelayN.ar(drums, 1, b.duration/4*1.5+0.01), lev1: 0.25, lev2: 0.25,
        algo:5, timb: 1, osc:1, freq: ~toFreq.("E3"), easteregg:1) * 1 + (drums*0);


    sig * 1 + (drums*0.5);
/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/12*0), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);

    // sig;
}.play(fadeTime: 0.02);
)


(
x.free;
x = {
    var t0 = Impulse.kr(b.duration.reciprocal/3);
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*4);
    var t4 = Impulse.kr(b.duration.reciprocal*8/3);
    var t5 = Impulse.kr(b.duration.reciprocal*4/3);
    // var d5 = Demand.kr(t5, 0, Drand([1,128], inf));
    var d5 = t * Demand.kr(t, 0, Dseq([0, 0, 1, 0], inf));
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.001], ['lin', -2]), gate: t)*(e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori, drums;
    var mel = Demand.kr(t, 0, Dseq([2, 3, 2, 5].stutter(3*4), inf));
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    // sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/128), lev1: 0.25*e, lev2: 0.5*e,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 8;
    sig = sig + DelayN.ar(
        MiBraids.ar(~toMidi.("E6") +mel, timbre: 0.25, color: 0.125, model: 4)*0.5*e.pow(5), 12, b.duration/2);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/64), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:3, freq: ~toFreq.("E0"), easteregg:1) * 1;
/*    sig = sig +
    (MiBraids.ar(~toMidi.("E1") +[2,3], timbre: 0.85*e, color: 0.25, model: 4,
        resamp: 2, decim: 22, bits: 2)
    *0.1);*/
    sig = ~v.(sig, 9000);


        drums = (PlayBuf.ar(2, ~kicks[27], rate: 1, trigger: t4, loop: 0)*0.75);
        drums = drums+ (PlayBuf.ar(2, ~snares[37], rate: 1, trigger: d5, loop: 0)*0.75);
    drums = drums + (PlayBuf.ar(2, ~hits[27], rate: 1, trigger: t5, loop: 0)*0.35);
    drums = drums + (PlayBuf.ar(2, ~hats[13], rate: 2, trigger: t, loop: 0)*0.5);
        drums = MiWarps.ar(
        drums, DelayN.ar(drums, 1, b.duration/4*1.5+0.01/128), lev1: 0.25, lev2: 0.25,
        algo:5, timb: 1, osc:1, freq: ~toFreq.("E3"), easteregg:1) * 1 + (drums*0);


    sig * 1 + (drums*0.5);
/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/12*0), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);

    // sig;
}.play(fadeTime: 0.02);
)

x.set(\trigGate, 0)
(
x.free;
x = {
    |trigGate = 1|
    var t0 = Impulse.kr(b.duration.reciprocal/3) * trigGate;
    var e0 = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.1*6], ['lin', -2]), gate: t0);
    var t = Impulse.kr(b.duration.reciprocal*4) * trigGate;
    var t4 = Impulse.kr(b.duration.reciprocal*8/3) * trigGate;
    var t5 = Impulse.kr(b.duration.reciprocal*4/3) * trigGate;
    var se = EnvGen.kr(Env([0,0,1], [b.duration/2, 0,001]));
    // var d5 = Demand.kr(t5, 0, Drand([1,128], inf));
    var d5 = t * Demand.kr(t, 0, Dseq([0, 0, 1, 0], inf));
    var e = EnvGen.kr(Env([0,1,0], [0.001, b.duration-0.001], ['lin', -2]), gate: t)*(e0);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]);
    var ori, drums;
    var mel = Demand.kr(t, 0, Dseq([2, 3, 2, 5].stutter(3*4), inf));
    sig = sig[0] * 1 + DelayN.ar(sig[1], 12, b.duration/2*3);
    // sig = sig + (CombC.ar(sig, 1, b.duration/32*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/128), lev1: 0.25*e, lev2: 0.5*e,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 8;
    sig = sig + DelayN.ar(
        MiBraids.ar(~toMidi.("E6") +mel, timbre: 0.25, color: 0.125, model: 4)*0.5*e.pow(5), 12, b.duration/2);
    sig = sig * 0.5 + ori;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/64), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:3, freq: ~toFreq.("E0"), easteregg:1) * 1;
/*    sig = sig +
    (MiBraids.ar(~toMidi.("E1") +[2,3], timbre: 0.85*e, color: 0.25, model: 4,
        resamp: 2, decim: 22, bits: 2)
    *0.1);*/
    sig = ~v.(sig, 9000);


        drums = (PlayBuf.ar(2, ~kicks[27], rate: 1, trigger: t4, loop: 0)*0.75);
        drums = drums+ (PlayBuf.ar(2, ~snares[37], rate: 1, trigger: d5, loop: 0)*0.75*se);
       drums = drums+ (PlayBuf.ar(2, d, rate: 1, trigger: d5, loop: 0)*2*se);
    drums = drums + (PlayBuf.ar(2, ~hits[27], rate: 1, trigger: t5, loop: 0)*0.35);
    drums = drums + (PlayBuf.ar(2, ~hats[13], rate: 2, trigger: t, loop: 0)*0.5);
        drums = MiWarps.ar(
        drums, DelayN.ar(drums, 1, b.duration/4*1.5+0.01/128*0), lev1: 0.25, lev2: 0.25,
        algo:3, timb: 1, osc:0, freq: ~toFreq.("E3"), easteregg:0) * 8 + (drums*1);


    sig * 1 + (drums*0.25);
/*        sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/12*0), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    // ori = ~eq8.(ori, 0.5, 0.5, 2, 1, 4, 1, 1, 8);

    // sig;
}.play(fadeTime: 0.02);
)