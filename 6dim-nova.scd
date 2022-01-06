~dT = TempoClock.new(100/60).permanent_(true);
~dT.tempo_(100/60);
~dT.permanent

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
        \dyn, Pseq([1, 0, 0, 0, 1, 1], inf),
        \amp, Pseq([0.5, 1, 1, 1, 0.5, 0.5], inf)
    ).play(~dT, quant: [2]);
    ~maj6 = ~maj6.rotate(-1) + [0, 0, 0, 12];
    ~dim = ~dim.rotate(-1) + [0, 0, 0, 12];
    ~count = ~count + 1;
    if (~count == 2, {~dim = ~dim.rotate(1) - [12, 0, 0, 0]});
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
}.start(~dT, quant: [4]);
)
~dimClusters.stop;



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
        \num, Pseq(nn, inf) + Pseq([36] ++ (0!3) ++ (36!2), 2),
                \dyn, Pseq([1, 0, 0, 0, 1, 1], inf),
        \amp, Pseq([0.5, 1, 1, 1, 0.5, 0.5] - 0.4, inf)
    ).play(~dT, quant: [2]);
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