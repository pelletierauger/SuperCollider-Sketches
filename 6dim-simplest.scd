play({ PMOsc.ar([440, 440+1], 440 * 8, Line.ar(0,1,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });


(
SynthDef.new(\simplest, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.001, rel = 1, dec = 0.2;
    var sig, env, lfo;
    // rel = 0.5;
    // freq = freq * 2;
    rel = min(max(rel, 0.001), 10);
    lfo = SinOsc.kr(6).range(0.4, 1);
    env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [atk, dec, rel]), doneAction: 2);
    sig = PMOsc.ar([freq, freq+1], freq * 1, Line.ar(0,40,8), 0, XLine.ar(0.1,0.0001, 16, 1, 0, 2));
    sig = sig * LFTri.ar(freq * 1 * [1.02, 1.01]) * SinOsc.ar(freq * 0.5);
    sig = sig * env * amp * lfo * 8;
    sig = LPF.ar(sig, Line.ar(5050, 600, dec));
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


(
~maj6 = [0, 4, 7, 9];
~dim = [-3, 0, 3, 6];
~count = 0;
~dimCluster = {
    var key1 = ~toFreq.("D3");
    var key2 = ~toFreq.("E3");
    var chord1 = ~maj6 ++ ~maj6[0] ++ (~maj6[3] - 12);
    var chord2 = ~dim ++ ~dim[0] ++ (~dim[3] - 12);
    var notes1 = key1 * chord1.midiratio;
    var notes2 = key2 * chord2.midiratio;
    var nn = notes1 ++ notes2;
    Pbind(
        \instrument, \simplest,
        \dur, Pseq(0.5!1 ++ (0.1!2) ++ (0.8 - 0.5) ++ (0.5!2), 2),
        \freq, Pseq(nn, inf) * Pseq(([24] ++ (0!3) ++ (24!2)).midiratio, 2),
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