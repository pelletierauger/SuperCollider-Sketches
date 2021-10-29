(
var dur = 14;
{
    var t = Impulse.kr(0.25);
    var d0 = Demand.kr(t, 0, Dseq([0.9, 0.4, 0.4, 0.4], inf));
    var d = Demand.kr(t, 0, Dseq([0, 2, -2, -5], inf)).lag(d0);
    var e = EnvGen.kr(Env([0, 0.7, 0], [0.9, 0.9 * 4], [-8, -8]), t);
    var freq = 110!2 * -5.midiratio * (d.midiratio);
    var op3 = BlitB3Tri.ar(freq * 0.5, leak: SinOsc.ar(0.4, pi).range(0.1, 0.99), leak2: 0.99);
    var op2 = BlitB3Tri.ar(freq, leak: SinOsc.ar(3.5, 2pi).range(0.1, 0.7) * (e * 0.5 + 0.5), leak2: 0.99);
    var op1 = BlitB3Tri.ar(freq, leak: 0.99, leak2: 0.99);
    var sig = LFTri.ar(freq) * 12;
    sig = op2 * 1.5;
    // sig = sig * op31
    // sig = LFTri.ar(110!2);
    sig = VadimFilter.ar(sig, 1200 + (3000 * e), 0, 1);
// sig = op2 * sig;
    sig * 2;
}.play;
)