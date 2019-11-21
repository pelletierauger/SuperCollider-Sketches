(
{
    var s = -12.midiratio;
    var lfo = SinOsc.kr(0.1).range(4, 10);
    var mod = SinOsc.ar(440 * 1 * s) * 200 * SinOsc.kr(1).range(0.25, 1);
    SinOsc.ar(((440!2) * s) + mod) * 0.1 * SinOsc.ar([110, 111] * s * 0.25).range(lfo, 1);
}.play;
)

(
{
    var s = -12.midiratio;
    var lfo = SinOsc.kr(0.1).range(4, 10);
    SinOsc.ar((440!2) * s) * 0.1;
}.play;
)