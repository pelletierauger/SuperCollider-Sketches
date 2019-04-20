~sig = Signal.newClear(513);
(
~sig.waveFill({
    arg x, y, i;
    // i.linlin(0, 512, -1, 1);
    // sin(x);
    sin(x.cubed * 20);
}, 0, 1);
~sig.plot;
~w = ~sig.asWavetableNoWrap;
~b = Buffer.loadCollection(s, ~w);
)
~b.setn(0, ~sigC.asWavetableNoWrap);
~b.setn(0, ~sigB.asWavetableNoWrap);
~b.setn(0, ~sig.asWavetableNoWrap);
~b.setn(0, (~sigB + (~sigA * 0.1)).asWavetableNoWrap);
(
~sigB = Signal.fill(256, { |i|
    var t = i/255.0;
    t + (0.1 * (max(t, 0.1) - 0.1) * sin(2pi * t * 80 + sin(2pi * 25.6 * t)))
});
)
(
~sigA.waveFill({
    arg x, y, i;
    // i.linlin(0, 512, -1, 1);
    // sin(x);
    sin(x.cubed * 20);
}, 0, 1);
)
~w = ~sigB.asWavetableNoWrap;
~sigA = Signal.newClear(513);
~sigB = Signal.newClear(513);
~sigC = Signal.newClear(513);
~sigB.size;
~sigC = (~sigA * 0.75) + (~sigB * 0.25);
~sigC = (~sigA * 0.9) * (~sigB * 0.1);

~sigC = (~sigA * 1) * (~sigB * 0.15);
~sigC = (~sigB * 1) + (~sigA * 0.15);
~sigC = ~sigA * ~newSig;
~sigC.overDub(~sigB);
~sigA.plot;
~sigB.plot;
~sigC.plot;
(~sigC / 1.13 - 0.5 * 2).plot;
~sigB;
~sigC = ~sigA.blend(~sigB, 2);
(~sigB + (~sigA * 0.1)).plot;
~sigC = (~sigB + (~sigA * 0.1));
(
~sigB = Signal.fill(513, { |i|
    var t = i/512.0;
    t + (0.1 * (max(t, 0.1) - 0.1) * sin(2pi * t * 80 + sin(2pi * 25.6 * t)))
});
)

~newSig = Array.interpolation(513, 0, 1);
~newSig.fill(Array.interpolation(513, 0, 1));
~newSig = Signal.newClear(513);
~newSig;

Signal[1, 2, 3, 4].blend(Signal[5, 5, 5, 0], 2);


~sigArr = {|i| ~sigA.blend(~sigB, i.linlin(0, 16, 1, 1.5));}!16;
~sigArr = {|i| (~sigB + (~sigA * i.linlin(0, 16, 0.1, 1)));}!16;
~sigArr[15].plot;

~wvArr = {|i| ~sigArr[i].asWavetableNoWrap;}!~sigArr.size;
~bArr = {|i| Buffer.loadCollection(s, ~wvArr[i]);}!~wvArr.size;

~b.bufnum;

(
SynthDef(\muddyInterp, {
    arg buf = ~b.bufnum, pan = 0, freq = 440, osc = 1, out = 0, atk = 0.1, rel = 2, amp = 1, startF = 0.01;
    var sig, index, index2, env, envf;
    envf = XLine.kr(startF, 20, 0.5);
    env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential]), doneAction: 2);
    index = SinOsc.ar(freq) * SinOsc.kr(envf, mul:0.5, add:0.5).range(0.25, 1);
    index2 = SinOsc.ar(freq + 0.1) * SinOsc.kr(envf + 0.1, mul:0.5, add:0.5).range(0.25, 1);
    sig = Shaper.ar(buf, [index, index2]) * env * amp;
    // sig = sig * LFSaw.ar([fond + 0.1, fond] * 4);
    // sig = sig + Shaper.ar(~b.bufnum, index2) * 0.5;
    sig = LeakDC.ar(sig * 0.3);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
~bArr[15].plot;
~bArrNums = {|i| ~bArr[i].bufnum;}!~bArr.size;
(
~muds2.stop;
~muds2 = Pbind(
    \instrument, \muddyInterp,
    \dur, Pseq([0.125, 0.125] * 3, inf) * 1,
    \freq, ~toFreq.("Bb3") * 2.midiratio * Pseq([7, 5, 2, 5].reverse.stutter(2).midiratio, inf) * Pseq([1, 0.5].stutter(4), inf),
    \atk, 0.00125,
    \atk, 0.25 * 1,
    // \atk, Pseq([0.00125, 0.0125, 0.125, 0.25], inf),
    \rel, 1.5 * 2,
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 1, inf),
    \startF, Pseq(Pgeom(0.1, 1.1, 48).asStream.nextN(48).mirror, inf),
    // \startF, Pseq([Plazy(~sinTime)], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \bufKey, Pseq(Pseries(0, 1, 16).asStream.nextN(16), inf),
    \buf, Pseq(~bArrNums, inf),
    // \buf, ~b.bufnum,
    \out, 0
).play(quant: 1);
)
Pseq(Pseries(0, 1, 16).asStream.nextN(16), inf);


(
10.do({ arg i;
    [1, 2, 3, 4].pyramid(i + 1).postcs;
});
)