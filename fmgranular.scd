
(
SynthDef.new(\fmgranular, {
    arg freq = 440, amp = 1, rel = 4, pan = 0, op2f = 1;
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.2, 0.2], [3, -3]), doneAction: 2);
    var op2 = SinOsc.ar(f * op2f);
    var op1 = SinOsc.ar(f * [1, 1.001], op2 * 0.9) * 0.1 * env * amp;
    var sig = op1;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    Out.ar(0, sig);
}).add;
)

(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \fmgranular,
    \dur, 1/128,
    \freq, ~toFreq.("D4") * Prand([0, 4, 7, 11].midiratio, inf),
    \op2f, Prand([0.5, 1], inf),
    \amp, 1.125,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(~t2);
)