~toOSC.sendMsg("/eval", s);

(
var stepIndex = Pseq((0..15), inf).asStream;
~ticking = {
    ~ticks.stop;
    ~ticks = Pbind(
        \instrument, \tick,
        \dur, 0.25,
        \dur, FuncStream({
            var n = stepIndex.next;
            ~toOSC.sendMsg("/beat", n);
            0.25;
        }),
        \beat, Pseq([1, 0, 0, 0], inf),
        \subd, Pseq([1, 1, 1, 1], inf)
    ).play(~nT, quant: 4);
};
CmdPeriod.remove(~ticking);
CmdPeriod.add(~ticking);
~ticking.();
)