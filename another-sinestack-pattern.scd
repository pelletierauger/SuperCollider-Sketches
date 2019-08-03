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
            \freq, 30.87 + (i * 0.0025) * [-12, 3, 7, 0].choose.midiratio * 16 * -7.midiratio,
            \amp, 0.05 * 0.5, \atk, 0.75, \out, 0, \rel, 15,
            \pan, rrand(-0.75, 0.75), \clipAmp, 1 + (i * rrand(1, 50))
        ])
});
nil;
)

Array.fill(4, {|i| i * 2}).do({|i| (i + 1).postln;});


(
Event.addEventType(\stack, {
    var no = ~num;
    Array.fill(50, {|i| i * 1}).do(
    {
        |i|
        Synth.new(\simplest, [
            \freq, 30 + (i * 0.1) * [0, 4, 7, 11, 14].choose.midiratio * [1, 2, 4, 8].choose,
            \freq, 30.87 + (i * ~offset) * [0, 0, 12, 12].choose.midiratio * ~oct * no.midiratio,
            \amp, 0.015 * 0.5, \atk, ~attack, \out, 0, \rel, ~release,
            \pan, rrand(-0.75, 0.75), \clipAmp, 1 + (i * rrand(1, 50))
        ])
    });
})
)

(
    ~p1.stop;
    ~p1 = Pbind(
        \type, \stack,
        \dur, Pseq([4, 2, 2] * 0.125 * 0.5, inf),
    \oct, Prand([2, 4], inf),
    \offset, Pwhite(0.0025, 0.005, inf),
    \release, Pwhite(0.125, 0.5, inf),
        \attack, Pwhite(0.0075, 0.025, inf),
        \num, Pseq([0, 3, 0, 7], inf)
    ).play;
)