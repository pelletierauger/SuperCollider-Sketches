(
{
    var env = Env.step([0, -2, -5, -3, -5, -7, 0], [1, 1, 2, 1, 1, 2, 2] * 2, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 70 + -11).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 5000;
    var osc = (SinOsc.ar(16, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    HPF.ar(GVerb.ar(sig, 4, 10, 0.9), 175);
}.play;
)
(
{
    var env = Env.step([0, -2, -5, -3, -5, -7, 0], [1, 1, 2, 1, 1, 2, 2] * 2, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 70 + -4).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 5000;
    var osc = (SinOsc.ar(4, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    HPF.ar(GVerb.ar(sig, 4, 10, 0.9), 175);
}.play;
)

(
{
    var env = Env.step([0, -2, -5, -3, -5, -7, 0].reverse, [1, 1, 2, 1, 1, 2, 2] * 2, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 70 + 1).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 5000;
    var osc = (SinOsc.ar(16, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    HPF.ar(GVerb.ar(sig * 0.5, 4, 10, 0.9), 175);
}.play;
)