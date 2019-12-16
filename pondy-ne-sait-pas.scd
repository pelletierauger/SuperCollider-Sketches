(
~pondy.stop;
~pondy = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \pondchirp,
    \dur, Pseq([11.2 / 2], inf),
    \freq, ~toFreq.("C#3") * Pseq([0, -2, -9, -7].midiratio.stutter(1), inf) * [2],
    \amp, 50,
    \atk, 0.2,
    \dec, 0.1,
    \rel, 20,
    \low, 1500,
    \freqOsc, 0.1
).play(t);
)

(
~pondy2.stop;
~pondy2 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \pondchirp,
    \dur, Pseq([11.2 / 2], inf),
    \freq, ~toFreq.("E#2") * Pseq([-12, -14, -9, -7].midiratio.stutter(1), inf) * [2],
    \amp, 30,
    \atk, 0.2,
    \dec, 20,
    \rel, 20,
    \low, 50,
    \freqOsc, 10
).play(t);
)