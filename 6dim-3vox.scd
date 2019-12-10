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
        \num, Pseq(nn, inf) + Pseq([12] ++ (0!3) ++ (12!2), 2),
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
    \freq, ~toFreq.("D2") * ~modu.midiratio * Pseq([9, 4, 7, 9].midiratio.stutter(1).reverse, inf) * [2],
    \amp, 5,
    \atk, 0.2,
    \rel, 7,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.95]);
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
).play(t, quant: [2, -0.95]);
~pondy3.stop;
~pondy3 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \simplest,
    \dur, Pseq([3], inf),
    \freq, ~toFreq.("D4") * ~modu.midiratio * Pseq([0, 2, 0, 2, 0, 2, 4, 2 + 0].midiratio.stutter(1), inf),
    \amp, 1,
    \atk, 0.2,
    \rel, 2,
    \low, 1500,
    \freqOsc, 0.125
).play(t, quant: [2, -0.95]);
~dimClusters = Task {
    {~dimCluster.(); 6.wait;}.loop;
}.start(t, quant: [4]);
)


t = TempoClock.new;
t.tempo_(100/60);
(
SynthDef.new(\pondchirp, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 2, rel = 2, freqOsc = 6, triMod = 0.5, dec = 0.2, low = 200;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2, linPass, panFlip;
    panFlip = [[0, 1], [1, 0]].choose;
    osc = LFTri.ar(freqOsc, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, dec, 0.1 * freqOsc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, dec, 0.1 * freqOsc]));
    env = EnvGen.kr(Env.new([0.00001, 1, 0.00001], [atk, rel], curve: 'exp'), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.2, freq + 0.1] * 1, pi) * 0.02);
    sig = sig * env * amp;
    sig = (sig * loopEnv) * (1 + LFTri.ar([freq + 1.1, freq + 1] * 1.001 * triMod, mul: loopEnv * 1));
//     sig = sig + (sig * LFTri.ar([freq + 0.1, freq + 0.2] * 1.01) * 0.25);
    linPass = XLine.kr(low, 6000, atk + rel * 0.5);
    sig = LPF.ar(sig, linPass) * 1;
    sig = HPF.ar(sig, 250);
    sig = Balance2.ar(sig[panFlip[0]], sig[panFlip[1]], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
SynthDef.new(\simplest, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 1;
    var sig, env, lfo;
    rel = min(max(rel, 0.001), 10);
    lfo = SinOsc.kr(6).range(0.4, 1);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = LFTri.ar([freq, freq + 0.1]) * 0.1;
    sig = sig * env * amp * lfo * 2;
    sig = HPF.ar(sig, 140);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)