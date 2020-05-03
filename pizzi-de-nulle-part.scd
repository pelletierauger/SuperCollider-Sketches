(
~pizziSamples = Array.new;
~pizziFolder = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/pizzi/");
~pizziFolder.entries.do({
    arg path;
    ~pizziSamples = ~pizziSamples.add(Buffer.read(s, path.fullPath));
});
)

t = TempoClock.new;
t.tempo_(86/60);
t.permanent = true;
(
SynthDef(\pizzi, {
    arg buf = 0, rate = 1, spos = 0, pan = 0, amp = 1, out = 0;
    var buffer, sig, lfo;
    // buffer = ~pizziSamples.[buf];
    // env = EnvGen.kr(Env.new([1, 0], [8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    sig = LPF.ar(sig, 3000);
    Out.ar(out, sig);
}).add;
)

(
~piz.stop;
~piz = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([0.5] * 1, inf),
    \amp, Pseq([1, 0.25], inf) * 32,
    \buf, Pseq([~pizziSamples[7], ~pizziSamples[6]].stutter(2), inf),
    \rate, 0.75
).play(t, quant: [1]);
)

[0.25, 0.5, 0.5, 0.75].sum
(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([1, 0.5, 0.5], inf),
    \amp, Pseq([1, 1], inf) * 3,
    \rate, 1,
    \buf, Pseq([~pizziSamples[0], ~pizziSamples[11], ~pizziSamples[11]].stutter(1), inf),
    \rate, 0.75
).play(t, quant: [1]);
)

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([1.75, 0.25], inf),
    \amp, Pseq([1, 0.5], inf) * 3 * 4,
    \rate, -5.midiratio,
    \buf, Pseq([~pizziSamples[1], ~pizziSamples[2]].stutter(1), inf),
    \rate, 0.75
).play(t, quant: [1]);
)
~pizziSamples.[0]