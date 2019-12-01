







(
Pseq([0,
        Prand([1, 2, 3], 1),
        Prand([4, 5, 6], 1)
], inf).asStream.nextN(16);
)

Pseq([0, 1, 2], inf).asStream.nextN(15);


(
Pslide.new(
    [0, 1, 2],
    repeats: 1,
    len: 6,
    step: 1,
    start: 0,
    wrapAtEnd: true
).asStream.nextN(6);
)

(Pseq([55,
    (
Pslide.new(
    [0, 1, 2],
    repeats: 1,
    len: 6,
    step: 1,
    start: 0,
    wrapAtEnd: true
);
)
], inf).asStream.nextN(15);
)



(
var a, b;
a = Pseq([1, 2, 3], 2);
b = Pseq([65, 76]);
c = Pswitch([a, b, 800], Pseq([2, 2, 0, 1], inf));
x = c.asStream;
24.do({ x.next.postln; });
)


(
var a, b;
a = Pseq([24]);
b = Pseq([5, 3, 5]);
c = Pseq([7, 7, 7]);
d = Pswitch([a, b, c], Pseq([0, 1, 0, 2], inf));

)

~pizziSamples[0].play;
~pizziSamples[Pseq([0, 1, 2], inf).asStream.next].play;

Pseq([0, 1, 2], inf).asStream.next;
Pseq([0, 1, 2], inf).asStream.nextN(1);


(
SynthDef(\pizzi, {
    arg buf = 0, rate = 1,
    spos = 0, pan = 0, amp = 1, out = 0,
    flip = 0;
    var buffer, sig, lfo;
    // buffer = ~pizziSamples.[buf];
    // env = EnvGen.kr(Env.new([1, 0], [8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
(
SynthDef(\pizziFlip, {
    arg buf = 0, rate = 1,
    spos = 0, pan = 0, amp = 1, out = 0,
    flip = 0;
    var buffer, sig, lfo;
    // buffer = ~pizziSamples.[buf];
    // env = EnvGen.kr(Env.new([1, 0], [8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * amp;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    Out.ar(out, sig);
}).add;
)
(
~piz2.stop;
~piz2 = Pbind(
    // \instrument, Pseq([\pizzi, \pizziFlip].stutter(1), inf),
    \instrument, Pseq(\pizzi!2 ++ (\pizziFlip!3), inf),
    // \instrument, \pizzi,
    \dur, Pseq([0.75, 0.25, 0.5, 0.25, 0.25] * 1, inf),
    \amp, Pseq([1, 0.5] ++ (1!3), inf) * 3,
    \rate, -5.midiratio,
    \num, Pseq([4, 4, -2, 3, 5], inf) + Pseq([3, 4].stutter(5), inf),
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)

(
~pizHat.stop;
~pizHat = Pbind(
    // \instrument, Pseq([\pizzi, \pizziFlip].stutter(1), inf),
    \instrument, Pseq(\pizzi!1 ++ (\pizziFlip!1), inf),
    // \instrument, \pizzi,
    \dur, Pseq([Rest(0.5), 0.5] * 1, inf),
    \amp, Pseq([1, 1], inf) * 3,
    \rate, 0.midiratio,
    \num, Pseq([11], inf),
    \buf, Pindex.new(~pizziSamples, Pkey(\num), inf)
).play(t, quant: [1]);
)