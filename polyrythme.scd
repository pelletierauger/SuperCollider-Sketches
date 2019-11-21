(
t = TempoClock.new;
t.tempo_(65/60);
)
t.tempo_(50/60);

t.tempo_(40/60);
(
~oceanBlue.stop;
~oceanBlue = Pbind(
    \instrument, \ponddrop,
    \dur, Pseq((1/3!3) ++ (1/5!5), inf) * Pseq([1, 1, 1, 1, 1, 1, 1, 1], inf),
    \freq, ~toFreq.("F4") * 2 * Pseq((5!3) ++ (2!5) ++ (0!3) ++ (-2!5), inf).midiratio
    * Pseq([0, -2].stutter(16).midiratio, inf),
    \atk, 0.03,
    \freqOsc, 20 * 0.25,
    \triMod, Pseq([0.5, 0.501], inf) * Pseq([1, 2], inf),
    \dec, 0.5,
    \amp, 7.7 * Pseq([1, 1.75], inf) * 0.5 * Pseq([1, 0.5!2, 1, 0.5!4].flat, inf),
    \rel, 0.25,
    \pan, Pwhite(-0.25, 0.25, inf),
    \out, ~reverbBus
).play(t, quant: [1]);
~oceanBlue2.stop;
~freq2 = ([0, -5]!2!2).flat ++ ([0, -7]!2!2).flat ++ ([-3, -7]!2!1).flat ++ ([-4, -7]!2!1).flat;
~oceanBlue2 = Pbind(
    \instrument, \ponddrop,
    \dur, Pseq([1/2], inf),
    \freq, ~toFreq.("F3") * [0.5, 1, 2] * Pseq(~freq2.stutter(2), inf).midiratio,
    \atk, 1.5 * 2,
    \freqOsc, 20 * 0.25,
    \triMod, Pseq([0.5, 0.501], inf) * Pseq([1, 1/2], inf),
    \dec, 4,
    \amp, 7.7 * Pseq([1, 1.75], inf) * 0.125 * 0.5,
    \rel, Pseq([1, 2], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~reverbBus
).play(t, quant: [1]);
)

(([0, -5]!2!2).flat ++ ([0, -7]!2!2).flat ++ ([-3, -7]!2!2).flat).size
([0, -5]!2!2).flat ++ ([0, -7]!2!2).flat ++ ([-3, -7]!2!2).flat


((5!3) ++ (2!5) ++ (0!3) ++ (-2!5)).size
[1/3, 2/3, 1/5, 4/5].sum

Pseq([1], inf).midiratio.asStream.nextN(4);