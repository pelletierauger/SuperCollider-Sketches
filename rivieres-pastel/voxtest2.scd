// --------Build-voice---------------------- //
(
~buildVoice2.stop;
~buildVoice2 = Pbind(
    \instrument, \vox2,
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
    \spos, Pseq([0.067, 0.0665, 0.0681, 0.0695].stutter(4), inf) + Pseq([0, 0.000], inf),
//     \spos, Pseq([0.067, 0.0665].stutter(1), inf),
    \rel, 0.75,
    \atk, 0.07,
    \amp, 1 * Pseq([Pgeom(1, 1.1265, 8)], inf) * Pseq([1, 0.5], inf) * Pdefn(\buildAmpV2, 0.5),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t, quant: 4);
)
Pdefn(\buildAmpV2, 2);
~buildVoice2.stop;
Pdefn(\buildAmp2, 0.25);
Pdefn(\buildAmp3, 7);


(
~buildVoice2b.stop;
~buildVoice2b = Pbind(
    \instrument, \vox,
    \dur, Pseq([0.25,0.25,0.25, 0.25, 2] * 2, inf),
    \spos, Pseq([0.111, 0.1119].stutter(4), inf),
    \spos, 0.0695 - 0.00025,
    \rel, 0.3,
    \atk, 0.001,
    \amp, 1 * Pseq([Pgeom(1, 1.1265, 16)], inf) * Pseq([1, 0.5], inf) * Pdefn(\buildAmp2, 1),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~reverbBus
).play(t, quant: [4, 2]);
)
~buildVoice2b.stop;


(
// Lent build-up, un la soutenu
~buildVoice3.stop;
~buildVoice3 = Pbind(
    \instrument, \vox,
    \dur, 1 / 16 * 4 * 4,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
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
    \spos, Pseq([0.13, 0.1305].stutter(1), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.1301, 0.1305].stutter(8), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 0.3,
    \atk, 0.09,
    \rate, [1] * -8.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \amp, Pseq([Pgeom(1, 1.265, 8)].stutter(4), inf) * Pdefn(\buildAmp3, 1),
//     \amp, 8,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~reverbBus
).play(t, quant: [4, 2]);
)
Pdefn(\buildAmp3, 8);


(
t.schedAbs(t.nextBar + 0.25, {
~bass0 = Synth.new(\metro, [\freq, 110 * -4.midiratio * 1, \amp, 1, \out, 0, \rel, 4, \atk, 0.001, \pan, rrand(-0.5, 0.5)]);
}
);
)


(
~basse.stop;
~basse = Pbind(
    \instrument, \metro,
    \dur, Pseq([6, 2] * 2, inf),
    \freq, Pseq([55 * -4.midiratio, 55 * 3.midiratio] * 2, inf),
    \rel, Pseq([3.5, 1] * 2, inf),
    \atk, 0.0001,
    \amp, 2,
    \out, 0
).play(t, quant: 4);
)




(
~buildVoice4.stop;
~buildVoice4 = Pbind(
    \instrument, \vox,
    \dur, 1,
    \spos, Pseq([0.2005, 0.215].stutter(16), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
        \spos, Pseq([0.2005].stutter(16), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 0.75,
    \atk, 0.07,
    \rate, [1] * -8.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \amp, Pseq([Pgeom(10, 1.1, 16)], inf) * Pdefn(\buildAmp4, 1) * 0.25,
//  \amp, Pseq([Pgeom(10, 1.1, 16)], inf) * 1,
    \pan, Pwhite(-1.0, 1.0, inf),
    \pan, Pseq([-1, 1], inf),
    \out, 0
).play(t, quant: 4);
)
Pdefn(\buildAmp4, 3);



(
~buildVoice5.stop;
~buildVoice5 = Pbind(
    \instrument, \vox,
    \dur, 1,
    \spos, Pseq([0.2005].stutter(16), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \spos, Pseq([0.305, 0.202].stutter(2), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 0.5,
    \atk, 0.07,
    \rate, [1] * -8.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \amp, Pseq([1, 0.5], inf) * Pseq([Pgeom(2, 1.12, 16)], inf) * Pdefn(\buildAmp5, 1) * 0.5,
//     \amp, 20,
    \pan, Pwhite(-1.0, 1.0, inf),
    \pan, Pseq([-1, 1], inf),
    \out, 0
).play(t, quant: 4);
)
Pdefn(\buildAmp5, 7);

(
// ~poussiere.free;
~buildVoice2.stop;
~buildVoice3.stop;
~buildVoice4.stop;
~buildVoice5.stop;
~mousse.set(\gate, 0);
~poussiere.set(\gate, 0);
~shimmerD3.stop;
~shimmerD4.stop;
~brindilles.set(\gate, 0);
)


(
Pdefn(\buildAmp2, 12 * 0.05);
Pdefn(\buildAmp3, 8 * 0.05);
Pdefn(\buildAmp4, 3 * 0.05);
Pdefn(\buildAmp5, 7 * 0.05);
Pdefn(\bassyAmp, 1 * 0.05);
~mousse.setn(\altAmp, 1 * 0.05);
~brindilles.setn(\altAmp, 1 * 0.05);
)