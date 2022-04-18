t = TempoClock.new(90/60).permanent_(true);

(
var key = ~toMidi.("B4");
var dim = key + [-24, 3, 6, 9];
var nn = dim ++ (dim + 1);
// nn = nn + [1, 1, 0, 0, -6, -6, 0, 0].wrapExtend(nn.size);
var notes = [0, 3, 0, 2, 5].wrapExtend(10) + [0, 1].stutter(5);
var nns = nn.sort.rotate(6);
(nns - key).postln;
nn = notes.collect({|item, i| nns[notes[i % nn.size]]});
(nn).postln;
// nn = nn[0] ++ nn[2] ++ nn[3]
t.schedAbs(t.nextTimeOnGrid(quant: 4), {
    ~pia.stop;
    ~pia = Pbind(
    \type, \pianoEvent,
    // \dur, Pseq(0.5!1 ++ (sp) ++ (4 - 0.8), inf),
        // \dur, Pseq(0.5!1 ++ (sp), inf) ++ Pseq([0, (4 - 0.8)], inf) * 2,
        \dur, 0.5,
        \dur, Pseq([1, 1, 0.5, 0.5, 1]/1.5, inf),
        \rel, 2,
        // \dur, Pseq([3, 3, 2]/3, inf) * 1,
    \num, Pseq(nn, inf),
    \dyn, Pseq([0], inf),
    \amp, Pseq([1] * 0.5, inf)
).play(t);
});
)


[2, 3, 1].sort

[ 0, 3, 7, 1, 4, 9 ].sort