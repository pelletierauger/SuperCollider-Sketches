
f = Pseries(1, 1, 32).asStream.nextN(32);
a = Pseries(1, -1/32, 32).asStream.nextN(32) + rrand(0.0, 1.0) % 1;
(
{
        var t = Impulse.kr(4);
    var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [-8, -8, 'lin']), t * bl).lag(0.01);
    var dem = Demand.kr(t * bl, 0, Dseq([0, 2, 3].midiratio, inf));
    var baseFreq = 220 * dem;
    var opN = 32;
    var freqs = f;
    var amps = a;
    var op1 = SinOsc.ar(baseFreq * 16);
    var sig = SinOsc.ar(baseFreq * freqs, op1 * 2 * dem.pow(3) % 2pi, mul: amps * [1, 0].wrapExtend(32)).sum;
    var op0 = SinOsc.ar(baseFreq * [1, 1.01], sig * env * 2 % 2pi) * 0.1;
    op0 = LPF.ar(op0, 100 + (env * 2000));
    op0 * 0.4 * env;
}.play;
)


[1, 5].sum

rrand(0.0, 1.0);

1.5 % 1
1.5.pow(1.5)