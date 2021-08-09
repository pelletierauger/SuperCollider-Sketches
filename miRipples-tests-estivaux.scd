// basic
{ MiRipples.ar(Saw.ar(60), 0.4, 0.3)!2 }.play


(
{
    var t = Impulse.ar(1);
    var d = Demand.ar(t, 0, Dseq([0, 5, 3, -2].midiratio, inf)).lag(0.1);
    var env = EnvGen.ar(Env([0, 1, 0], [0.025, 0.5], [2, 'lin', 'lin']), t);
    var env2 = EnvGen.ar(Env([0, 1, 0], [0.025, 2], [2, 'lin', 'lin']), t);
    var s = MiBraids.ar((60.cpsmidi * d).poll, timbre: env, color: 0, model: 0);
    MiRipples.ar(s * env2, 0.4, env * 0.7, reson: 0.5, drive: 5)!2;

}.play;
)

(
x.free;
x = {
    var t = Impulse.kr(2);
    var d = Demand.kr(t, 0, 34 + 12 + Dseq([0, -2, -5, -9].stutter(2), inf)).lag(0.1);
    var dr = Demand.kr(t, 0, Dseq([1, 0] * 0.5, inf)).lag(1);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 0.5], [2, 'lin', 'lin']), t);
    var env2 = EnvGen.kr(Env([0, 1, 0], [0.025, 2], [2, 'lin', 'lin']), t);
    var s = MiBraids.ar(d, timbre: env, color: dr, model: 0);
    MiRipples.ar(s * env2, 0.4, env * 0.7, reson: 0.5, drive: dr * 5)!2;

}.play;
)


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
    var out = MiRipples.ar(Saw.ar(40), cf, 0.8, 4, 0.2);
    out!2;
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