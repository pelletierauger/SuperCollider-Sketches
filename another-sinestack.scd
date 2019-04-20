s.boot;

(
SynthDef.new(\simplest, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 1, clipAmp = 2;
    var sig, env;
    rel = min(max(rel, 0.001), 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = (sig * clipAmp).clip(-1.0, 1.0);
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
Synth.new(\simplest, [\freq, 440, \amp, 0.25, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5), \clipAmp, 80000]);
// Synth.new(\simplest, [\freq, ~toFreq.("A3") * 5.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
// Synth.new(\simplest, [\freq, ~toFreq.("A3") * -8.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)


.do({Synth.new(\simplest, [\freq, 440, \amp, 0.25, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5), \clipAmp, 80000]);
});

(
Array.fill(50, {|i| i * 1}).do(
    {
        |i|
        Synth.new(\simplest, [
            \freq, 30 + (i * 0.1) * [0, 4, 7, 11, 14].choose.midiratio * [1, 2, 4, 8].choose,
            \freq, 30.87 + (i * 0.0125) * [0, 7, 12, 15].choose.midiratio,
            \amp, 0.5, \atk, 0.75, \out, 0, \rel, 10,
            \pan, rrand(-0.75, 0.75), \clipAmp, 1 + (i * rrand(1, 50))
        ])
});
nil;
)

Array.fill(4, {|i| i * 2}).do({|i| (i + 1).postln;});