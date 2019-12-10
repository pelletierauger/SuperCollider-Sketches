(
~pondy.stop;
~pondy = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    // \instrument, \pondchirp,
    \type, \playPiano,
    \dur, Pseq([6], inf),
    \num, ~toMidi.("D2") + Pseq([0, 4, 7, 9].stutter(1).reverse, inf),
    \amp, 16,
    \atk, 0.001,
    \rel, 12,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2]);
)


(
~pondy2.stop;
~pondy2 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    // \instrument, \pondchirp,
    \type, \playPiano,
    \dur, Pseq([Rest(3.25), 3 - 0.25], inf),
    \num, ~toMidi.("E2") + Pseq([0, 3, 6, 9].stutter(2), inf),
    \amp, 16,
    \atk, 0.001,
    \rel, 12,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.25]);
)
