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
    + Pseq([0, -5].stutter(n * 8), inf)
    + Pseq(
        ((0!(n * 1 - 1) ++ (19!1)) ++ (0!(n * 1 - 1) ++ (21!1))).stutter(2).wrapExtend(n * 8) ++
        ((0!(n * 1 - 1) ++ (28!1)) ++ (0!(n * 1 - 1) ++ (26!1))).stutter(2).wrapExtend(n * 8)
    , inf),
/*    - Pseq(
        ([36 - 5] ++ (0!(n * 2 - 1))).stutter(2).wrapExtend(n * 4) ++
        ([36 - 3] ++ (0!(n * 2 - 1))).stutter(2).wrapExtend(n * 4) ++
        ([36 - 0] ++ (0!(n * 2 - 1))).stutter(2).wrapExtend(n * 4) ++
        ([36 + 4] ++ (0!(n * 2 - 1))).stutter(2).wrapExtend(n * 4)*/
        // , inf),
    \dyn, Pseq([0, 1], inf) + Pseq([0].stutter(n * 2), inf),
    // + Pseq((0!(n * 2 - 1) ++ (0!1)).stutter(2), inf),
    // + Pseq(([1] ++ (0!(n * 2 - 1))).stutter(2), inf),
    \amp, Pseq(amplitudes ++ (amplitudes * 0.75), inf) * 0.5,
    // * Pseq(1!(n * 2 - 1) ++ (2!1), inf),
    \rel, 4 * Pseq((1!(n * 2 - 1) ++ (2!1)).stutter(2), inf)
).play();
)