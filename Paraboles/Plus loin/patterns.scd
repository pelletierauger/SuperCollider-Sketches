(
~hats.stop;
~hats = Pbind(
    \instrument, Pseq([\sampler2, \sampler].stutter(1), inf),
    \dur, Pseq([0.5, 0.25, 0.15, 0.15], inf),
    \rate, Pseq([9 + 12, 4 + 12].midiratio.stutter(16), inf) * Pseq([1, 0.5].stutter(1), inf),
    \amp, Pseq([0.4, 0.2].stutter(8), inf) * Pseq([1, 0.5, 0.75, 0.5].stutter(1), inf),
    \atk, 0.001, 
    \rel, 0.5
).play(quant: [2]);
)

(
~melo0.stop;
~melo0 = Pbind(
    \instrument, \sampler,
    \dur, Pseq([0.75, 0.75, 0.5], inf),
    \rate, Pseq([9 - 24].midiratio.stutter(20), inf),
    \amp, 1, 
    \atk, 0.001, 
    \rel, 0.05
).play(quant: [2]);
)

(
~melo.stop;
~melo = Pbind(
    \instrument, \sampler,
    \dur, Pseq([0.5], inf),
    \rate, Pseq([6, 7, 6, 7, 9].midiratio.stutter(16), inf),
    \amp, Pseq([Pseries(1, -0.1, 16)], inf), 
    \atk, 0.001, 
    \rel, 0.05
).play(quant: [2, 0.25]);
~melo2.stop;
~melo2 = Pbind(
    \instrument, \sampler,
    \dur, Pseq([0.5], inf),
    \rate, Pseq([4, 2, 0, 2].midiratio.stutter(1), inf),
    \amp, Pseq([Pseries(1, -0.1, 16)], inf), 
    \atk, 0.001, 
    \rel, 0.05
).play(quant: [2, 0.25]);
)


(
var amp = 0.35;
Synth(\sampler, [\rate, -6.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -22.midiratio, \amp, 4 * amp, \atk, 1]);
Synth(\sampler, [\rate, 4.midiratio, \amp, 1 * amp, \atk, 1]);
)
(
var amp = 0.35;
Synth(\sampler, [\rate, -5.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -24.midiratio, \amp, 4 * amp, \atk, 1]);
Synth(\sampler, [\rate, 2.midiratio, \amp, 1 * amp, \atk, 1]);
)
(
var amp = 0.25;
Synth(\sampler, [\rate, -7.midiratio, \amp, 1 * amp, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, (-19 - 12).midiratio, \amp, 8 * amp, \atk, 1]);
Synth(\sampler, [\rate, 0.midiratio, \amp, 1 * amp, \atk, 1]);
)




// bonheur
(
var amp = 0.35;
Synth(\sampler, [\rate, -8.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -20.midiratio, \amp, 4 * amp, \atk, 1]);
Synth(\sampler, [\rate, 1.midiratio, \amp, 1 * amp, \atk, 1]);
)

(
var amp = 0.35;
Synth(\sampler, [\rate, -10.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -22.midiratio, \amp, 4 * amp, \atk, 1]);
Synth(\sampler, [\rate, -1.midiratio, \amp, 1 * amp, \atk, 1]);
)
(
var amp = 0.35;
Synth(\sampler, [\rate, -7.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -22.midiratio, \amp, 8 * amp, \atk, 1]);
Synth(\sampler, [\rate, 2.midiratio, \amp, 1 * amp, \atk, 1]);
)
(
var amp = 0.35;
Synth(\sampler, [\rate, -11.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -15.midiratio, \amp, 2 * amp, \atk, 1]);
Synth(\sampler, [\rate, -27.midiratio, \amp, 8 * amp, \atk, 1]);
Synth(\sampler, [\rate, -3.midiratio, \amp, 1 * amp, \atk, 1]);
)



(
SynthDef(\sampler2, {
    arg buf = b, rate = 1, spos = 0, pan = 0, amp = 1, rel = 8, atk = 0.1, out = 0;
    var sig, env, lfo, lft, rgt;
    lft = Rand.new(0.9995, 1.0005);
    rgt = Rand.new(0.9995, 1.0005);
    lfo = SinOsc.kr(6).range(0.75, 1);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(1, b, rate * BufRateScale.ir(buf) * [lft, rgt], startPos: spos * 176400);
    sig = sig * env;
    sig = sig * amp;
//     sig = LPF.ar(sig, 3200);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)