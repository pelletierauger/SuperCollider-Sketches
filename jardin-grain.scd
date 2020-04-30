(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare,
    \dur, 1 / 16,
    \spos, Pseq([0.58, 0.2545].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, [0.5, 1] * 1.midiratio,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)