s.boot;

~marim1 = Buffer.read(s, "/Users/guillaumepelletier/Downloads/15684__samulis__marimba-samples/255679__samulis__marimba-a4.wav");


(
SynthDef(\marimba, {
    arg buf = ~marim1, rate = 1, spos = 0, pan = 0, amp = 1;
    var sig, env;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.001, 3.75]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan + 0.4, 1);
    Out.ar(0, sig);
}).add;
)


Synth.new(\marimba, [\amp: 10]);
Synth.new(\pulse, [\freq: 880 * -5.midiratio, \sus: 8, \amp: 10]);


(
Event.addEventType(\marimFunc, {
    // if (~rate == 0.5, {~rate.postln});
    ~rate = ~rate * [-7,5].choose.midiratio;
    Synth.new(\marimba, [
        \amp: ~amp,
        \rate: ~rate * 1,
        \pan: ~pan
    ]);
    Synth.new(\pulse, [
        \amp: ~amp * 0.1,
        \sus: 4,
        \freq: ~rate * 440 * 2,
        \pan: ~pan
    ]);
})
)


(
p.stop;
p = Pbind(
    \type, \marimFunc,
    \dur, Pseq([0.5, 0.5, 1, 1], inf) * Pseq([Pseq([0.5], 4), Pseq([0.25], 4)], inf) * 1,
    \rate, Pseq([1 * -2.midiratio, 1 * 4.midiratio, 1 * 7.midiratio, 1 * 4.midiratio] * 0.5, inf),
    \amp, Pseq([10, 6, 8, 6], inf) * Pwhite(0.7, 1.3, inf) * 16,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(quant: 1);
)

(
~p2.stop;
~p2 = Pbind(
    \type, \marimFunc,
    \dur, Pseq([0.5, 0.5, 1, 1], inf) * Pseq([Pseq([0.25], 8), Pseq([0.125], 8)], inf),
    \rate, Pseq([1, 1 * 4.midiratio, 1 * 7.midiratio, 1 * 4.midiratio] * 1, inf),
    \amp, Pseq([10, 6, 8, 6], inf) * Pwhite(0.7, 1.3, inf) * 2,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(quant: 1);
)

(
~p3.stop;
~p3 = Pbind(
    \type, \marimFunc,
    \dur, Pseq([1, 2], inf) * Pseq([Pseq([0.125], 16), Pseq([0.125 * 0.5], 16)], inf),
    \rate, Pseq([1, 1 * 4.midiratio, 1 * -5.midiratio, 1 * 4.midiratio] * 1, inf),
    \amp, Pseq([10, 6, 8, 6], inf) * Pwhite(0.7, 1.3, inf) * 3,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(quant: 1);
)

(
~p4.stop;
~p4 = Pbind(
    \type, \marimFunc,
    \dur, Pseq([3], inf) * Pseq([2, 1], inf) * 1,
    \rate, Pseq([0.25, 0.5], inf),
    \amp, Pseq([10, 6, 8, 6], inf) * Pwhite(0.7, 1.3, inf) * 16,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(quant: 1);
)


(
~p5.stop;
~p5 = Pbind(
    \type, \marimFunc,
    \dur, Pseq([0.5, 0.5, 1, 1], inf) * Pseq([Pseq([0.5], 4), Pseq([0.25], 4)], inf) * 2,
    \rate, Pseq([1 * -2.midiratio, 1 * 4.midiratio, 1 * 7.midiratio, 1 * 4.midiratio] * 0.5, inf),
    \amp, Pseq([10, 6, 8, 6], inf) * Pwhite(0.7, 1.3, inf) * 16,
    \pan, Pwhite(-0.5, 0.5, inf)
).play(quant: 1);
)