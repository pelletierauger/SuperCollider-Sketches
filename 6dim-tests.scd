(
~maj6 = [0, 4, 7, 9];
~dim = [-3, 0, 3, 6];
~count = 0;
~modu = 0;
~dimCluster = {
    var key1 = ~toMidi.("D3") + ~modu;
    var key2 = ~toMidi.("E3") + ~modu;
    var chord1 = ~maj6 ++ ~maj6[0] ++ (~maj6[3] - 12);
    var chord2 = ~dim ++ ~dim[0] ++ (~dim[3] - 12);
    var notes1 = key1 + chord1;
    var notes2 = key2 + chord2;
    var nn = notes1 ++ notes2;
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.1!2) ++ (0.8 - 0.5) ++ (0.5!2), 2),
        \num, Pseq(nn, inf) + Pseq([24] ++ (0!3) ++ (24!2), 2),
        \dyn, Pseq([2, 1, 1, 1, 2, 2], inf),
        \amp, Pseq([0.25, 0, 0, 0, 0.25, 0.25], inf)
    ).play(t, quant: [2]);
    ~maj6 = [~maj6[1], ~maj6[2], ~maj6[3], ~maj6[0] + 12];
    ~dim = [~dim[1], ~dim[2], ~dim[3], ~dim[0] + 12];
    ~count = ~count + 1;
    if (~count == 2, {~dim = [~dim[3] - 12, ~dim[0], ~dim[1], ~dim[2]]});
    if (~count == 4, {
        ~maj6 = [0, 4, 7, 9];
        ~dim = [-3, 0, 3, 6];
        ~count = 0;
    });
};
~pondy.stop;
~pondy = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \pondchirp,
    \dur, Pseq([6], inf),
    \freq, ~toFreq.("D2") * ~modu.midiratio * Pseq([7, 4, 7, 9].midiratio.stutter(1).reverse, inf) * [2],
    \amp, 5,
    \atk, 0.2,
    \rel, 7,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.65]);
~pondy2.stop;
~pondy2 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \pondchirp,
    \dur, Pseq([Rest(3), 3], inf),
    \freq, ~toFreq.("E2") * ~modu.midiratio * Pseq([3, 9, 6, 9].midiratio.stutter(2), inf) * [2],
    \amp, 5,
    \atk, 0.2,
    \rel, 7,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.65]);
~pondy3.stop;
~pondy3 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \simplest,
    \dur, Pseq([3], inf),
    \freq, ~toFreq.("D4") * ~modu.midiratio * Pseq([0, 2, 0, 2, 0, 2, 4, 2 + 0].midiratio, inf),
    \amp, 1,
    \atk, 0.2,
    \rel, 3,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.65]);
/*~pondy.stop;
~pondy = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    // \instrument, \pondchirp,
    \type, \playPiano,
    \dur, Pseq([6], inf),
    \num, ~toMidi.("D2") + Pseq([0, 4, 7, 9].stutter(1).reverse, inf),
    \amp, 1,
    \dyn, 1,
    \atk, 0.001,
    \rel, 12,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2]);
~pondy2.stop;
~pondy2 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    // \instrument, \pondchirp,
    \type, \playPiano,
    \dur, Pseq([Rest(3.25), 3 - 0.25], inf),
    \num, ~toMidi.("E2") + Pseq([0, 3, 6, 9].stutter(2), inf),
    \dyn, 1,
    \amp, 2,
    \atk, 0.001,
    \rel, 12,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.25]);*/
)