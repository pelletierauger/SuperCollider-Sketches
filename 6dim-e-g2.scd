(
~maj6 = [0, 4, 7, 9];
~dim = [-3, 0, 3, 6];
~count = 0;
~add = 0;
~co = 0;
~oct = 36;
~dimCluster = {
    var key1 = ~toMidi.("E3") + ~add;
    var key2 = ~toMidi.("G3") + ~add;
    var chord1 = ~maj6 ++ ~maj6[0] ++ (~maj6[3] - 12);
    var chord2 = ~dim ++ ~dim[0] ++ (~dim[3] - 12);
    var notes1 = key1 + chord1;
    var notes2 = key2 + chord2;
    var nn = notes1 ++ notes2;
    var oo = ~oct;
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.1!2) ++ (0.8 - 0.5) ++ (0.5!2), 2),
        \num, Pseq(nn, inf) + Pseq([oo] ++ (0!3) ++ (oo!2), 2),
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
        ~add = ~add + 2;
        ~co = ~co + 1;
        ~oct = 24;
        if (~co == 2, {
            ~add = 0;
            ~co = 0;
            ~oct = 36;
        });
    });
};
)


~dimClusters.start(t, quant: [4]);
~dimClusters.stop;