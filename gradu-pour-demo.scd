(
var n = 20;
var r = -1 / n;
var decrease = Pseries(1, r, n).asStream.nextN(n);
var increase = decrease.reverse * 0.75;
var amplitudes = [decrease, increase].lace(n * 2);
~crescendoRiff.stop;
~crescendoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([1, 1, 2, 3, 1].stutter(2) * 0.25 * 0.35, inf)
    * Pseq([0, 1], n * 8),
    \num, 62
    + Pseq(([0, 7, 4, 11, 9] ++ [-3, 4, 2, 9, 4]).stutter(2), inf)
    + Pseq([0, -5].stutter(n * 4), inf),
    \dyn, Pseq([0, 1], inf) + Pseq([0, 1].stutter(n * 2), inf),
    \amp, Pseq(amplitudes ++ (amplitudes * 0.75), inf) * 0.5,
    \rel, 6
).play();
)