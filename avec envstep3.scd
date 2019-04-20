(
{
    var env = Env.step([0, -5, -7, -3, -7, -10, 2], [1, 1, 2, 1, 1, 2, 2] * 0.5, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 65 + -19).midicps;
    var osc = (SinOsc.ar(1, 0.5, 0.5) * 5).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    HPF.ar(GVerb.ar(sig, 4, 10, 0.9) + Ringz.ar(sig, freq, mul:0.1), 175);
}.play;
)
(
{
    var env = Env.step([0, -5, -7, -3, -7, -10, 0].reverse, [1, 1, 2, 1, 1, 2, 2] * 0.05, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 70 + 5).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 5000;
    var osc = (SinOsc.ar(8, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    HPF.ar(GVerb.ar(sig, 4, 10, 0.9) + Ringz.ar(sig, freq, mul:0.1) * 0.5, 175);
}.play;
)
(
{
    var env = Env.step([0, -5, -7, -3, -7, -10, 0].reverse, [1, 1, 2, 1, 1, 2, 2] * 0.05, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 70 - 7).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 5000;
    var osc = (SinOsc.ar(8, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    HPF.ar(GVerb.ar(sig, 4, 10, 0.9) + Ringz.ar(sig, freq, mul:0.1) * 0.5, 175);
}.play;
)