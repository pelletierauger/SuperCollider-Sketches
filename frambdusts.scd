(
~mousse.set(\gate, 0);
~mousse = {
    arg gate = 1, atk = 5, rel = 10;
    var levels = Control.names(\levels).kr([0, 4, 7, 7, 4, 2, 2].scramble + Array.fill(7, {[0, 0, 0].choose;}));
    var durations = Control.names(\durations).kr([1, 1, 2, 1, 1, 2, 2] * t.beatDur * 2);
    var env = Env.step(levels, durations, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var envRel = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    var freq = (envgen + 65 + 0).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 50000;
    var gEnv = EnvGen.kr(Env.step([4, 16, 16, 8, 32, 16], 8!6, 5, 0));
    var gresilOsc = SinOsc.kr(0.05).range(4, 32);
    var osc = (SinOsc.ar(gEnv, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    var bigOsc = SinOsc.kr(0.025).range(0.25, 1);
    var cAmp = Control.names(\amp).kr(4, 3) * 0.25;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    sig = sig * bigOsc;
    sig = HPF.ar(GVerb.ar(sig, 4, 10, 0.9) + Ringz.ar(sig, freq, mul:0.1) * cAmp * envRel, 5175);
    Out.ar(0, sig);
}.play;
)

~mousse.free;
~mousse.set(\gate, 0);
~mousse.setn(\amp, 8);

~mousse.setn(\levels, [0, 4, 7, 7, 4, 2, 2].scramble + Array.fill(6, {[-12, 0, 0].choose;}));
~mousse.setn(\levels, [0, 4, 7, 7, 4, 2, 2].scramble);
~mousse.setn(\levels, 0!7);
// [0, 4, 7, 9, 11, 2, 2]
~mousse.setn(\durations, [1, 1, 2, 1, 1, 2, 2] * t.beatDur * 16);

(
~nouvellesMousses = Task { {
    ~mousse.setn(\levels,
        [0, 4, 7, 7, 4, 2, 2].scramble
        + Array.fill(7, {[-12, 0, 0].choose;})
    );
    "Nouvelle mousse.".postln;
    16.wait;
}.loop(t);
}.start;
)
~nouvellesMousses.stop;

(
~brindilles.set(\gate, 0);
~brindilles = {
    arg gate = 1, atk = 5, rel = 10;
    var levels = Control.names(\levels).kr([0, 4, 7, 9, 11, 2, 2].scramble + Array.fill(7, {[12].choose;}));
    var durations = Control.names(\durations).kr([1, 1, 2, 1, 1, 2, 2] * t.beatDur * 2);
    var env = Env.step(levels, durations, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var envRel = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    var freq = (envgen + 65 + 0).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 50;
    var osc = (SinOsc.ar(32, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(LFNoise1.ar(2, 4, 4), 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = LFSaw.ar([freq + 1.1 + ((1 - osc) * 20), freq + 1 + ((1 - osc) * 20)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1] * 1) * 0.1 * osc;
    var bigOsc = SinOsc.kr(0.1, 0.5, 0.5);
    var cAmp = Control.names(\amp).kr(1, 3) * 0.125;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    sig = sig * bigOsc;
    sig = HPF.ar(GVerb.ar(sig, 4, 10, 0.9) + Ringz.ar(sig, freq * 0.5, decaytime: 0.8, mul:0.2) * cAmp * envRel, 175);
    Out.ar(0, sig);
}.play;
)

~brindilles.free;
~brindilles.set(\gate, 0);
~brindilles.setn(\amp, 2);

~brindilles.setn(\levels, [0, 4, 7, 9, 11, 2, 2].scramble + 12);

~brindilles.setn(\durations, [1, 1, 2, 1, 1, 2, 2] * t.beatDur * 16);

(
~nouvellesBrindilles = Task { {
    ~brindilles.setn(\levels, [0, 4, 7, 9, 11, 2, 2].scramble + 12);
    "Nouvelles brindilles.".postln;
    16.wait;
}.loop(t);
}.start;
)
~nouvellesBrindilles.stop;




(
~happyLowCloud.free;
~happyLowCloud = {
    arg gate = 1, atk = 5, rel = 10;
    var levels = Control.names(\levels).kr([0, 4, 7, 9, 11, 12, 0].scramble + Array.fill(7, {[-24].choose;}));
    var env = Env.step(levels, [1, 1, 2, 1, 1, 2, 2] * 0.05 * 8, releaseNode: 6, loopNode: 0);
    var envgen = EnvGen.kr(env);
    var envRel = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    var freq = (envgen + 65 + 0).midicps;
    var oscF = SinOsc.kr(0.01, 0.5, 0.5) + 1 * 50000;
    var osc = (SinOsc.ar(4, 0.5, 0.5) * oscF).clip(0, 1.0);
    var osc2 = (SinOsc.ar(5, 0.5, 0.5) * 500).clip(0, 1.0);
    var sig = SinOsc.ar([freq + 1.1 + ((1 - osc) * 200), freq + 1 + ((1 - osc) * 200)] * 1.005 * 1) * LFTri.ar([freq, freq + 0.1]) * 0.1 * osc;
    var bigOsc = SinOsc.kr(0.1, 0.5, 0.5);
    var cAmp = Control.names(\altAmp).kr(1, 3) * 0.25;
    // sig = sig * (1 - osc2);
    // sig = (sig * 20).clip(-1.0, 1.0) * 0.1;
    sig = sig * bigOsc;
    HPF.ar(GVerb.ar(sig, 4, 10, 0.9) + Ringz.ar(sig, freq, mul:0.1) * cAmp * envRel, 175);
}.play;
)

~happyLowCloud.setn(\altAmp, 40);
~happyLowCloud.set(\gate, 0);





(
SynthDef(\sand, {
    arg freq = 440, pan = 0, out = 0, amp = 1, sus = 0.125, atk = 0.001;
    var sig, sig2, env, sig2Env, sig2Fil, env2;
    sig = Impulse.ar(0.01, mul: 0.4)!2;
    sig2 = LFTri.ar([freq - 1, freq + 1] * 2) * LFTri.ar([freq - 1, freq + 1] * 1) * 0.4;
    env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [atk, sus * 1.5, 2]), doneAction: 2);
    env2 = EnvGen.kr(Env.new([0, 1, 0], [0.1, 0.1]));
    sig2Env = XLine.kr(1.0, 0.00001, 5.0);
    sig2Fil = XLine.kr(50.0, 9000, 0.125);
    sig2 = sig2 + PinkNoise.ar([0.5, 0.5]) * 0.5;
    sig2 = sig2 * SinOsc.kr(6, [0, pi], mul:0.5, add:0.5);
    sig2 = LPF.ar(sig2 * sig2Env, sig2Fil);
    sig = Ringz.ar(sig, [freq, freq + 2] * 1, sus);
    sig2 = Ringz.ar(sig2, [freq, freq + 2] * 2, sus);
    sig = sig + sig2;
//     sig = sig + ((sig * 10000).clip(-1.0, 1.0) * 0.1 * env2);
//     sig = sig + ((sig * 100).clip(-1.0, 1.0) * 0.05 * SinOsc.kr(16, mul:10000).clip(0.0, 1.0));
    sig = sig * env * 1.2 * amp * SinOsc.kr(6, [0, pi], mul:0.5, add:0.5);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
	Out.ar(out, sig);
}).add;
)
~sa = Synth.new(\sand, [\freq, ~toFreq.("F4") * -12.midiratio, \amp, 0.25, \sus, 10, \out, ~reverbBus]);