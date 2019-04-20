(
{
    var env = Env.step([0, -5, -3, 7], [1, 1, 2, 2] * 2, releaseNode: 3, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 65).midicps;
    var osc = (SinOsc.ar(0.25, 0.5, 0.5) * 5000).clip(0, 1.0);
    var osc2 = (SinOsc.ar(10, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 20), freq + 1 + ((1 - osc) * 20)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    HPF.ar(GVerb.ar(sig, 4, 10, 0.9) + Ringz.ar(sig, freq, mul:0.1), 75);
}.play;
)

FreqScope

FreqScope.new(width: 522, height: 300, server:s);
Env.step([0, 3, 5, 2, 7, 3, 0, 3, 4, 0], [0.5, 0.1, 0.2, 1.0, 1.5, 2, 0.2, 0.1, 0.2, 0.1]).plot;


Env([0.1, 1, 0.1], [1, [1, 2, 3]], \exp).plot;


Env([[0, 0.01], 1, 0], [0.5, 0.5], [[\lin, \exp], \step]).plot;

Env([1, [ 1, 2, 3, 4, 5 ], 0.5, [3, 2, 1], 2], [1, 0.5, 1, 0.25], [[\exp, \lin]]).plot;

1!5;

(1!2) ++ 2!2
(1!2 ++ (2!2)).flatten;


(
{
    var env = Env.step([0, -5, -3, 2], [1, 1, 2, 2] * 0.5, releaseNode: 3, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var freq = (envgen + 65 - 0).midicps;
    var osc = (SinOsc.ar(0.25, 0.5, 0.5) * 5000).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 20), freq + 1 + ((1 - osc) * 20)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    HPF.ar(GVerb.ar(sig, 4, 10, 0.9) + Ringz.ar(sig, freq, mul:0.1), 75);
}.play;
)