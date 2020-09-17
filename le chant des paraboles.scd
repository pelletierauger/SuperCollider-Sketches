(
SynthDef(\parabolic, {
    arg buf = b, freq = 220, rate = 1, spos = 0, pan = 0, amp = 1, rel = 1, atk = 0.1, out = 0;
    var x, y, env;
    var e = Env.new([0, 1, 0], [0.01, rel]);
        env = EnvGen.kr(e, doneAction: 2);
        x = Phaser.ar(freq * 0.5!2, 0) - 0.5 * 2;
        y = x * x - 0.5 * 2;
        y = y * amp * env;
    Out.ar(out, y);
}).add;
)

(
~melo.stop;
~melo = Pbind(
    \instrument, \parabolic,
    \dur, Pseq([0.5], inf),
    \freq, ~toFreq.("A3") * Pseq([7, 9].midiratio.stutter(16), inf),
    \amp, Pseq([Pseries(1, -1/16, 16)], inf) * 0.2,
    \atk, 0.001,
    \rel, 1
).play(quant: [2, 0.25]);
~melo2.stop;
~melo2 = Pbind(
    \instrument, \parabolic,
    \dur, Pseq([0.5], inf),
    \freq, ~toFreq.("A3") * Pseq([4, 2, 0, 2].midiratio.stutter(1), inf),
    \amp, Pseq([Pseries(1, -1/16, 8)], inf) * 0.2,
    \atk, 0.001,
    \rel, 1
).play(quant: [2, 0.25]);
~melo3.stop;
~melo3 = Pbind(
    \instrument, \parabolic,
    \dur, Pseq([2], inf),
    \freq, ~toFreq.("A2") * Pseq([0, -5, 0, -5, -3, -8, -3, -8].midiratio.stutter(1), inf),
    \amp, 0.2,
    \atk, 0.001,
    \rel, 2
).play(quant: [2, 0.25]);
)

(
~melo4.stop;
~melo4 = Pbind(
    \instrument, \parabolic,
    \dur, Pseq([0.125 * 0.5], inf),
    \freq, ~toFreq.("A4") * Pseq([0, 2, 4, 7, 9, 7, 4, 2].midiratio.stutter(1), inf)
    * Pseq([0, 12, 24, 12].midiratio.stutter(8), inf),
    \amp, Pseq([Pseries(1, -1/16, 8)], inf) * 0.125,
    \atk, 0.001,
    \rel, 0.05
).play(quant: [2, 0.25]);
~melo5.stop;
~melo5 = Pbind(
    \instrument, \parabolic,
    \dur, Pseq([1, Rest(1), 1, 1] ++ [Rest(1), 1, 1, Rest(1)] * 0.25, inf),
    \freq, ~toFreq.("A7") * Pseq([0].midiratio.stutter(16), inf),
    \amp, 0.25,
    \atk, 0.0001,
    \rel, 0.01
).play(quant: [2, 0.25]);
~melo6.stop;
~melo6 = Pbind(
    \instrument, \parabolic,
    \dur, Pseq([1], inf),
    \freq, ~toFreq.("A2") * Pseq([0].midiratio.stutter(16), inf),
    \amp, 0.5,
    \atk, 0.0001,
    \rel, 0.01
).play(quant: [2, 0.25]);
)

(
var chord = [0, 2, 4, -5, 11] ++ [4, -5, 7, 11, 14];
chord = chord ++ [4, -8, 9, 14, 16] ++ (12 + [-3, 2, 4, -8, -1]);
~harmo.stop;
~harmo = Pbind(
    \instrument, \parabolicslide,
    \dur, Pseq((0!4) ++ 4, inf),
    \freq, ~toFreq.("A3") * Pseq(chord.midiratio.stutter(1), inf),
    \amp, Pseq([Pseries(1, -1/16, 8)], inf) * 0.2,
    \atk, 0.001,
    \rel, 4
).play(quant: [2, -0.25]);
)


(
SynthDef(\parabolicslide, {
    arg buf = b, freq = 220, rate = 1, spos = 0, pan = 0, amp = 1, rel = 1, atk = 0.1, out = 0;
    var x, y, env;
    var e = Env.new([0, 1, 0], [0.01, rel]);
        env = EnvGen.kr(e, doneAction: 2);
    freq = freq * Line.ar(1 * -2.midiratio, 1, 0.5);
        x = Phaser.ar(freq * 0.5!2, 0) - 0.5 * 2;
        y = x * x - 0.5 * 2;
        y = y * amp * env;
    Out.ar(out, y);
}).add;
)
