(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq(4 * [0.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, Pseq([~kicks[54]], inf),
    \amp, 0.25
).play(~nT, quant: 2);
)

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[30],
    \amp, Pseq([0.65, 0.25, 0.5, 0.25] * 0.5, inf) * 0.125
).play(~nT, quant: 2);
)


(
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.75), 1.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~snares[44],
    \amp, Pseq([0.125], inf)
).play(~nT, quant: 2);
)