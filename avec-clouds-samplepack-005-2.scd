(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(0.5 * [0.5, 1, 0.5, 1, 1], inf),
    \buf, Pindex(~kicks, Pseq([6, 6, 6, 6, 9] + 25, inf)),
    // \buf, Pseq([~kicks[6], ~kicks[6], ~kicks[6], ~kicks[9]], inf),
    \amp, Pseq([0.25, 0.2, 0.25, 0.2, 0.25], inf),
    \ff, Pseq([2000, 3000, 1500, 3000, 9000], inf)
).play(~nT, quant: 2);
)


(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(0.5 * [0.5, 1, 0.5, 2], inf),
    \buf, Pindex(~kicks, Pseq([6, 6, 6, 6] + 25, inf)),
    // \buf, Pseq([~kicks[6], ~kicks[6], ~kicks[6], ~kicks[9]], inf),
    \amp, Pseq([0.25, 0.2, 0.25, 0.2], inf),
    \ff, Pseq([2000, 3000, 1500, 3000], inf)
).play(~nT, quant: 2);
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.98 * 0.5), 1.02 * 0.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~snares[13],
    \amp, Pseq([0.125], inf)
).play(~nT, quant: 2);
)

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.125], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[0],
    \amp, Pseq([0.65, 0.25, 0.5, 0.25] * 0.5, inf) * 0.125
).play(~nT, quant: 2);
)



(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(0.5 * [0.5, 1, 0.5, 0.98, 1.02].rotate(1), inf),
    \buf, Pindex(~kicks, Pseq([6, 4, 6, 4, 9].rotate(1) + 17, inf)),
    // \buf, Pseq([~kicks[6], ~kicks[6], ~kicks[6], ~kicks[9]], inf),
    \amp, Pseq([0.25, 0.5, 0.25, 0.5, 0.25].rotate(1) * 0.5, inf),
    \ff, Pseq([2000, 1000, 1500, 1000, 3000].rotate(1), inf)
).play(~nT, quant: 2);
)

//     |  .  .  .  |  .  .  .  |  .  .  .  |  .  .  .
~dr = [1, 1, 0, 1, 1, 0, 0, 0];
~dr = [1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0];

(
var stepIndex = Pseq((0..(16-1)), inf).asStream;
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(0.5 * [0.5], inf),
    \buf, FuncStream({
        var step = stepIndex.next;
        if (~dr.wrapExtend(16)[step] == 1, {~kicks[6 + 25]}, {Rest()});
    }),
    // \buf, Pseq([~kicks[6], ~kicks[6], ~kicks[6], ~kicks[9]], inf),
    \amp, Pseq([0.25, 0.2, 0.25, 0.2], inf),
    \ff, Pseq([2000, 3000, 1500, 3000], inf)
).play(~nT, quant: 2);
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.98 * 0.5), 1.02 * 0.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~snares[13],
    \amp, Pseq([0.125], inf)
).play(~nT, quant: 2);
)