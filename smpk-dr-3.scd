(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.125], inf),
    \buf, ~hats[0],
    \amp, Pseq([0.65, 0.25, 0.5, 0.25] * 0.35, inf) * 0.125
).play(~nT, quant: 2);
)

~kSeq = [1, 1, 0, 1, 1, 0, 0, 0];
~kSeq = [1, 0, 1, 0];
~nT.tempo = 1.33
~nT.tempo = 1.35
~nT.tempo
~kSeq = [1, 1, 0, 1, 1, 0, 0, 1] ++ [0, 1, 0, 1, 1, 0, 0, 1];
~kSeq = [1, 1, 0, 1, 1, 0, 0, 1] ++ [0, 1, 0, 1, 1, 0, 0, 0]; // Le bon
~kSeq = [1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1].rotate(-4);
~kSeq = [1, 0, 0, 1, 0, 1, 0, 1] ++ [1, 0, 0, 1, 1, 1, 0, 1];
~kSeq = [1, 1, 0, 1, 1, 0, 1, 1] ++ [0, 1, 1, 0, 1, 0, 1, 0];
~sSeq = [0, 0, 1, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 0, 1, 0];
(
var kStepIndex = Pseq((0..(16-1)), inf).asStream;
var sStepIndex = Pseq((0..(16-1)), inf).asStream;
~grr.();
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(0.5 * [0.5], inf),
    \buf, FuncStream({
        var step = kStepIndex.next;
        if (~kSeq.wrapExtend(16)[step] == 1, {~kicks[6 + 25]}, {Rest()});
    }),
    \amp, Pseq([0.25, 0.2, 0.25, 0.2], inf),
    \ff, Pseq([2000, 2000, 1500, 2000], inf)
).play(~nT, quant: 2);
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq(0.5 * [0.5], inf),
    \buf, FuncStream({
        var step = sStepIndex.next;
        if (~sSeq.wrapExtend(16)[step] == 1, {~snares[13]}, {Rest()});
    }),
    \amp, Pseq([0.125], inf)
).play(~nT, quant: 2);
)

(
~k.stop;
~s.stop;
m.set(\trigGate, 0, \gate, 0, \fadeTime, 15);
~h.stop;
)

(
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
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.01, {
    ~kSeq = [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 1, 0, 0, 0, 1, 0, 0];
    ~sSeq = [0, 0, 0, 0, 1, 0, 0, 0];
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.01, {
    ~kSeq = [1, 0, 0, 0, 0, 0, 0, 0];
    ~sSeq = [0, 0, 0, 0, 1, 0, 0, 0];
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.01, {
    ~kSeq = [1, 1, 0, 1, 1, 0, 0, 1] ++ [0, 1, 0, 1, 1, 0, 0, 0]; // Le bon
    ~sSeq = [0, 0, 1, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 0, 1, 0];
});
)