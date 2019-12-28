(
// G, B, D, F#
// G, A, E, F#
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, 1 / 16 * 1,
    \spos, Pseq([0.45], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq(~mr17.([3, 10, 15]), inf) * 2,
    \amp, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t2);
)


(
~mr19 = {
    |n|
    pow(pow(2, 1/19), n);
};
)
(
~mr17 = {
    |n|
    pow(pow(2, 1/17), n);
};
)

9.pow()


~mr19.([2, 3])


~mr19.([0, 4, 7])