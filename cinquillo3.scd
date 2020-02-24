(
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([1, 0.5, 1, 0.5, 1] * 0.5, inf),
    \num, 52 + Pseq([19, 12, 19, 12, 19], inf) + Pseq([0, -2].stutter(10), inf),
    \dyn, Pseq([1, 0, 1, 0, 1], inf),
    \amp, Pseq([0.5, 1, 1, 1, 1], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 1
).play(t, quant: [4]);
~pianoRiff2.stop;
~pianoRiffb.stop;
~pianoRiffb = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([1, 0.5, 1, 0.5, 1] * 0.5, inf),
    \num, 52 - 12 - 5 + Pseq([19, 12, 19, 12, 19], inf) + Pseq([0, 5].stutter(10), inf),
    \dyn, Pseq([1, 0, 1, 0, 1], inf),
    \amp, Pseq([0.5, 1, 0.5, 1, 0.5], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 1
).play(t, quant: [2, 0.75 - (0.0625 * 0.5)]);
~pianoRiff2.stop;
~pianoRiff2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.0625, 1 - 0.0625, 0.0625, 1 - 0.0625 - 0], inf),
    \num, Pseq(52 + 24 + [-8, -1, -5, -8, -8, -1, -5, -8].stutter(1), inf) + Pseq([5, 10].stutter(4), inf),
    \dyn, Pseq([1, 0, 0, 0, 0], inf),
    \amp, Pseq([0.5, 2, 2, 2, 2] * 2, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 2
).play(t, quant: [4, -0.0625 + 0.75]);
)
~pianoRiff.mute;
~pianoRiff.unmute;
~pianoRiffb.mute;
~pianoRiffb.unmute;

t.tempo = 75/60

(
~pianoRiff.stop;
~pianoRiffb.stop;
~pianoRiff2.stop;
)