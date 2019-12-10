(
~pondy.stop;
~pondy = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    // \instrument, \pondchirp,
    \type, \playPiano,
    \dur, Pseq([6], inf),
    \num, ~toMidi.("D2") + Pseq([9, 4, 7, 9].stutter(1).reverse, inf),
    \dyn, 1,
    \amp, 2
).play(t, quant: [2, -0.5]);
~pondy2.stop;
~pondy2 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    // \instrument, \pondchirp,

    \type, \playPiano,
    \dur, Pseq([Rest(3), 3], inf),
    \num, ~toMidi.("E2") + Pseq([3, 9, 6, 9].stutter(2), inf),
    \dyn, 1,
    \amp, 2
).play(t, quant: [2, -0.5]);
)