(
~key2 = ~toFreq.("Eb4");
~key3 = ~toFreq.("F4");
~sec.stop;
~pha = 0.045;
~sec = Pbind(
    \instrument, \pulse,
    \dur, Pseq([~pha, ~pha, (1 * 1/3) - (~pha * 2)], inf),
    \freq, Pseq([
        Pseq(~key2 * [0, -5, 7].midiratio, 8),
        Pseq(~key3 * [-7, 0, 3].midiratio, 8)
    ], inf) * [0.5, 1],
    \pan, Pwhite(-0.75, 0.75, inf),
    \amp, Pseq([Pgeom(0.15, 0.85, 21), Pn(0.1, 3)], inf),
    \sus, 0.75,
    \sus, Pseq([Pgeom(0.75, 1.02, 21), Pn(0.75, 3)], inf),
    \dtun, Pseq([Pgeom(1, 1.001, 21), Pn(1, 3)], inf),
    \freqRin, 2,
    \atk, Pseq([Pgeom(0.001, 1.25, 21), Pn(0.1, 3)], inf),
    \out, 0
).play(t, quant: 1);
/*~sec2.stop;
~pha = 0.045;
~sec2 = Pbind(
    \instrument, \pulse,
    \dur, Pseq([~pha, ~pha, (1 * 1/3) - (~pha * 2)], inf),
    \freq, Pseq([
        Pseq(~key2 * 7.midiratio * [0, 4, 7].midiratio, 8),
        Pseq(~key3 * 7.midiratio * [-7, 0, 3].midiratio, 8)
    ], inf) * [0.5],
    \pan, Pwhite(-0.75, 0.85, inf),
    \amp, Pseq([Pgeom(0.15, 0.85, 24)], inf),
    \sus, Pseq([Pgeom(0.75, 1.15, 24)], inf),
    \freqRin, 2,
    \atk, 0.001,
    \out, 0
).play(t, quant: [1, 0.5]);*/
)

~test = Pgeom(0.001, 1.25, 24).asStream;
~test.next;