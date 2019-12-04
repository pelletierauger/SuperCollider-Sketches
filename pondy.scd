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
~pondy.stop;
~pondy = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \pondchirp,
    \dur, Pseq([2], inf),
    \freq, ~toFreq.("F3") * Pseq([-12, 4, 0, 2].midiratio.stutter(2), inf),
    \amp, 16,
    \atk, 0.001,
    \rel, 16,
    \freqOsc, 10
).play(t, quant: [1]);
)



s.boot;
t = TempoClock.new;
t.tempo_(60/60);

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([Rest(0.25), 1.5, 0.25] ++ [Rest(0.5), 1.25, 0.25], inf),
    \amp, Pseq([1, 0.5], inf) * 3,
    \rate, 0.midiratio,
    \buf, Pseq([~pizziSamples[2], ~pizziSamples[2]].stutter(1), inf)
).play(t, quant: [1]);
)

(
~piz.stop;
~piz = Pbind(
    // \instrument, \pizzi,
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.25, 0.5, 0.5, 0.25] * 1, inf),
    \amp, Pseq([0.9, 0.25, 0.75, 0.25], inf) * 32 * Pseq([Pseries(1, -0.1, 8)], inf) * 0.5,
    \num, Pseq([6, 7, 7, 6].stutter(1), inf),
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
~piz2.stop;
~piz2 = Pbind(
    \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \dur, Pseq([0.5, 0.5, 0.5, 0.5], inf),
    \amp, Pseq([1, 0.75, 1.25, 0.5], inf) * 2  * Pseq([Pseries(1, -0.0125, 8)], inf),
    \rate, 1,
    \num, Pseq([11, 11, 10, 11], inf),
    // \buf, Pseq([~pizziSamples[11], ~pizziSamples[11], ~pizziSamples[0]].stutter(1), inf)
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)


(
~pondCluster = {
Synth.new(\pondchirp, [\freq, ~toFreq.("F2") * [2,4].choose * [0, 4, 7, 12].choose.midiratio, \amp, 4.7, \out, ~reverbBus, \rel, 20, \pan, rrand(0.0, 2.0) - 1, \freqOsc, rrand(0.1, 0.5) * 0.25, \triMod, 0.5, \dec, rrand(0.2, 0.3) * [0.5, 0.5, 1].choose, \low, rrand(200, 800)]);
Synth.new(\pondchirp, [\freq, ~toFreq.("F2") * [2,4].choose * [4, 9, 11, 19].choose.midiratio, \amp, 4.7, \out, ~reverbBus, \rel, 20, \pan, rrand(0.0, 2.0) - 1, \freqOsc, rrand(0.1, 0.5) * 0.25, \triMod, 1, \dec, rrand(0.2, 0.3) * [0.5, 0.5, 1].choose, \low, rrand(200, 800)]);
[2, 4, 6].choose;
};
)
(
~pondClusters = Task {
{~pondCluster.(); [2, 4, 6].choose.wait;}.loop;}.start;
)
~pondClusters.stop;
