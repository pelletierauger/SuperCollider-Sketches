t = TempoClock(117/60)
t.permanent = true;
t.tempo = 117/60;
(
var key = ~toMidi.("A3");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
var r = Rest(1);
~pia.stop;
~pia = Pbind(
    \instrument, \sineSynth,
    \atk, 0.001,
    \rel, 1,
    \dur, Pseq([1, 1, 1, r, 1, 1, r, 1, r, 1, 1, r] * 0.5, inf),
    \freq, Pseq([440 * 5.midiratio], inf)
).play(t, quant: [4]);
)

(
~pia2.stop;
~pia2 = Pbind(
    \instrument, \sineSynth,
    \atk, 0.005,
    \rel, 2,
    \dur, Pseq([4] * 0.5, inf),
    \freq, Pseq(220 * [0].midiratio, inf)
).play(t, quant: [4]);
)

(
~pia3.stop;
~pia3 = Pbind(
    \instrument, \sineSynth,
    \atk, 0.005,
    \rel, 1,
    \dur, Pseq([0.1, 2 - 0.1] * 0.5, inf),
    \freq, Pseq(220 * [7, 14].midiratio, inf),
    \amp, 0.25
).play(t, quant: [4]);
)

(
~pia4.stop;
~pia4 = Pbind(
    \instrument, \sineSynth,
    \atk, 0.005,
    \rel, 2,
    \dur, Pseq([7, 5] * 0.5, inf),
    \freq, Pseq(110 * [12, 19].midiratio, inf) * 0.5,
    \amp, 0.5
).play(t, quant: [4]);
)

(
var r = 1;
[1, 1, 1, r, 1, 1, r, 1, r, 1, 1, r].size;

)