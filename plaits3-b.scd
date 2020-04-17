(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
u.free;
u = {
    var trig = Impulse.ar(10);
    var sig = MiPlaits.ar(31 + 24 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 0.5);
        HPF.ar(sig, 5000);
        // sig;
    }.play;
)
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
t.free;
t =
    {
    var trig = Impulse.ar(10);
    var sig = MiPlaits.ar(31 + 24 + 5 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 0.5);
        HPF.ar(sig, 5000);
        // sig;
    }.play;
)


s.record;
s.stopRecording;

(
var key = 62 + -0;
var notes = key + ([0, 5, 9].wrapExtend(12) ++ [0, 5, 10].wrapExtend(12)).reverse;
~pianoRiff2.stop;
~pianoRiff2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.35], inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 1, 1, 1], inf),
    \amp, Pseq([0.5, 1, 1, 0.5] * 0.25, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(quant: [2]);
)

(
var key = 62 + 12;
var notes = key + ([0, 5, 9].wrapExtend(24) ++ [0, 5, 10].wrapExtend(24));
~pianoRiff3.stop;
~pianoRiff3 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.35 * 0.5], inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 1, 1, 1], inf),
    \amp, Pseq([0.5, 1, 1, 0.5] * 0.25, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(quant: [2]);
)

(
var key = 62 + -24;
var notes = key + [5 + 12, 5 - 12];
~pianoRiffBas.stop;
~pianoRiffBas = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.35 * 8], inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 1, 1, 1], inf),
    \amp, Pseq([1] * 0.5, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 8
).play(quant: [2]);
)