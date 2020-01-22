(
~pizStick.stop;
~pizStick = Pbind(
    \instrument, \pizzicato_haut,
    // \dur, Pseq([3, 3, 2] ++ [Rest(2), 3, 3] * 0.25, inf),
    \dur, Pseq([2, 3, 3] * 0.25, inf),
    \freq, 880 * -2.midiratio *
    Pseq([12].stutter(1), inf).midiratio,
    \amp, 1,
    \mult, 0.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
)

(
~pizHat.stop;
~pizHat = Pbind(
    \instrument, \pizzicato_haut,
    \dur, Pseq([0.5] * 0.5, inf),
    \freq, 880 * -2.midiratio *
    Pseq([19].stutter(1), inf).midiratio,
    \amp, Pseq([2.25, 1.125, 1.5, 1.125], inf) * Pseq([1, 0.5], inf) * 0.25,
    \mult, 0.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
)

(
~chords.stop;
~chords = Pbind(
    \instrument, Pseq([\sine, \sineFlip], inf),
    \dur, Pseq([0.1, 0.1, 0.1, 2 - 0.3], inf),
    \freq, ~toFreq.("D3") *
    Pseq([16, 0, 11, 7].wrapExtend(4) ++ // DMaj7
        [17, 2, 12, 8].wrapExtend(4) ++  // Em7b5
        ([17, 2, 12, 8] + 2).wrapExtend(4) ++ // F#m7b5
        [17, 5, 12, 8].wrapExtend(4) // Gm
        , inf).midiratio,
    \amp, 1.5,
    \rel, 3
).play(~t1, quant: [2]);
)
