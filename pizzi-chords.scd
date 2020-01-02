(
~pizBas.stop;
~pizBas = Pbind(
    \instrument, \pizzicato_bas,
    \dur, Pseq([0.5], inf),
    \freq, ~toFreq.("D4") *
    Pseq([16, 0, 11, 7].wrapExtend(16) ++ // DMaj7
        [17, 2, 12, 8].wrapExtend(16) ++  // Em7b5
        ([17, 2, 12, 8] + 2).wrapExtend(16) ++ // F#m7b5
        [17, 5, 12, 8].wrapExtend(16) // Gm
        , inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 4).asStream.nextN(4) * 0.75, inf) * 0.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
)

(
~pizBas.stop;
~pizBas = Pbind(
    \instrument, \pizzicato_bas,
    \dur, Pseq([0.5], inf),
    \freq, ~toFreq.("D4") *
    Pseq([16, 0, 11, 7].wrapExtend(16) ++ // DMaj7
        [17, 2, 12, 8].wrapExtend(8) ++  // Em7b5
        ([17, 2, 12, 8] + 2).wrapExtend(8) ++ // F#m7b5
        [17, 5, 12, 8].wrapExtend(8) // Gm
        , inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 4).asStream.nextN(4) * 0.75, inf) * 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
~pizMelo.stop;
~pizMelo = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.5, 0.25, 1.25], inf),
    \freq, ~toFreq.("D6") *
    Pseq([4, 2, 0].wrapExtend(12) ++
        [5, 4, 2].wrapExtend(6) ++
        ([21, 20, 19]- 12).wrapExtend(6) ++
        [3, 2, 0].wrapExtend(6)

        , inf).midiratio,
    \amp, 1,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2, -0.25]);
)



(
~pizBas.stop;
~pizBas = Pbind(
    \instrument, \pizzicato_bas,
    \dur, Pseq([0.5], inf),
    \freq, ~toFreq.("D4") *
    Pseq([16, 0, 11, 7].wrapExtend(16) ++ // DMaj7
        [17, 2, 12, 8].wrapExtend(8) ++  // Em7b5
        ([17, 2, 12, 8] + 2).wrapExtend(8) ++ // F#m7b5
        [17, 5, 12, 8].wrapExtend(8) // Gm
        , inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 4).asStream.nextN(4) * 0.75, inf) * 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
~pizMelo.stop;
~pizMelo = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.5, 0.25, 0.75, 1.25 - 0.75], inf),
    \freq, ~toFreq.("D6") *
    Pseq([4, 2, 0, 0].wrapExtend(16) ++
        [5, 4, 2, 2].wrapExtend(8) ++
        ([21, 20, 19, 19]- 12).wrapExtend(8) ++
        [3, 2, 0, 0].wrapExtend(8)

        , inf).midiratio,
    \amp, 1,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2, -0.25]);
)