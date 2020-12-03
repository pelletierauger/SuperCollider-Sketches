{SinOsc.ar(440!2,0,0.1).distort}.play
{SinOsc.ar(440!2,0,0.1)}.play
o = {(SinOsc.ar(110!2 * -5.midiratio * [1, 1.001], 0) * 900).clip(-0.2, 0.3) * 0.1}.play;
o.free;
(
o = {
    var f = 440!2 * -5.midiratio;
    var mod = SinOsc.ar(f) * Line.kr(1, 4, 8) * SinOsc.ar(3).range(0.75, 1);
    SinOsc.ar(f!2 * [1, 1.001], mod * 8 % 2pi) * XLine.kr(1.00, 0.001, 8, doneAction: 2) * 0.025;
}.play(fadeTime: 0.01);
)