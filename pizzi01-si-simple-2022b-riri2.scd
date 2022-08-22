(
~pizziSamples = Array.new;
~pizziFolder = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/pizzi/");
~pizziFolder.entries.do({
    arg path;
    ~pizziSamples = ~pizziSamples.add(Buffer.read(s, path.fullPath));
});
)

~t = TempoClock.new(86/60).permanent_(true);
t.tempo_(86/60);
(
SynthDef(\pizzi, {
    arg buf = 0, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, out2 = ~bu;
    var buffer, sig, lfo;
    // buffer = ~pizziSamples.[buf];
    // env = EnvGen.kr(Env.new([1, 0], [8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * amp;
    // sig = VadimFilter.ar(sig, 6000, 0, 1);
    // sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar([out, out2], sig);
}).add;
)
~bu = Bus.audio(s, 2)
(
~xx.free;
~xx = {
    var in = In.ar(~bu, 2);
    MiRings.ar(in, pit: ~toMidi.("C3") - 4,
        struct: 0.25, bright: 0.25, damp: MouseX.kr(), pos: 0.25, model: 0
    ) * 2;
}.play;
)

~bu2 = Bus.audio(s, 2)
(
~xxx.free;
~xxx = {
    var in = In.ar(~bu2, 2);
    MiRings.ar(in, pit: ~toMidi.("C3") - 5,
        struct: 0.25, bright: 0.25, damp: MouseX.kr(), pos: 0.25, model: 0
    ) * 2;
}.play;
)

(
~piz.stop;
~piz = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([0.25] * 1, inf),
    \amp, Pseq([1, 0.5, 0.5, 0.5], inf) * 20,
    \buf, Pindex(~pizziSamples, Pseq([6], inf), inf),
    \out2, Pseq([~bu, ~bu2].stutter(16), inf)
).play(~t, quant: [4]);
)

[0.25, 0.5, 0.5, 0.75].sum
(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([0.5], inf),
    \amp, Pseq([1, 1], inf) * 3,
    \rate, 1,
    \buf, Pseq([~pizziSamples[4], ~pizziSamples[11], ~pizziSamples[11]].stutter(1), inf)
).play(~t, quant: [1]);
)

(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzi,
    \dur, Pseq([1], inf),
    \amp, Pseq([Rest(), 0.5], inf) * 6,
    \rate, 0.midiratio,
    \buf, Pindex(~pizziSamples, Pseq([1, 5], inf), inf),
    \out2, Pseq([~bu, ~bu2].stutter(4), inf)
).play(~t, quant: [4]);
)
~pizziSamples.[0]


(
v.free;
v = {
    var trig, sig;
    trig = Impulse.kr(~t.beatDur.reciprocal * 0.5);
    sig = MiPlaits.ar(55 - 24 - 5,
        engine: 13,
        harm: 0.5,
        timbre: 0.2,
        morph: 0.5,
        trigger: trig,
        decay: 0.1
    );
    sig = sig[0]!2 * 4;
}.play;
)

(
w.free;
w = {
    var trig, sig;
    trig = Impulse.kr(7.5 * 0.125);
    sig = MiPlaits.ar(55 - 24,
        engine: 15,
        harm: 0.05,
        timbre: 0.6,
        morph: 0.2,
        trigger: trig
    );
    sig = sig[0]!2 * 1;
}.play;
)