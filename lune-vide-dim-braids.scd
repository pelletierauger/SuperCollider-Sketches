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
        // \dur, Pseq([1, 1, 0.5, 0.5, 1]/1.5, inf),
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




~nT = TempoClock.new(3).permanent_(true);
~nT.tempo;
~nT.tempo = 3.5;
(
var key = ~toMidi.("B3");
var dim = key + [-12, 3, 6, 9];
var nn = dim ++ (dim + 1);
// nn = nn + [1, 1, 0, 0, -6, -6, 0, 0].wrapExtend(nn.size);
var notes = [0, 3, 2, 4].wrapExtend(8) + [0, 1].stutter(4);
var nns = nn.sort.rotate(6);
(nns - key).postln;
nn = notes.collect({|item, i| nns[notes[i % nn.size]]});
(nn).postln;
// nn = nn[0] ++ nn[2] ++ nn[3]
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~basse.set(\relGate, 3, \trigGate, 0);
    ~basse = {
        | trigGate = 1, relGate = 0 |
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var e = EnvGen.kr(Env([0, 1, 0], [0.001, 2.5], [-8, -8]), t);
        var d = Demand.kr(t, 0, Dseq(nn.stutter(2).reverse + 12, inf));
        var sig = MiBraids.ar(d, timbre: 0.25, color: 0.75, model: 28, trig: t);
        sig = VadimFilter.ar(sig, 500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.8 * 4!2);
    }.play(fadeTime: 0).register;
});
)


(
var key = ~toMidi.("B0");
var dim = key + [0, 3, 6, 9];
var nn = dim ++ (dim + 1);
// nn = nn + [1, 1, 0, 0, -6, -6, 0, 0].wrapExtend(nn.size);
var notes = [0, 3, 2, 4].wrapExtend(8) + [0, 2].stutter(4);
var nns = nn.sort.rotate(0);
(nns - key).postln;
nn = notes.collect({|item, i| nns[notes[i % nn.size]]});
(nn).postln;
// nn = nn[0] ++ nn[2] ++ nn[3]
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~basse2.set(\relGate, 3, \trigGate, 0);
    ~basse2 = {
        | trigGate = 1, relGate = 0 |
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 5], ['lin', -3], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
        var e = EnvGen.kr(Env([0, 1, 0], [0.5, 4], [-8, -8]), t).lag(0.1);
        var d = Demand.kr(t, 0, Dseq(nn.stutter(1), inf));
        var sig = MiBraids.ar(d - 0.49, timbre: 0.9, color: 0.1, model: 43, trig: t);
        sig = VadimFilter.ar(sig, 500 * e + 200, 0, 1);
        Out.ar(0, sig * 0.3!2 * amp);
    }.play(fadeTime: 0).register;
});
)


(
var key = ~toMidi.("B3");
var dim = key + [-12, 3, 6, 9];
var nn = dim ++ (dim + 1);
// nn = nn + [1, 1, 0, 0, -6, -6, 0, 0].wrapExtend(nn.size);
var notes = [0, 3, 2, 4].wrapExtend(8) + [0, 1].stutter(4);
var nns = nn.sort.rotate(6);
(nns - key).postln;
nn = notes.collect({|item, i| nns[notes[i % nn.size]]});
(nn).postln;
// nn = nn[0] ++ nn[2] ++ nn[3]
~nT.sched(~nT.timeToNextBeat(quant: 8) + (~nT.beatDur * 0.5), {
    ~basse3.set(\relGate, 3, \trigGate, 0);
    ~basse3 = {
        | trigGate = 1, relGate = 0 |
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var e = EnvGen.kr(Env([0, 1, 0], [0.001, 2.5], [-8, -8]), t);
        var d = Demand.kr(t, 0, Dseq(nn.stutter(2), inf));
        var sig = MiBraids.ar(d, timbre: 0.25, color: 0.75, model: 28, trig: t);
        sig = VadimFilter.ar(sig, 500 * e + 50, 0, 1);
        Out.ar(0, sig * 0.4 * 2!2);
    }.play(fadeTime: 0).register;
});
)