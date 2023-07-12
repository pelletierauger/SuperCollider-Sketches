"/Users/guillaumepelletier/Desktop/unenote(1).wav"

b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/unenote(1).wav");
b.play;


c = Buffer.read(s, "/Users/guillaumepelletier/Desktop/unenoteb(1).wav");
c.play;

(
x.free;
x = {
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,-1], loop: 1)*[0.5,5]).sum;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.085 + ~lfo.(0.1,0,1),
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig;
}.play;
)


(
x.free;
x = {
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,-1], loop: 1)*[0.5,5]).sum;
    var ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/4*1.5), lev1: 0.85, lev2: 1.85,
        algo: 3, timb: 1, osc:2, freq: ~toFreq.("E6"), easteregg:1) * 0.1;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 1.85,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig * 0.25 + ~v.(ori*0.5,9000);
}.play;
)


(
x.free;
x = {
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]).sum;
    var ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/4*1.5), lev1: 0.85, lev2: 1.85,
        algo: 3, timb: 1, osc:2, freq: ~toFreq.("E6"), easteregg:1) * 0.1;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 1.85,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig * 0.25 + ~v.(ori*0.5,9000);
}.play;
)


(
x.free;
x = {
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]).sum;
    var ori = sig;
    sig = sig + CombC.ar(sig, 1, b.duration/16, b.duration*8);
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/4*1.5), lev1: 0.85, lev2: 1.85,
        algo: 3, timb: 1, osc:2, freq: ~toFreq.("E6"), easteregg:1) * 0.1;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 1.85,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig * 0.25 + ~v.(ori*0.5,9000);
}.play;
)


(
x.free;
x = {
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]).sum;
    var ori = sig;
    sig = sig + CombC.ar(sig, 1, b.duration/16*[1,1.5], b.duration*2);
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/4*1.5), lev1: 0.85, lev2: 1.85,
        algo: 3, timb: 1, osc:2, freq: ~toFreq.("E6"), easteregg:1) * 0.1;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 1.85,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig * 0.25 + ~v.(ori*0.5,9000);
}.play;
)

(
x.free;
x = {
    var t = Impulse.kr(b.duration.reciprocal);
    var e = EnvGen.kr(Env([0,1,0], [0.1, b.duration-0.1], ['lin', -2]), gate: t);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]).sum;
    var ori = sig;
    sig = sig + CombC.ar(sig, 1, b.duration/16*[1,1.5], b.duration*2);
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/4*1), lev1: 0.75*e, lev2: 0.5*e,
        algo: 8, timb: e, osc:2, freq: ~toFreq.("E3"), easteregg:1) * 0.1;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 1.85,
        algo: 5, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig * 0.25 + ~v.(ori*0.5*1,9000);
}.play;
)


(
x.free;
x = {
    var t = Impulse.kr(b.duration.reciprocal*4);
    var e = EnvGen.kr(Env([0,1,0], [0.1, b.duration-0.1], ['lin', -2]), gate: t);
    var sig = (PlayBuf.ar(2, [b,c], rate: [1,1], loop: 1)*[0.5,5]).sum;
    var ori = sig;
    sig = sig + CombC.ar(sig, 1, b.duration/16*[1,1.5], b.duration*2);
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration*0), lev1: 0.75*e, lev2: 0.5*e,
        algo: 4, timb: e, osc:0, freq: ~toFreq.("E3"), easteregg:0) * 0.1;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 1.85,
        algo: 5, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig * 0.25 + DelayN.ar(~v.(ori*0.5*0.25,9000), 1, b.duration/4);
}.play;
)



// ----

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
    ori = sig;
/*    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/4*1.5), lev1: 0.85, lev2: 1.85,
        algo: 3, timb: 1, osc:2, freq: ~toFreq.("E6"), easteregg:1) * 0.1;*/
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5*e, lev2: 0.5 + (e*0.5),
        algo: 4, timb: 1*e, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    sig * 1 + ori;
    // sig;
}.play(fadeTime: 0);
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
    sig = sig + (CombC.ar(sig, 1, b.duration/16*[1,1.5], b.duration*4)*0.2 );
    ori = sig;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, b.duration/32), lev1: 0.85, lev2: 0.5,
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E6"), easteregg:0) * 1;
/*    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1 * e0, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    ~v.(sig*2,1000,0,5) * 1 + ~v.(ori,9000);
    // sig;
}.play(fadeTime: 0);
)


(
x.free;
x = {
    var sig = (PlayBuf.ar(2, b, rate: 1, loop: 1));
/*    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.085 + ~lfo.(0.1,0,1),
        algo: 3, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    sig;
}.play;
)