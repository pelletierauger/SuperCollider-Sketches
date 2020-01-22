(
~ba2.stop;
~ba2 = Pbind(
    \type, \playPiano,
    \dur, Pseq([0.25], inf),
    \num, 440.cpsmidi + Pseq([0, 3, -2, -5, 10].stutter(2).mirror2, inf) + Pseq([0, 12], inf) + Pseq([0, -5].stutter(16), inf),
    \amp, Pseq([1, 0.5, 0.75, 0.5, 0.25] * 0.1, inf),
    \dyn, Pseq(1!4 ++ [2], inf)
).play(t, quant: [4, 0.25]);
)

(
~ba3.stop;
~ba3 = Pbind(
    \type, \playPiano,
    \dur, Pseq([0.5], inf),
    \num, 220.cpsmidi + Pseq([0, 3, -2, -5, 10].stutter(1).mirror2, inf) + Pseq([0, 12], inf) + Pseq([0, -5].stutter(16), inf),
    \amp, Pseq([1, 0.5, 0.75, 0.5, 0.25] * 0.2, inf),
    \dyn, Pseq(1!4 ++ [2], inf)
).play(t, quant: [4, 0.25]);
)