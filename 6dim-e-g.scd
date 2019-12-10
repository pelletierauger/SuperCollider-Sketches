(
~maj6 = [0, 4, 7, 9];
~dim = [-3, 0, 3, 6];
~count = 0;
~dimCluster = {
    var key1 = ~toMidi.("E3");
    var key2 = ~toMidi.("G3");
    var chord1 = ~maj6 ++ ~maj6[0] ++ (~maj6[3] - 12);
    var chord2 = ~dim ++ ~dim[0] ++ (~dim[3] - 12);
    var notes1 = key1 + chord1;
    var notes2 = key2 + chord2;
    var nn = notes1 ++ notes2;
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.1!2) ++ (0.8 - 0.5) ++ (0.5!2), 2),
        \num, Pseq(nn, inf) + Pseq([36] ++ (0!3) ++ (36!2), 2)
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
)


(
~maj6 = [0, 4, 7, 9];
~dim = [-3, 0, 3, 6];
~count = 0;
~dimCluster = {
    var key1 = ~toMidi.("E3");
    var key2 = ~toMidi.("G3");
    var chord1 = ~maj6 ++ ~maj6[0] ++ (~maj6[3] - 12);
    var chord2 = ~dim ++ ~dim[0] ++ (~dim[3] - 12);
    var notes1 = key1 + chord1;
    var notes2 = key2 + chord2;
    var nn = notes1 ++ notes2;
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.1!2) ++ (0.8 - 0.5) ++ (0.5!2), 2),
        \num, Pseq(nn, inf) + Pseq([36] ++ (0!3) ++ (36!2), 2)
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
    // \instrument, \pondchirp,
    \type, \playPiano,
    \dur, Pseq([6], inf),
    \num, ~toMidi.("E3") + Pseq([7, 4, 7, 9].stutter(1).reverse, inf),
    \amp, 16,
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
    \num, ~toMidi.("G3") + Pseq([0, 3, 6, 3].stutter(2), inf),
    \amp, 16,
    \atk, 0.001,
    \rel, 12,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.25]);
)