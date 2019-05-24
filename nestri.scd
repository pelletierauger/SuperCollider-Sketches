Nes2


{Nes2Triangle.ar(Impulse.kr(1), 0, 123, [880, 881], 2)}.play;
{Nes2Triangle.ar(Impulse.kr(8), 0, 123, [220, 221], 10)}.play;
{Nes2Triangle.ar(Impulse.kr(8), 0, 123, [441, 440] * -8.midiratio, 10)}.play;
{Nes2Triangle.ar(Impulse.kr(8), 0, 123, [440, 441] * -5.midiratio, 10)}.play;


{Nes2.ar(Impulse.kr(3!2), a0:2r00010111, a2:2r10000000, smask:2r00000001)}.play;



//--triangle
{Nes2.ar(Impulse.kr(3), c0:2r11000100, c2:200!2, smask:2r00000100)}.play;
{Nes2.ar(Impulse.kr(3), c0:2r11000100, c2:180!2, smask:2r00000100)}.play;
{Nes2.ar(Impulse.kr(1), a0:2r10010100, c0:2r11000100, c2:55!2, smask:2r00001000)}.play;


(
SynthDef.new(\nestri, {
        arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 1;
    var sig, env;
    rel = min(max(rel, 0.001), 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = Nes2Triangle.ar(Impulse.kr(1), 1, 123, [freq, freq + 1]) * 1;
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

Synth.new(\nestri, [\rel, 0.1, \freq, 880]);


(
~pianoB.stop;
~pianoB = Pbind(
    \instrument, \nestri,
    \dur, Pseq([1, 0.5, 0.5] * 0.5, inf),
    \freq, Pseq([440, 220, 220], inf)
).play(t, quant: 4);
)

(
~piano.stop;
~piano = Pbind(
    \instrument, \nestri,
    \dur, Pseq([0.5] * 0.125, inf),
    \freq, 110 * Pseq([-5, -7, -5, -3].midiratio.stutter(8), inf),
    \atk, 0.001,
    \rel, 0.125
).play(t, quant: 4);
)

(
~pianoC.stop;
~pianoC = Pbind(
    \instrument, \nestri,
    \dur, Pseq([1], inf),
    \freq, Pseq([880, 880 * 7.midiratio], inf),
    \rel, 0.25,
    \amp, 1
).play(t, quant: 4);
)