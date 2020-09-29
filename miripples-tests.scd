// basic
{ MiRipples.ar(Saw.ar(60!2), 0.4, 0.3) }.play


(
{
    var cf = LFNoise0.kr(4).range(0, 1);
    var out = MiRipples.ar(Saw.ar(60), cf, 0.6, mul: 0.5);
    out!2;
}.play
)


(   // filter sweep + distortion
{
    var cf = LFTri.kr(0.03).range(0.1,0.9);
    var lenv = EnvGen.kr(Env.circle([0, 0.9, 0, 0], [0.2, 0.1, 0.5], [8, 8]));
    var lenv2 = EnvGen.kr(Env.circle([0, 1, 0], [0.1, 0.25], [8, 8]));
    var out = MiRipples.ar(Saw.ar(110 * (36 - 24 + 12).midiratio * [1.001, 1]), 0.3 + (lenv * 0.125), lenv, 10, 0.2);
    out = out + (LPF.ar(CombL.ar(out, 0.001, decaytime: 128) * 4, 400));
    LeakDC.ar(out * 2);
}.play
)


(
{
    var trig = Impulse.ar(4);
    var input = Decay.ar(trig, 0.1);
    var cf = TRand.ar(0.1, 0.6, trig);
    var filt = RLPF.ar(cf, 80, 0.3);
    var out = MiRipples.ar(input, filt, 0.8, drive: 3, mul: 0.5);
    out!2;
}.play
)