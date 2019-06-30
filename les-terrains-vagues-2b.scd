(
~shimmerD2.stop;
~shimmerD2 = Pbind(
    \instrument, \guitare,
    \dur, 1 / 16,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.19, 0.237 + 0.041, 0.2545].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.5),
    \rel, 0.1,
    \atk, 0.7,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, -5.midiratio,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 4 * 1,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
~shimmerD3.stop;
~shimmerD3 = Pbind(
    \instrument, \guitare,
    \dur, 1 / 16,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.237 + 0.041].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.5),
    \rel, 0.1,
    \atk, 0.7,
    \rate, [1] * -7.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, -12.midiratio,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 4 * 1,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)


(
~shimmerK.stop;
~shimmerK = Pbind(
    \instrument, \guitare,
    \dur, 0.5,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.525].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.6].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.665].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    // \spos, Pseq([0.66125].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 3,
    \atk, 1,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0, 7].midiratio.stutter(2), inf) * [0.5, 1],
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 20,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
~shimmerK2.stop;
~shimmerK2 = Pbind(
    \instrument, \guitare,
    \dur, 0.5,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.515].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 3,
    \atk, 1,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0, 7].midiratio.stutter(2), inf) * 1,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 7,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)

(
~shimmerK3.stop;
~shimmerK3 = Pbind(
    \instrument, \guitare,
    \dur, 0.125,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.775].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 2,
    \atk, 0.5,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0].midiratio.stutter(2), inf) * [1, 2],
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 15,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)


(
~shimmerK4.stop;
~shimmerK4 = Pbind(
    \instrument, \guitare,
    \dur, 0.125,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.7915, 0.792].stutter(8) + 0.024125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 2,
    \atk, 1,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0, -5].midiratio.stutter(32), inf) * [0.5, 1],
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 10,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)