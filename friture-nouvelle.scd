


(
SynthDef.new(\friture, {
    arg out = 0, freq = 440, pan = 0, atk = 1, dec = 1, rel = 2, sustain = 0.001, amp = 1, gate = 1, fm1freq = 4.001, lpff = 5000;
    var sig, env, lfo, envf, env2;

    // Safety measures to constrain values within reasonable bounds.
    // Important because I alter these values often, and quickly, during
    // the performance. Typing mistakes must not create audio accidents.
    fm1freq = min(max(fm1freq, 0.500125), 16);
    freq = min(max(freq, 50), 3000);
    amp = min(max(amp, 0), 15);

//     env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    env = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [atk, rel]));
    env2 = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [atk, rel * 3]), doneAction:2);
    sig = SinOsc.ar([freq, freq + 1], width: 0.9) * 0.1;
    // sig = LFTri.ar([freq, freq + 1]) * 0.1;
    sig = sig * LFTri.ar([freq - 1, freq] * 0.125 * fm1freq);
    sig = sig * LFTri.ar([freq + 1, freq - 1] * 0.25 * 1.01, width: 0.2);
    sig = sig * amp * env;
    envf = XLine.kr(10000.0, 500.0, 0.1);
    sig = LPF.ar(sig, envf);
//     sig = sig * 0.5 + Ringz.ar(sig, freq * 1, decaytime: 0.1, mul:0.2);
//     sig = HPF.ar(sig, 2000);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}, 8!10).add;
)


(
~nouvelleFriture.stop;
~nouvelleFriture = Pbind(
    \instrument, \friture,
    \dur, Pseq([Pwhite(0.05, 0.1).stutter(24) * 2], inf),
    \dur, Pseq([0.25, 0.25, 0.5, 0.5] * 1, inf) * 0.25,
//     \freq, ~toFreq.("Db6") * Pseq([Prand([0.5, 1, 2], inf)].stutter(8), inf),
//     \freq, ~toFreq.("Db6") * Prand([0, 2, 4, 5, 7, 11], inf).stutter(48).midiratio,
    \freq, ~toFreq.("F5") *
    Pseq([0, 2, 4, 5, 0, 2, 5, 7].reverse.midiratio.stutter(2), inf) *
    Pseq([1, 2].stutter(32), inf) * Prand([0.5, 1].stutter(4), inf),
    \amp, Pseq([2, 0.5], inf) * 4,
    \rel, 0.75,
    \atk, 0.1,
//     \lpff, Pwhite(5000, 20000, inf).stutter(16).round,
    \lpff, 20000,
    \sustain, 0.001,
//     \fm1freq, Prand([4.001, 2.001, 1.001].stutter(8), inf),
    \fm1freq, 4.001 * 0.5,
    \fm1freq, 4.001 * Pseq([0.5, 1], inf),
    \pan, Pwhite(-1.0, 1.0, inf),
    \out, 0
).play(t, quant: 1);
)
