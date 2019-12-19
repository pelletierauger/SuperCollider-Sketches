(
{
    var op1 = SinOsc.ar(440) * 0.1;
    op1!2;
}.play;
)



(
var a = [0] ++ (0!7);
var b = Pseries(0.1, -0.01, 12).asStream.nextN(12);
var c = Pseries(0.1, 0.015, 12).asStream.nextN(12);
var d = 0.265!8;
var e = Pseries(0.1375,0.9/24, 24).asStream.nextN(24);
var levels = a ++ b ++ c ++ d ++ e;
var freqs = (1..63);
var freq = 220 * 0.midiratio;
{
    var env = Env.circle([0.5, 1], [0.001, 0.1]).kr;
    var lfo = SinOsc.kr(4) * 2;
    var op2 = SinOsc.ar(freq * 17, lfo);
    var op1 = (SinOsc.ar(freq * freqs, (op2 * 0.5) + lfo) * levels * 0.1).sum;
    var op1b = (SinOsc.ar(freq * 1.001 * freqs, (op2 * 0.5) + lfo) * levels * 0.1).sum;
    op1 = Balance2.ar(op1, op1b, 0);
    op1 = RHPF.ar(op1 * 1, 625, rq: 4);
    // op1!2 * 0.1;
    // LPF.ar(op1 * 0.2, 8240) * env;
    op1 * 0.3;
}.play;
)

;
-7.3.dbamp


120 bmp
120 / 60
0.25