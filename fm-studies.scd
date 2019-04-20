(
SynthDef.new(\simplest, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 0.02, rel = 1;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2;
    osc = LFTri.ar(6, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.025, 0.1 * osc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, 0.025, 0.1 * osc]));
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.1, freq + 0.2] * 1, pi) * 0.02);
    sig = sig * env * amp;
    sig = (sig * loopEnv) * (1 + LFTri.ar([freq + 1, freq + 1.1] * 1.001 * loopEnv2, mul: loopEnv * 1) * (1 + WhiteNoise.ar(mul: loopEnv * 0.1)));
    // sig = sig * LFTri.ar([freq + 0.1, freq + 0.2] * 4);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
Synth.new(\simplest, [\freq, ~toFreq.("A3") * 12.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, ~toFreq.("A3") * 5.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, ~toFreq.("A3") * -8.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)


;