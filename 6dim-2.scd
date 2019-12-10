(
var key1 = ~toMidi.("C4");
var key2 = ~toMidi.("D4");
var notes1 = key1 + [4, 7, 9, 12];
var notes2 = key2 + [3, 6, 9, 12];
// var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes1 ++ notes2;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!3 ++ 3.6, inf),
    \num, Pseq(nn, inf)
).play(t, quant: [1, -0.4]);
// ~piaBas.stop;
// ~tamb.stop;
)


a = [0, 4, 7, 9];


a = [a[1], a[2], a[3], a[0] + 12];


(
~maj6 = [0, 4, 7, 9];
~dim = [0, 3, 6, 9];
~dimCluster = {
    var key1 = ~toMidi.("B3");
    var key2 = ~toMidi.("C#4");
    var notes1 = key1 + ~maj6;
    var notes2 = key2 + ~dim;
    var nn = notes1 ++ notes2;
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.1!2) ++ (1.6 - 0.5), 2),
        \num, Pseq(nn, inf) + Pseq([-12] ++ (0!3), 2)
    ).play(t, quant: [1, -0.4]);
    ~maj6 = [~maj6[1], ~maj6[2], ~maj6[3], ~maj6[0] + 12];
    ~dim = [~dim[1], ~dim[2], ~dim[3], ~dim[0] + 12];
};
)
(
~dimClusters = Task {
    {~dimCluster.(); 6.wait;}.loop;
}.start(t, quant: [4]);
)
~dimClusters.stop;



(
~maj6 = [0, 4, 7, 9];
~dim = [0, 3, 6, 9];
~count = 0;
)

(
~maj6 = [0, 4, 7, 9];
~dim = [-3, 0, 3, 6];
~count = 0;
~dimCluster = {
    var key1 = ~toMidi.("D3");
    var key2 = ~toMidi.("E3");
    var chord1 = ~maj6 ++ ~maj6[0] ++ (~maj6[3] - 12);
    var chord2 = ~dim ++ ~dim[0] ++ (~dim[3] - 12);
    var notes1 = key1 + chord1;
    var notes2 = key2 + chord2;
    var nn = notes1 ++ notes2;
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.1!2) ++ (0.8 - 0.5) ++ (0.5!2), 2),
        \num, Pseq(nn, inf) + Pseq([24] ++ (0!3) ++ (24!2), 2)
    ).play(t, quant: [2]);
    ~maj6 = [~maj6[1], ~maj6[2], ~maj6[3], ~maj6[0] + 12];
    ~dim = [~dim[1], ~dim[2], ~dim[3], ~dim[0] + 12];
    ~count = ~count + 1;
    if (~count == 4, {
        ~maj6 = [0, 4, 7, 9];
        ~dim = [-3, 0, 3, 6];
        ~count = 0;
    });
};
)

~dimCluster.();

s.record;
s.stopRecording;

(
var n = 3;
if (n == 2, {23.postln})

)

s.record;
s.stopRecording;

(
~maj6 = [0, 4, 7, 9];
~dim = [-3, 0, 3, 6];
~count = 0;
~dimCluster = {
    var key1 = ~toMidi.("D3");
    var key2 = ~toMidi.("E3");
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
        \amp, Pseq([0.5, 1, 1, 1, 0.5, 0.5], inf)
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
~dimClusters = Task {
    {~dimCluster.(); 6.wait;}.loop;
}.start(t, quant: [4]);
)
~dimClusters.stop;

~dimClusters.start(t, quant: [4]);


t.tempo_(90/60);
// --------------------------------------------------------------------------------//
// Une belle basse en deux Pbind
// --------------------------------------------------------------------------------//

(
~pondy.stop;
~pondy = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \simplest,
    \dur, Pseq([6], inf),
    \freq, ~toFreq.("D2") * Pseq([0, 4, 7, 9].midiratio.stutter(1).reverse, inf),
    \amp, 3,
    \atk, 0.01,
    \rel, 3,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.25]);
~pondy2.stop;
~pondy2 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \simplest,
    \dur, Pseq([Rest(3), 3], inf),
    \freq, ~toFreq.("E2") * Pseq([0, 3, 6, 9].midiratio.stutter(2), inf),
    \amp, 3,
    \atk, 0.01,
    \rel, 3,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.25]);
)




(
~piz2.stop;
~piz2 = Pbind(
    // \instrument, Pseq([\pizzi, \pizziFlip].stutter(1), inf),
    \instrument, Pseq(\pizzi!2 ++ (\pizziFlip!3), inf),
    // \instrument, \pizzi,
    \dur, Pseq([0.75, 0.25, 0.5, 0.25, 0.25] * 1, inf),
    \amp, Pseq([1, 0.5] ++ (1!3), inf) * 3,
    \rate, -5.midiratio,
    \num, Pseq([4, 4, -2, 3, 5], inf) + Pseq([3, 4].stutter(5), inf),
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [4, -0.25]);
)

(
~pizHat.stop;
~pizHat = Pbind(
    // \instrument, Pseq([\pizzi, \pizziFlip].stutter(1), inf),
    \instrument, Pseq(\pizzi!1 ++ (\pizziFlip!1), inf),
    // \instrument, \pizzi,
    \dur, Pseq([Rest(0.5), 0.5] * 1, inf),
    \amp, Pseq([1, 1], inf) * 3,
    \rate, 0.midiratio,
    \num, Pseq([11], inf),
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [4, -0.25]);
)




(0.5!1 ++ (0.1!2) ++ (0.8 - 0.5) ++ (0.5!2)).sum


(
~maj6 = [0, 4, 7, 9];
~dim = [-3, 0, 3, 6];
~count = 0;
~dimCluster = {
    var key1 = ~toMidi.("D3");
    var key2 = ~toMidi.("E3");
    var chord1 = ~maj6 ++ ~maj6[0] ++ (~maj6[3] - 12);
    var chord2 = ~dim ++ ~dim[0] ++ (~dim[3] - 12);
    var notes1 = key1 + chord1;
    var notes2 = key2 + chord2;
    var nn = notes1 ++ notes2;
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.1!2) ++ (0.8 - 0.5) ++ (0.5!2), 2),
        \num, Pseq(nn, inf) + Pseq([24] ++ (0!3) ++ (24!2), 2)
    ).play(t, quant: [2]);
    Pbind(
        \type, \playPiano,
        \dur, Pseq(Rest(0.25)!1 ++ (0.5!1) ++ (Rest(0.1)!2) ++ (Rest(0.8 - 0.5)) ++ (0.5!2), 2),
        \num, Pseq(nn, inf) + Pseq([24] ++ (0!3) ++ (24!2), 2) - 12
    ).play(t, quant: [2]);
    ~maj6 = [~maj6[1], ~maj6[2], ~maj6[3], ~maj6[0] + 12];
    ~dim = [~dim[1], ~dim[2], ~dim[3], ~dim[0] + 12];
    ~count = ~count + 1;
    if (~count == 4, {
        ~maj6 = [0, 4, 7, 9];
        ~dim = [-3, 0, 3, 6];
        ~count = 0;
    });
};
)