s.boot;

(
SynthDef.new(\simplest, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.2, rel = 1;
    var sig, env;
    rel = min(max(rel, 0.001), 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = LFTri.ar([freq, freq + 0.1]) * 0.1;
    // sig = sig * SinOsc.ar([freq, freq + 0.1] * 2);
    // sig = sig * SinOsc.ar([freq, freq + 0.1] * 1);
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

f = 330;
// Just intonation
// I normal
(
Synth.new(\simplest, [\freq, f * 0.5, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 5 / 4, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 3 / 2, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 15 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)

// iii normal
(
Synth.new(\simplest, [\freq, f * 5 / 4 * 0.5, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 5 / 4, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 3 / 2, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 15 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)

// ii offseté
(
Synth.new(\simplest, [\freq, f * 9 / 8 * 0.5, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 6 / 5 * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 3 / 2 * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
// Synth.new(\simplest, [\freq, 410 * 9 / 5 * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)

// iii offseté
(
Synth.new(\simplest, [\freq, f * 9 / 8 * 0.5 * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 9 / 8 * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 6 / 5 * 9 / 8 * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 3 / 2 * 9 / 8 * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
// Synth.new(\simplest, [\freq, 410 * 9 / 5 * 9 / 8, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)


// Equal-tempered
// I
(
Synth.new(\simplest, [\freq, f * 0.5, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 4.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 7.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 11.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)

// ii
(
Synth.new(\simplest, [\freq, f * 2.midiratio * 0.5, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 2.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 3.midiratio * 2.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 7.midiratio * 2.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
// Synth.new(\simplest, [\freq, 410 * 11.midiratio * 2.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)

// iii
(
Synth.new(\simplest, [\freq, f * 4.midiratio * 0.5, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 4.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 3.midiratio * 4.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, f * 7.midiratio * 4.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
// Synth.new(\simplest, [\freq, 410 * 11.midiratio * 2.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)