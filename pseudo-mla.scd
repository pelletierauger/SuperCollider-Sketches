(
{
    var env = Env.step([0, -2, -5, -4, -5, -7, 0], [1, 1, 2, 1, 1, 2, 2] * 0.1, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 70 + -4).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 50;
    var osc = (SinOsc.ar(9, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 5000).clip(0, 1.0);
    var sig = LFTri.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    sig * 0.275;
}.play;
)

(
{
    var env = Env.step([0, -2, -5, -4, -5, -7, 0], [1, 1, 2, 1, 1, 2, 2] * 0.2, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 70 + -4 - 12).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 50;
    var osc = (SinOsc.ar(4.5, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 5000).clip(0, 1.0);
    var sig = LFTri.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    sig * 0.5;
}.play;
)