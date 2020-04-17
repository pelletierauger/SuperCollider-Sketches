(
var n = 20;
var r = 1 / n;
var decrease = Pseries(0, r, n).asStream.nextN(n).reverse;
var increase = Pseries(0, r, n).asStream.nextN(n) * 0.75;
var amplitudes = [decrease, increase].lace(n * 2);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.25, 0.25, 0.5, 0.75, 0.25].stutter(2) * 0.5, inf) * Pseq([0, 1], inf),
    \num, Pseq(55 + ([0, 7, 4, 11, 9] ++ ([-3, 4, 2, 9, 4] + 0)).stutter(2), inf)
    + Pseq(0!(20 * 4 - 1) ++ 24, inf),
    \dyn, Pseq([0, 1].wrapExtend(n * 2) ++ ([1, 2].wrapExtend(n * 2)), inf),
    \amp, Pseq(amplitudes ++ (amplitudes * 0.75), inf) * 0.5
    * Pseq(1!(20 * 4 - 1) ++ 0.5, inf),
    \rel, 2
).play();
)

(
var n = 20;
var r = 1 / n;
var decrease = Pseries(0, r, n).asStream.nextN(n).reverse;
var increase = Pseries(0, r, n).asStream.nextN(n) * 0.75;
var amplitudes = [decrease, increase].lace(n * 2);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.25, 0.25, 0.5, 0.75, 0.25].stutter(2) * 0.35, inf) * Pseq([0, 1], inf),
    \num, Pseq(62 + ([0, 7, 4, 11, 9] ++ ([-3, 4, 2, 9, 4] + -0)).stutter(2), inf)
    + Pseq([0, -5].stutter(n * 4), inf),
    \dyn, Pseq([0, 1].wrapExtend(n * 2) ++ ([1, 2].wrapExtend(n * 2)), inf),
    \amp, Pseq(amplitudes ++ (amplitudes * 0.75), inf) * 0.5,
    \rel, 2
).play();
)


(
var n = 20;
var r = -1 / n;
var decrease = Pseries(1, r, n).asStream.nextN(n);
var increase = decrease.reverse * 0.75;
var amplitudes = [decrease, increase].lace(n * 2);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([1, 1, 2, 3, 1].stutter(2) * 0.25 * 0.35, inf)
    * Pseq([0, 1], inf),
    \num, 62
    + Pseq(([0, 7, 4, 11, 9] ++ [-3, 4, 2, 9, 4]).stutter(2), inf)
    + Pseq([0, -5].stutter(n * 4), inf),
    \dyn, Pseq([0, 1], inf) + Pseq([0, 1].stutter(n * 2), inf),
    \amp, Pseq(amplitudes ++ (amplitudes * 0.75), inf) * 0.5,
    \rel, 2
).play();
)




(
var n = 40;
var r = -1 / n;
var decrease = Pseries(1, r, n).asStream.nextN(n);
var increase = decrease.reverse * 0.75;
var amplitudes = [decrease, increase].lace(n * 2);
~crescendoRiff.stop;
~crescendoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([2, 1, 2, 3, 1].stutter(2) * 0.25 * 0.1, inf)
    * Pseq([0, 1], inf),
    \num, 72
    + Pseq(([0, 7, 4, 11, 9] ++ [-3, 4, 2, 9, 4]).stutter(2).reverse, inf)
    + Pseq([0, -5].stutter(n * 8), inf),
    \dyn, Pseq([0, 1], inf) + Pseq([0].stutter(n * 2), inf),
    \amp, Pseq(amplitudes ++ (amplitudes * 0.75), inf) * 0.5,
    \rel, 4
).play();
)