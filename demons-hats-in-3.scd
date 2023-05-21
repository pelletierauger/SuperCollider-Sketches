(
~h2.stop;
~h2 = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([3, 3, 3, 3, 2, 2]/4, inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \spos, Pseq([0.2], inf),
    \buf, ~hats[7],
    \amp, Pseq([0.75] ++ ((4!5) * [0.5, 1, 0.5]), inf) * 0.125 * 0.25
).play(~nT, quant: 2);
)


(
~h2.stop;
~h2 = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([3, 3, 3, 3, 2, 2]/4, inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \spos, Pseq([0.2], inf),
    \buf, ~hats[7],
    \amp, Pseq([0.75] ++ ((4!5) * [0.5, 1, 0.5]), inf) * 0.125 * 0.25
).play(~nT, quant: 2);
)

(
~h2.stop;
~h2 = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([3, 3, 3, 3, 2, 2]/4, inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \spos, Pseq([0.05], inf),
    \buf, ~hats[16],
    \amp, Pseq([0.75] ++ ((4!5) * [0.5, 1, 0.5]), inf) * 0.125 * 0.25
).play(~nT, quant: 2);
)