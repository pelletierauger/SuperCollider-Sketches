(
~buildVoice3.stop;
~buildVoice3 = Pbind(
    \instrument, \vox,
    \dur, 2,
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.237 + 0.041].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.5),

    // \spos, Pseq([0.275].stutter(40), inf) + (Pwhite(0.001, 0.002, inf) * 0.5),
    \spos, Pseq([0.278].stutter(40), inf) + (Pwhite(0.001, 0.002, inf) * 0.5),
    \spos, Pseq([0.279].stutter(40), inf) + (Pwhite(0.001, 0.002, inf) * 0.5),

    // Les intros lancinantes
    \spos, Pseq([0.065, 0.067].stutter(4), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),

    \spos, Pseq([0.068, 0.069].stutter(4), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.13, 0.069].stutter(8), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.067, 0.069].stutter(8), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.067, 0.0665, 0.069, 0.08].stutter(8), inf),
    \spos, Pseq([0.071, 0.072, 0.073, 0.074, 0.075, 0.076, 0.077].stutter(4), inf) + Pseq([0, 0.000], inf),
//     \spos, Pseq([0.067, 0.0665].stutter(1), inf),
    \rel, 0.75,
    \atk, 0.07,
    \amp, 1 * Pseq([Pgeom(1, 1.1265, 8)], inf) * 0.5 * Pseq([1, 0.5], inf) * Pdefn(\buildAmp2, 0.5),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t, quant: 4);
)

Pdefn(\buildAmp2, 4);

(
~buildVoice4.stop;
~buildVoice4 = Pbind(
    \instrument, \vox,
    \dur, 4,
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.237 + 0.041].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.5),

    // \spos, Pseq([0.275].stutter(40), inf) + (Pwhite(0.001, 0.002, inf) * 0.5),
    \spos, Pseq([0.278].stutter(40), inf) + (Pwhite(0.001, 0.002, inf) * 0.5),
    \spos, Pseq([0.279].stutter(40), inf) + (Pwhite(0.001, 0.002, inf) * 0.5),

    // Les intros lancinantes
    \spos, Pseq([0.065, 0.067].stutter(4), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),

    \spos, Pseq([0.068, 0.069].stutter(4), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.13, 0.069].stutter(8), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.067, 0.069].stutter(8), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.067, 0.0665, 0.069, 0.08].stutter(8), inf),
    \spos, Pseq([0.2, 0.132, 0.133, 0.134].stutter(4), inf) + Pseq([0, 0.000], inf),
//     \spos, Pseq([0.067, 0.0665].stutter(1), inf),
    \rel, 2.75,
    \atk, 0.07,
    \amp, 0.5 * Pseq([Pgeom(1, 1.1265, 8)], inf) * Pseq([1, 0.5], inf) * Pdefn(\buildAmp2, 0.5),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t, quant: 4);
)