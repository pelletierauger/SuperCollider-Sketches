(
~muds.stop;
{
var a = [0, 2, 5, 9];
var b = [14, 10, 9, 5];
var c = [14, 12, 9, 5];
var d = [-7, -2, 5, 9];
~muds = Pbind(
    \instrument, \muddy,
    \dur, Pseq([0.25, 0.125] * 2, inf),
    \freq, ~toFreq.("Bb3") * Pseq([0, 2, 5, 9, 14, 10, 9, 5, 0, 2, 5, 9, 14, 12, 9, 5].stutter(1).midiratio, inf) * [1],
    \freq, ~toFreq.("Bb3") * Pseq((a++b++d++c).stutter(1).midiratio, inf) * [0.5],
    \atk, 0.00125,
    \rel, 1.05,
    \rel, Pseq([1, 1.5, 2.5, 4] * 1, inf),
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 2, inf),
    \startF, Pseq([Pgeom(0.1, 1.1, 48)], inf),
    \startF, Pseq(Pgeom(0.1, 1.1, 48).asStream.nextN(48).mirror, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(quant: 1);
}.();

~mudsHigh.stop;
{
var a = [0, 2, 5, 9];
var b = [14, 10, 9, 5];
var c = [14, 12, 9, 5];
var d = [-7, -2, 5, 9];
~mudsHigh = Pbind(
    \instrument, \muddy,
    \dur, Pseq([0.25, 0.125], inf),
    \freq, ~toFreq.("Bb3") * Pseq([0, 2, 5, 9, 14, 10, 9, 5, 0, 2, 5, 9, 14, 12, 9, 5].stutter(1).midiratio, inf) * [4],
    \freq, ~toFreq.("Bb3") * Pseq((a++b++d++c).stutter(2).midiratio, inf) * [2],
    \atk, 0.00125,
    \rel, 1.05,
    \rel, Pseq([1, 1.5, 2.5, 4] * 1, inf),
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 2, inf),
    \startF, Pseq([Pgeom(0.1, 1.1, 48)], inf),
    \startF, Pseq(Pgeom(0.1, 1.1, 48).asStream.nextN(48).mirror, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(quant: 1);
}.();
)

(
~mudsHigh.stop;
~muds.stop;
{
var a = [0, 2, 5, 9];
var b = [14, 10, 9, 5];
var c = [14, 12, 9, 5];
var d = [-7, -2, 5, 9];
~muds = Pbind(
    \instrument, \muddy,
    \dur, Pseq([0.25, 0.125] * 1, inf),
    \freq, ~toFreq.("Bb3") * Pseq([0, 2, 5, 9, 14, 10, 9, 5, 0, 2, 5, 9, 14, 12, 9, 5].stutter(1).midiratio, inf) * [1],
    \freq, ~toFreq.("Bb3") * Pseq((a++b++d++c).stutter(1).midiratio, inf) * [1],
    \atk, 0.00125,
    \rel, 1.05,
    \rel, Pseq([1, 1.5, 2.5, 4] * 1, inf),
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 2, inf),
    \startF, Pseq([Pgeom(0.1, 1.1, 48)], inf),
    \startF, Pseq(Pgeom(0.1, 1.1, 48).asStream.nextN(48).mirror, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(quant: 1);
}.();
)

s.record;
s.stopRecording;